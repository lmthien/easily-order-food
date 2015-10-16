class MtxProductsController < ApplicationController
  layout "admin"
  helper_method :sort_column, :sort_direction
  include MtxUserHelper
  load_and_authorize_resource
  before_action :set_mtx_product, only: [:show, :edit, :update, :destroy]

  # GET /mtx_products
  # GET /mtx_products.json
  def index
    #@mtxProducts = MtxProduct.all
    #This below source code is used to pagination
    #@mtxProducts = MtxProduct.includes(:mtx_product_languages).order(sort_column + " " + sort_direction).page(params[:page]).per(3)
    @mtxProducts = MtxProduct.includes(:mtx_product_languages).order(sort_column + " " + sort_direction)
  end

  # GET /mtx_products/1
  # GET /mtx_products/1.json
  def show
    @product = MtxProduct.find(params[:id])
    @productLang = @product.mtx_product_languages.first
  end

  # GET /mtx_products/new
  def new
    @mtxProduct = MtxProduct.new
    @productLang = MtxProductLanguage.new
    @productLang.mtx_product = @mtxProduct
  end

  # GET /mtx_products/1/edit
  def edit
    @product = MtxProduct.find(params[:id])
    @productLang = @product.mtx_product_languages.first
  end

  # POST /mtx_products
  # POST /mtx_products.json
  def create
    #logger.debug "111111111111"
    #logger.debug @data
    #exit

    #@mtxProduct = MtxProduct.new(params.require(:mtx_product).permit(:price, :status))
    #@mtxProduct.mtx_product_languages << MtxProductLanguage.new(params.require(:mtx_product_language).permit(:name, :intro, :description))

    # @data = {
    #   price: params.require(:mtx_product).permit(:price),
    #   status: params.require(:mtx_product).permit(:status),
    #     mtx_product_languages_attributes: [
    #     {name: params.require(:mtx_product_language).permit(:name)},
    #     {intro: params.require(:mtx_product_language).permit(:intro)},
    #     {description: params.require(:mtx_product_language).permit(:description)}
    #   ]
    # }

    #upload image
    @fileName = ""
    uploaded_io = params[:mtx_product][:thumb]
    unless uploaded_io.nil?
      @fileName = Time.now.to_i.to_s + File.extname(uploaded_io.original_filename)
      File.open(Rails.root.join('app', 'assets', 'images', 'uploads', @fileName), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end

    @dataOfProduct = {
        price: params.require(:mtx_product)[:price],
        status: params.require(:mtx_product)[:status],
        thumb: @fileName,
        mtx_product_languages_attributes: [
          name: params.require(:mtx_product_language)[:name],
          intro: params.require(:mtx_product_language)[:intro],
          description: params.require(:mtx_product_language)[:description]
        ]
    }

    @mtxProduct = MtxProduct.new(@dataOfProduct)

    respond_to do |format|
      if @mtxProduct.save
        format.html { redirect_to @mtxProduct, notice: 'Mtx product was successfully created.' }
        format.json { render :show, status: :created, location: @mtxProduct }
      else
        @pLangdata = {
          name: params.require(:mtx_product_language)[:name],
          intro: params.require(:mtx_product_language)[:intro],
          description: params.require(:mtx_product_language)[:description]
        }
        @productLang = MtxProductLanguage.new(@pLangdata)
        @productLang.mtx_product = @mtxProduct
        # config.logger = Logger.new(STDOUT)
        # logger.debug "1111111111111111"
        # logger.debug {@mtxProduct.errors}
        # exit
        format.html { render :new }
        format.json { render json: @mtxProduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mtx_products/1
  # PATCH/PUT /mtx_products/1.json
  def update
    @mtxProduct = MtxProduct.find(params[:id])
    respond_to do |format|
      @dataOfProduct = params.require(:mtx_product).permit(:price, :status)

      #upload image
      uploaded_io = params[:mtx_product][:thumb]
      unless uploaded_io.nil?
        @fileName = Time.now.to_i.to_s + File.extname(uploaded_io.original_filename)
        File.open(Rails.root.join('app', 'assets', 'images', 'uploads', @fileName), 'wb') do |file|
          file.write(uploaded_io.read)
          @dataOfProduct[:thumb] = @fileName
        end

      end

      @pLangdata = {
        name: params.require(:mtx_product_language)[:name],
        intro: params.require(:mtx_product_language)[:intro],
        description: params.require(:mtx_product_language)[:description]
      }

      if @mtxProduct.update_attributes(@dataOfProduct)
        # @mtxProduct.mtx_product_languages.first.update_attributes(params.require(:mtx_product_language).permit(:name, :intro, :description))
        if @mtxProduct.mtx_product_languages.find_by(["product_id = ?", params[:id]]).update_attributes(@pLangdata)
          format.html { redirect_to @mtxProduct, notice: 'Mtx product was successfully updated.' }
          format.json { render :show, status: :ok, location: @mtxProduct }
        else
          @productLang = MtxProductLanguage.new(@pLangdata)
          @productLang.mtx_product = @mtxProduct
          format.html { render :edit }
          format.json { render json: @mtxProduct.errors, status: :unprocessable_entity }
        end
      else
        @productLang = MtxProductLanguage.new(@pLangdata)
        @productLang.mtx_product = @mtxProduct
        format.html { render :edit }
        format.json { render json: @mtxProduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mtx_products/1
  # DELETE /mtx_products/1.json
  def destroy
    #@mtxProduct.mtx_product_languages.first.destroy
    @mtxProduct.destroy
    respond_to do |format|
      format.html { redirect_to mtx_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mtx_product
      @mtxProduct = MtxProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mtx_product_params
      params.require(:mtx_product).permit(:name, :price, :status, :intro, :description)
    end
end

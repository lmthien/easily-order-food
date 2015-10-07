class MtxProductsController < ApplicationController
  before_action :set_mtx_product, only: [:show, :edit, :update, :destroy]

  # GET /mtx_products
  # GET /mtx_products.json
  def index
    @mtx_products = MtxProduct.all
  end

  # GET /mtx_products/1
  # GET /mtx_products/1.json
  def show
  end

  # GET /mtx_products/new
  def new
    @productLang = MtxProductLanguage.new
    @productLang.mtx_product = MtxProduct.new
  end

  # GET /mtx_products/1/edit
  def edit
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

    @data = {
        price: params.require(:mtx_product)[:price],
        status: params.require(:mtx_product)[:status],
        mtx_product_languages_attributes: [
          name: params.require(:mtx_product_language)[:name],
          intro: params.require(:mtx_product_language)[:intro],
          description: params.require(:mtx_product_language)[:description]
        ]
    }

    @mtxProduct = MtxProduct.new(@data)

    respond_to do |format|
      if @mtxProduct.save
        format.html { redirect_to @mtxProduct, notice: 'Mtx product was successfully created.' }
        format.json { render :show, status: :created, location: @mtxProduct }
      else
        format.html { render :new }
        format.json { render json: @mtxProduct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mtx_products/1
  # PATCH/PUT /mtx_products/1.json
  def update
    respond_to do |format|
      if @mtx_product.update(mtx_product_params)
        format.html { redirect_to @mtx_product, notice: 'Mtx product was successfully updated.' }
        format.json { render :show, status: :ok, location: @mtx_product }
      else
        format.html { render :edit }
        format.json { render json: @mtx_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mtx_products/1
  # DELETE /mtx_products/1.json
  def destroy
    @mtx_product.destroy
    respond_to do |format|
      format.html { redirect_to mtx_products_url, notice: 'Mtx product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mtx_product
      @mtx_product = MtxProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mtx_product_params
      params.require(:mtx_product).permit(:name, :price, :status, :intro, :description)
    end
end

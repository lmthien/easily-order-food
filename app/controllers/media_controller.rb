class MediaController < ApplicationController
  def new
    @media = MtxMedia.new
  end
end

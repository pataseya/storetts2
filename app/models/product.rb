class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :category
  # has_one_attached :product_image
  #
  # product_image.attach(params[:image])
end

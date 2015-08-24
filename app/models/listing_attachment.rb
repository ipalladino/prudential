class ListingAttachment < ActiveRecord::Base
  mount_uploader :listing_image, ListingImagesUploader
  belongs_to :listing, foreign_key: "listing_id"
end

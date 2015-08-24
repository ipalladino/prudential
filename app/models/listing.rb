class Listing < ActiveRecord::Base
  has_many :listing_attachments
  accepts_nested_attributes_for :listing_attachments
end

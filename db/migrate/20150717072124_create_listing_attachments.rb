class CreateListingAttachments < ActiveRecord::Migration
  def change
    create_table :listing_attachments do |t|
      t.integer :listing_id
      t.string :listing_image

      t.timestamps
    end
  end
end

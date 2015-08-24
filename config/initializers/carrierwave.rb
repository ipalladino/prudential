# config/initializers/carrierwave.rb

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['S3_KEY'],       # required
    :aws_secret_access_key  => ENV['S3_SECRET'],       # required
    :region                 => ENV['S3_REGION'],
    :host                   => ENV['S3_HOST']
  }


  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
   config.storage = :file
   config.enable_processing = false
   config.root = "#{Rails.root}/tmp"
  else
   config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

  config.fog_directory  = ENV['S3_BUCKET_NAME']                     # required
  #config.fog_public     = false                                   # optional, defaults to true
  config.s3_access_policy = :public_read
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

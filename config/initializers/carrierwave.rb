CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region:                'eu-central-1'
  }
  
  config.fog_directory  = ENV["S3_BUCKET"]
  config.fog_public     = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end
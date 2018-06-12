CarrierWave.configure do |config|

  if Rails.env.production?

    config.fog_provider = 'fog/aws'                 # required
    config.fog_credentials = {
      provider:              'AWS',                 # required
      aws_access_key_id:     ENV["AWS_ACCESS_KEY"], # required
      aws_secret_access_key: ENV["AWS_SECRET_KEY"], # required
      region:                ENV["AWS_REGION"],
    }
    config.storage = :fog
    config.fog_directory  = ENV["AWS_BUCKET"]       # required
    config.fog_public     = false

  else

    config.storage = :file

  end

end

CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV.fetch('aws_bucket')
  config.aws_acl    = 'public-read'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  config.aws_credentials = {
    access_key_id:     ENV.fetch('aws_access_key_id'),
    secret_access_key: ENV.fetch('aws_secret_access_key'),
    region:            ENV.fetch('aws_region') # Required
  }
end

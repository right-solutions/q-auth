CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIMMZEYIAS5KMGSKQ',       # required
    :aws_secret_access_key  => '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',
    :region                 => 'us-west-2'
  }

  config.fog_directory  = 'q-auth'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
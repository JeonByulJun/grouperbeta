# Allow non-ascii letters in uploaded filenames
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\s\.\-\+]/
CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIWPG5TOBBQX7N3OQ',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'ap-northeast-2',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'grouperteam'                          # required
end

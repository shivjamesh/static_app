if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processign = false
  end
end

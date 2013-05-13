Rails.application.config.middleware.use OmniAuth::Builder do

  require 'openid/store/filesystem'

  provider :twitter, 'K6K3lJjxlozwdmsA1H2LYQ', 'lby8SJL5g6n6t96vQfE3HDdGVss9gp1gGARo9wTs'
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'openid'
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end
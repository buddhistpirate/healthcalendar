require 'oauth2'
require 'pp'
require_relative 'configuration'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class HealthCalendar


  def initialize
    @client = create_client
  end

  def activities
    request('/fitnessActivities')
  end

  private
  attr_reader :client

  def create_client
    OAuth2::Client.new(
      Configuration.client_id,
      Configuration.client_secret,
      site: Configuration.root_resource,
      authorize_url: Configuration.authorization_url,
      token_url: Configuration.access_token_url
    )
  end

  def get_token_from_code
    client.auth_code.get_token(Configuration.auth_code, redirect_uri: 'http://localhost:8080')
  end

  def get_authorization_url
    client.auth_code.authorize_url(redirect_uri: 'http://localhost:8080')
  end

  def request(uri)
    JSON.parse client.request(:get, uri, headers: {'Authorization' => "Bearer #{Configuration.token}"}).body
  end


end

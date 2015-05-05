require './config/application'

module MaryJane
  class API < Grape::API
    version 'v1', using: :path
    content_type :json, "application/json"
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    rescue_from ActiveRecord::RecordNotFound do |e|
      rack_response({ errors: ['Not Found'] }.to_json, 404)
    end

    # mount controllers below
    [Users, Records, Auth, Tools].each { |controller| mount controller }

    add_swagger_documentation(
      mount_path: '/docs',
      api_version: 'v1',
      hide_format: true
    )
  end
end

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options, :patch ]
  end
end

run MaryJane::API
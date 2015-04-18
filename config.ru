require './config/application'

module MaryJane
  class API < Grape::API
    version 'v1', using: :path
    content_type :json, "application/json;charset=UTF-8"
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    rescue_from ActiveRecord::RecordNotFound do |e|
      rack_response({ errors: ['Not Found'] }.to_json, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      rack_response({ errors: e.record.errors }.to_json, 422)
    end

    rescue_from Exception do |e|
      p e.message
      p e.backtrace
      rack_response({ errors: [e.message] }.to_json, 500)
    end

    use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
      end
    end

    # mount controllers below
    [Users, Records, Auth].each { |controller| mount controller }

    add_swagger_documentation(
      mount_path: '/docs',
      api_version: 'v1',
      hide_format: true
    )
  end
end

run MaryJane::API
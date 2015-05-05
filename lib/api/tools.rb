class Tools < Grape::API
  [APIHelper, AuthHelper].each { |helper| helpers helper }

  resources :tools do
    before do
      # authenticate_user!
    end

    desc 'Get all tools'
    get do
      Tool.all
    end

    desc 'Create a tool'
    params do
      requires :name, type: String, desc: 'Title or name of tool'
      optional :comment, type: String, desc: 'Comment for tool'
    end
    post do
      Tool.create declared_params
    end

    namespace '/:id', requirements: { id: /[0-9]/ } do
      before do
        @tool = Tool.find params[:id]
      end

      desc 'Get a tool'
      get do
        @tool
      end

      desc 'Update a tool'
      params do
        optional :name, type: String, desc: 'Title or name of tool'
        optional :comment, type: String, desc: 'Comment for tool'
      end
      patch do
        @tool.update declared_params

        status 204
      end

      desc 'Destroy a tool'
      delete do
        @tool.destroy

        status 204
      end
    end
  end
end
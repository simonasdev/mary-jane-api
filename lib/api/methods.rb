class Auth < Grape::API
  resources :methods do
    before do
      # authenticate_user!
    end

    desc 'Get all methods'
    get do
      Method.all
    end

    desc 'Create a method'
    params do
      requires :name, type: String, desc: 'Title or name of method'
      optional :comment, type: String, desc: 'Comment for method'
    end
    post do
      Method.create declared(params)
    end

    namespace '/:id' do
      before do
        @method = Method.find params[:id]
      end

      desc 'Get a method'
      get do
        @method
      end

      desc 'Update a method'
      params do
        optional :name, type: String, desc: 'Title or name of method'
        optional :comment, type: String, desc: 'Comment for method'
      end
      patch do
        @method.update declared(params)
      end

      desc 'Destroy a method'
      delete do
        @method.destroy
      end
    end
  end
end
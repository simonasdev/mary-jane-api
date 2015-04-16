class Records < Grape::API
  resources :records do
    before do
      # authenticate_user!
    end

    get do
      Record.all
    end

    post do
      Record.create declared(params)
    end

    get '/latest' do
      Record.last
    end

    namespace '/:id' do
      before do
        @record = Record.find params[:id]
      end

      get do
        @record
      end

      patch do
        halt 403 unless @record.user_id == current_user.id
        @record.update declared(params)
      end

      delete do
        halt 403 unless @record.user_id == current_user.id
        @record.destroy
      end
    end
  end
end
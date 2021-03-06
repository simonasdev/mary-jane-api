class Records < Grape::API
  [APIHelper, AuthHelper].each { |helper| helpers helper }

  resources :records do
    before do
      # authenticate_user!
    end

    desc 'Get all records of tokes'
    get do
      Record.includes(:user)
    end

    desc 'Create a record of a toke'
    params do
      requires :amount, type: Float, desc: 'Amount of fun'
      requires :high, type: Float, desc: '10/10'
      requires :tool_id, type: Integer, desc: 'ID of tool used'
    end
    post do
      current_user.records.create declared_params
    end

    desc 'Get latest toke'
    get '/latest' do
      Record.last
    end

    namespace '/:id', requirements: { id: /[0-9]/ } do
      before do
        @record = Record.find params[:id]
      end

      desc 'Get a toke'
      get do
        @record
      end

      desc 'Update a toke if you fucked up'
      params do
        optional :amount, type: Float, desc: 'Amount of fun'
        optional :high, type: Float, desc: '10/10'
      end
      patch do
        error! 'Forbidden', 403 unless @record.user_id == current_user.id
        @record.update declared_params

        status 204
      end

      desc 'Destroy a toke'
      delete do
        error! 'Forbidden', 403 unless @record.user_id == current_user.id
        @record.destroy

        status 204
      end
    end
  end
end
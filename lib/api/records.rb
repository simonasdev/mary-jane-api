class Records < Grape::API
  resources :records do
    before do
      # authenticate_user!
    end

    desc 'Get all records of tokes'
    get do
      Record.all
    end

    desc 'Create a record of a toke'
    params do
      requires :amount, type: Float, desc: 'Amount of fun'
      requires :high, type: Float, desc: '10/10'
    end
    post do
      Record.create declared(params).merge user_id: current_user.id
    end

    desc 'Get latest toke'
    get '/latest' do
      Record.last
    end

    namespace '/:id' do
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
        halt 403 unless @record.user_id == current_user.id
        @record.update declared(params)
      end

      desc 'Destroy a toke'
      delete do
        halt 403 unless @record.user_id == current_user.id
        @record.destroy
      end
    end
  end
end
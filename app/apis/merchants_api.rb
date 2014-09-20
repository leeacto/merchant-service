class MerchantsApi < Grape::API

  helpers do
    def load_merchant!
      Napa::Logger.logger.info "Retrieving Merchant: #{params[:id]}"
      merchant =  Merchant.where(id: params[:id]).first
      if merchant
        return merchant
      else
        Napa::Logger.logger.info "Merchant #{params[:id]} Not Found"
        error! "Merchant Not Found", 404
      end
    end
  end

  desc 'Get a list of merchants'
  params do
    optional :ids, type: Array, desc: 'Array of merchant ids'
  end
  get do
    merchants = params[:ids] ? Merchant.where(id: params[:ids]) : Merchant.all
    represent merchants, with: MerchantRepresenter
  end

  desc 'Create an merchant'
  params do
    requires :name, type: String, desc: "The Merchant name"
    requires :email_address, type: String, desc: "The Merchant's email address"
    optional :ttl, type: Integer, desc: "Number of hours between customer check-ins"
  end

  post do
    Napa::Logger.logger.info "Creating User: #{permitted_params}"
    merchant = Merchant.create(permitted_params)
    if merchant.errors.blank?
      Napa::Logger.logger.info "Merchant (id: #{merchant.id}) successfully created"
      represent merchant, with: MerchantRepresenter
    else
      Napa::Logger.logger.info "Merchant not created - error: #{merchant.errors.full_messages.to_sentence}"
      error! merchant.errors.full_messages.to_sentence, 400
    end
  end

  params do
    requires :id, desc: 'ID of the merchant'
  end
  route_param :id do
    desc 'Get an merchant'
    get do
      merchant = load_merchant!
      represent merchant, with: MerchantRepresenter
    end

    desc 'Update an merchant'
    params do
      optional :name, type: String, desc: "The Merchant name"
      optional :email_address, type: String, desc: "The Merchant's email address"
      optional :ttl, type: Integer, desc: "Number of hours between customer check-ins"
    end
    put do
      # fetch merchant record and update attributes.  exceptions caught in app.rb
      merchant = load_merchant!
      merchant.update_attributes!(permitted_params)
      represent merchant, with: MerchantRepresenter
    end
  end
end

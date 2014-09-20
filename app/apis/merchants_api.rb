class MerchantsApi < Grape::API
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
  end

  post do
    merchant = Merchant.create!(permitted_params)
    represent merchant, with: MerchantRepresenter
  end

  params do
    requires :id, desc: 'ID of the merchant'
  end
  route_param :id do
    desc 'Get an merchant'
    get do
      merchant = Merchant.find(params[:id])
      represent merchant, with: MerchantRepresenter
    end

    desc 'Update an merchant'
    params do
    end
    put do
      # fetch merchant record and update attributes.  exceptions caught in app.rb
      merchant = Merchant.find(params[:id])
      merchant.update_attributes!(permitted_params)
      represent merchant, with: MerchantRepresenter
    end
  end
end

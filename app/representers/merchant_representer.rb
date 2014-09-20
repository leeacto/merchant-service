class MerchantRepresenter < Napa::Representer
  property :id, type: String
  property :name
  property :email_address
  property :ttl
  property :hashed_screen_name

end

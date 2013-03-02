class Address
  include BasicDocument
  include Mongoid::Dirty

  def self.geo_address_fields
    %w{city state state_code province province_code postal_code country country_code}
  end
  
  def self.address_fields
    %w{street number floor_adr} + geo_address_fields
  end

  address_fields.each do |name|
    field name, type: String    
  end

  field :full, type: String, default: ""

  embedded_in :addressable, polymorphic: true

  # validates :street, presence: true

  before_create :set_defaults

  def floor
    floor_adr.to_i
  end

  def region
    state || province
  end

  def xtra_fields
    [:floor_adr]
  end

  def to_s
    Address.address_fields.inject("") do |res, name|
      res << "#{name}: #{send(name)}\n"
    end
  end

  protected

  def set_defaults
    write_attribute :country_code, 'DK'
  end

  def set_full
    self.full = Address.address_fields.select do |name|
      !send(name).blank?
    end.map{|name| send(name) }.join(', ')
  end
end

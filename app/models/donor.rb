class Donor < ActiveRecord::Base
    attr_accessible :flag, :first_name, :last_name, :title, :middle_name, :salution,
    :email, :organization, :company, :street_address, :street_address_2,:city, :state, :country,
    :zipcode, :home_phone, :business_phone, :cell_phone, :secondary_street_address, :secondary_street_address_2,:secondary_city, :secondary_state, :secondary_country,
    :secondary_zipcode, :secondary_home_phone, :secondary_business_phone, :secondary_cell_phone,:created_by, :last_modified_by, :last_modified_at, :active,
    :role, :spouse, :note, :subscribeflag

    has_many :finances, dependent: :destroy
    has_many :contacts, dependent: :destroy

    #validates_presence_of :first_name, :last_name

    def self.search_by inputs
        if inputs != nil
           inputs.delete_if {|key, value| value.empty? }
           inputs.each do |key, value|
               value.downcase!
           end
           search_term = [inputs.keys.map{ |key| "#{key} LIKE ?"}.join(' AND ')] +  inputs.values.map { |val| "%#{val}%" }
       end
       @donors =  Donor.where(search_term)
    end

    def org_xor_ind
      unless !organization.blank? || !(first_name.blank? && last_name.blank?)
        errors.add(:base, "Specify a charge or a payment, not both")
      end
    end
end

class Donor < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :title, :middle_name, :salution, 
    :email, :organization, :company, :street_address, :city, :state, :country,
    :zipcode, :home_phone, :business_phone, :created_by, :last_modified_by
    
    has_many :finances
    has_many :contacts

    def self.search_by inputs
        if inputs != nil 
           inputs.delete_if {|key, value| value.empty? }
           inputs.each do |key, value|
               value.downcase!
           end
        end
    
    
        @donors =  Donor.where(inputs)
    end


end

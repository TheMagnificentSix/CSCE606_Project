class Search < ActiveRecord::Base
    def donors
        @donors = Donor.all
    end
private
    def find_donors
        donors = Donor.all
        #donors = donors.where("first_name like ?","%#{first_name}%") if first_name.present? 
        donors
    end
    
end

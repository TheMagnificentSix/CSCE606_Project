require 'csv'

class DonorsController < ApplicationController

    before_action :check_authorization


    def index
        @donor_attr = Donor.attribute_names
        @donor_attr_show = ["flag", "title", "first_name", "last_name", "organization", "company"]
        @donors = Donor.search_by(params[:donor])
        searched= params[:search]
        
        if searched !=nil
          searchs = searched.gsub(/\s+/m, ' ').strip.split(" ");
          searchs.each do |search|
          search = search.downcase
            @donors = @donors.where(["lower(first_name) LIKE ? or lower(last_name) LIKE ? or lower(organization) LIKE ? or lower(company) LIKE ? or lower(title) LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%"])
          end 
        else
          @donors
        end
    end

    def new
        @donor = Donor.new
        @donor_contact = [
	        "contact_date",
	        "followup_date",
	        "narrative"
	    ]
	    @donor_finance = [
            '_type',
            'date',
            'amount',
            'description',
            'designation'
        ]
    end

    def show
        id = params[:id]
        @active = params[:active]
        @donor = Donor.find(id)

          if @donor.flag == "I"
        type = "Individual"
      elsif @donor.flag == "O"
        type = "Organization"
      end

        if @donor.subscribeflag == "Y"
        subscribe = "Yes"
      elsif @donor.subscribeflag == "N"
        subscribe = "No"
      end

        @donor_basic = {
            'Subscribe' => subscribe,
            'Title' => @donor.title,
            'Role' => @donor.role,
            'First Name' => @donor.first_name,
            'Last Name' => @donor.last_name,
            'Middle Name' => @donor.middle_name,
            'Salution' => @donor.salution,
            'Email' => @donor.email,
  	        'Organization' => @donor.organization,
  	        'Company' => @donor.company,
  	        'Spouse' => @donor.spouse,
  	        'Street Address' => @donor.street_address,
  	        'Street Address 2' => @donor.street_address_2,
  	        'City' => @donor.city,
  	        'State' => @donor.state,
  	        'Countrt' => @donor.country,
  	        'Zip Code' => @donor.zipcode,
            'Business Phone' => @donor.business_phone,
            'Cell Phone' => @donor.cell_phone,
            'Home Phone' => @donor.home_phone,
            'Note' => @donor.note,
            'Secondary Email'=>@donor.secondary_email,
            'Secondary Business Phone'=>@donor.secondary_business_phone,
            'Secondary Cell Phone'=>@donor.secondary_cell_phone,
            'Secondary Home Phone'=>@donor.secondary_home_phone,
            'Secondary Street Address'=>@donor.secondary_street_address,
            'Secondary City'=>@donor.secondary_city,
            'Secondary State'=>@donor.secondary_state,
            'Secondary Country'=>@donor.secondary_country,
            'Secondary Zipcode'=>@donor.secondary_zipcode
	        }
	    @donor_contact = [
	        "contact_date",
	        "followup_date",
	        "narrative"
	    ]
	    @contacts = Contact.where(:donor_id => @donor.id)
	    @finances = Finance.where(:donor => @donor.id)
	    @donor_finance = [
            '_type',
            'date',
            'amount',
            'description',
            'designation'
        ]
    end

    def destroy
        id = params[:id]
        @donor = Donor.find(id)
        @donor.destroy
        flash[:notice] = "#{@donor.first_name} #{@donor.last_name} is deleted."
        redirect_to donors_path
    end

    def create
      @donor = Donor.create!(params[:donor])
      if(params[:contact_date].present? && params[:narrative].present?)
        contact_param = {}
        cdate=params[:contact_date]
        narrative=params[:narrative]
        contact_param[:followup_date]=""
        if(params[:followup_date].present?)
          fdate=params[:followup_date]
          contact_param[:followup_date]=fdate
        end
        contact_param[:contact_date]=cdate
        contact_param[:narrative]=narrative
        contact_param[:created_by]=User.find(session[:user_id]).username
        contact_param[:last_modified_by]=User.find(session[:user_id]).username
        @contact = @donor.contacts.new contact_param
        @contact.save!
      end
      #flash[:notice] = "#{@donor.first_name} #{@donor.last_name} was successfully created."
      if params[:where] == "inplace"
          redirect_to new_donor_path
          sleep(0.7)
      else
          redirect_to new_donor_path
          sleep(0.7)
      end
    end

    def update
      @donor = Donor.find(params[:id])
      @donor.update_attributes(params[:donor])

      if @donor.flag == "I"
        type = "Individual"
      elsif @donor.flag == "O"
        type = "Organization"
      end

      if @donor.subscribeflag == "Y"
        subscribe = "Yes"
      elsif @donor.subscribeflag == "N"
        subscribe = "No"
      end


      if(params[:contact_date].present? && params[:narrative].present?)
        cdate=params[:contact_date]
        narrative=params[:narrative]
        contact_param = {}
        contact_param[:contact_date]=cdate
        contact_param[:followup_date]=""
        if(params[:followup_date].present?)
          fdate=params[:followup_date]
          contact_param[:followup_date]=fdate
        end
        contact_param[:narrative]=narrative
        contact_param[:created_by]=User.find(session[:user_id]).username
        contact_param[:last_modified_by]=User.find(session[:user_id]).username
        @contact = @donor.contacts.new contact_param
        @contact.save!
      end

      render :json => @donor if request.xhr? && params[:where] == "inplace"
      @donor_basic = {
            'Title' => @donor.title,
            'Role' => @donor.role,
            'First Name' => @donor.first_name,
            'Last Name' => @donor.last_name,
            'Middle Name' => @donor.middle_name,
            'Salution' => @donor.salution,
            'Email' => @donor.email,
  	        'Organization' => @donor.organization,
  	        'Company' => @donor.company,
  	        'Spouse' => @donor.spouse,
  	        'Street Address' => @donor.street_address,
  	        'Street Address 2' => @donor.street_address_2,
  	        'City' => @donor.city,
  	        'State' => @donor.state,
  	        'Country' => @donor.country,
  	        'Zip Code' => @donor.zipcode,
            'Business Phone' => @donor.business_phone,
            'Cell Phone' => @donor.cell_phone,
            'Home Phone' => @donor.home_phone,
            'Note' => @donor.note,
            'Secondary Email'=>@donor.secondary_email,
            'Secondary Business Phone'=>@donor.secondary_business_phone,
            'Secondary Cell Phone'=>@donor.secondary_cell_phone,
            'Secondary Home Phone'=>@donor.secondary_home_phone,
            'Secondary Street Address'=>@donor.secondary_street_address,
            'Secondary City'=>@donor.secondary_city,
            'Secondary State'=>@donor.secondary_state,
            'Secondary Country'=>@donor.secondary_country,
            'Secondary Zipcode'=>@donor.secondary_zipcode
	        }
      render(:partial => 'donor_summary', :object => @donor_basic) if request.xhr? && !params[:where]
    end

    def showByContact
      contact_id = params[:contactId]
      @contact = Contact.find(contact_id)
      @donor = @contact.donor
      redirect_to controller:'donors', action:'show', id:@donor.id, active:2
    end

    def showSummary
      id = params[:id]
      @donor = Donor.find(id)

      if @donor.flag == "I"
        type = "Individual"
      elsif @donor.flag == "O"
        type = "Organization"
      end

      if @donor.subscribeflag == "Y"
        subscribe = "Yes"
      elsif @donor.subscribeflag == "N"
        subscribe = "No"
      end

      @donor_basic = {
          'Type' => type,
          'Title' => @donor.title,
          'Role' => @donor.role,
          'First Name' => @donor.first_name,
          'Last Name' => @donor.last_name,
          'Middle Name' => @donor.middle_name,
          'Salution' => @donor.salution,
          'Email' => @donor.email,
  	      'Organization' => @donor.organization,
  	      'Company' => @donor.company,
  	      'Spouse' => @donor.spouse,
  	      'Street Address' => @donor.street_address,
  	      'Street Address 2' => @donor.street_address_2,
  	      'City' => @donor.city,
  	      'State' => @donor.state,
  	      'Country' => @donor.country,
  	      'Zip Code' => @donor.zipcode,
          'Business Phone' => @donor.business_phone,
          'Cell Phone' => @donor.cell_phone,
          'Home Phone' => @donor.home_phone,
          'Note' => @donor.note,
          'Secondary Email'=>@donor.secondary_email,
          'Secondary Business Phone'=>@donor.secondary_business_phone,
          'Secondary Cell Phone'=>@donor.secondary_cell_phone,
          'Secondary Home Phone'=>@donor.secondary_home_phone,
          'Secondary Street Address'=>@donor.secondary_street_address,
          'Secondary City'=>@donor.secondary_city,
          'Secondary State'=>@donor.secondary_state,
          'Secondary Country'=>@donor.secondary_country,
          'Secondary Zipcode'=>@donor.secondary_zipcode
	     }
	     render(:partial => 'donor_summary', :object => @donor_basic) if request.xhr?
    end

 

   

    def import
      Donor.import(params[:file])
      redirect_to donors_path, notice: "Donors Added successfully"
    end
    

    def check_authorization
        unless current_user.function and current_user.function.include? 'donor management'
            flash[:notice]="Sorry, authorization check failed!"
            redirect_to homepage_path
        end
    end
end

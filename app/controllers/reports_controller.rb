class ReportsController < ApplicationController
    before_filter :authorize
    
    def index
        @report_records = Report.all
    end

    def show
        id = params[:id] 
        @report_record = Report.find(id) 
    end
    
    def new 
        
    end
    
    def create
    
    end
    
    def edit
        
    end
    
    def show
        
    end
    
    def update
        
    end
    
    def destroy
    
    end
end
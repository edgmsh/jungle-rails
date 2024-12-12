class AboutController < ApplicationController
  def index
    # If you want to add dynamic content, set instance variables here
    @company_name = "MyCompany"
    @year_founded = 2000
  end
end

class HomeController < ApplicationController
  def home

  end

  def contact
  end

  def request_contact
    ## In an actual application an email would be send to the administrators here
    redirect_to root_path, notice: 'Message submitted successfully!'
  end

  def about; end
  
  def privacy; end

  def termsandconditions; end
  
end

class WelcomeController < ApplicationController
  def index
  	respond_to do |format|
  		format.html
  		format.pdf do 
  			pdf = GuestPdf.new 
  			send_data pdf.render, filename: "print.pdf",
  								  type: "application/pdf",
  								  disposition: "inline" 

  		end 
  	end 
  end

end

class GuestPdf < Prawn::Document
	def initialize(guest)
		super(top_margin:70)
		@guest = guest
		text "#{guest.name}", size: 30, style: :bold 
	
	end 


end 


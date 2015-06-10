class GuestsPdf < Prawn::Document
	def initialize(guests, number)
		super(top_margin:40)
		@guests = guests
		
		# @even = @guests.values_at(* guests.each_index.select{|d| d.even?})
		# @odd = @guests.values_at(* guests.each_index.select{|d| d.odd?})
		@number = number
		
		print_names

	end

	def roman_design 
		def combine(a1, a2)
			output = []
			a1.each do |i1|
				a2.each do |i2|
				output += [[i1,i2]]
				end
			end

			output
		end

		def recurse_bounding_box(max_depth=4, depth=1)
			width = (bounds.width-15)/2
			height = (bounds.height-15)/2
			left_top_corners = combine([5, bounds.right-width-5],
			[bounds.top-5, height+5])
			left_top_corners.each do |lt|
				bounding_box(lt, :width => width, :height => height) do
				stroke_bounds
				recurse_bounding_box(max_depth, depth+1) if depth < max_depth
				end
			end
		end
		# Set up a bbox from the dashed line to the bottom of the page
		bounding_box([0, cursor], :width => bounds.width, :height => cursor) do
			recurse_bounding_box
		end
	end 

	def first_design(max_depth=1, depth=1)
		width = (bounds.width-15)/2
		sub_height = (bounds.height-15)/4 
		left_top_corners = combine([5, bounds.right-width-5], [bounds.top-5, sub_height+5])
		
		left_top_corners.each do |lt|
			bounding_box(lt, :width => width, :height => sub_height) do
			stroke_bounds
			recurse_bounding_box(max_depth, depth+1) if depth < max_depth
			end
		end
	end 

	def print_names
		length = @guests.size
		image_name = "app/assets/images/pla" + @number + ".png"
		1.upto(length/4.floor) do |i| 
			define_grid(:columns => 2, :rows => 4, :gutter => 2)
			grid(1,0).bounding_box do
				image image_name, :fit => [bounds.width, bounds.height], 
				:postion => :center, :vposition => :center
				float do
					bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
						text @guests[4*i-4].name, :valign => :center, :align => :center
					end 
				end 
			end 
			grid(1,1).bounding_box do
				image image_name, :fit => [bounds.width, bounds.height], 
				:postion => :center, :vposition => :center
				float do
					bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
						text @guests[4*i-3].name, :valign => :center, :align => :center
					end 
				end 
			end 
			grid(3,0).bounding_box do
				image image_name, :fit => [bounds.width, bounds.height], 
				:postion => :center, :vposition => :center
				float do
					bounding_box([bounds.width/3-10,bounds.height*1], :width => 100) do 
						text @guests[4*i-2].name, :valign => :center, :align => :center
					end 
				end 
			end 
			grid(3,1).bounding_box do
				image image_name, :fit => [bounds.width, bounds.height], 
				:postion => :center, :vposition => :center
				float do
					bounding_box([bounds.width/3-10,bounds.height*1], :width => 100) do 
						text @guests[4*i-1].name, :valign => :center, :align => :center
					end 
				end 
			end 
			start_new_page
		end 

		if length%4 != 0 
			addition = length-length%4
			addition.upto(length) do |i| 
				if length%4 == 1
					grid(1,0).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4].name, :valign => :center, :align => :center
							end 
						end 
					end
				elsif length%4 == 2 
					grid(1,0).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4].name, :valign => :center, :align => :center
							end 
						end 
					end 
					grid(1,1).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4+1].name, :valign => :center, :align => :center
							end 
						end 
					end
				else 
					grid(1,0).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4].name, :valign => :center, :align => :center
							end 
						end 
					end 
					grid(1,1).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4+1].name, :valign => :center, :align => :center
							end 
						end 
					end 
					grid(3,0).bounding_box do 
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*1], :width => 100) do 
								text @guests[length-length%4+2].name, :valign => :center, :align => :center
							end 
						end 
					end
				end 
			end 
		end 
	end 
end 


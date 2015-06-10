require 'csv'

class Guest < ActiveRecord::Base
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			puts "row: "+row.to_s
			puts "hash: "+row.to_hash.to_s
			Guest.create! row.to_hash
		end 
	end 
end

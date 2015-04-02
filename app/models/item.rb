class Item < ActiveRecord::Base

	def self.import(file)
		begin
		  CSV.foreach(file.path, headers: true) do |row|
		    student = new
		    student.attributes = row.to_hash.slice(*row.to_hash.keys)
		    student.sold = 0
		    student.save!
		  end
		rescue => e
	        # Rails.logger.error { "Encountered an error" }
      		"notok"
      	end
	end
end

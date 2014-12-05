class Student < ActiveRecord::Base
	
	def self.import(file)
		begin
		  CSV.foreach(file.path, headers: true) do |row|
		    student = find_by_id(row["id"]) || new
		    student.attributes = row.to_hash.slice(*row.to_hash.keys)
		    student.date=nil
		    student.paid=0
		    student.save!
		  end
		rescue => e
	        # Rails.logger.error { "Encountered an error" }
      		"notok"
      	end
	end
end

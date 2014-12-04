class Student < ActiveRecord::Base
	
	def self.import(file)
		begin
		  abc=0
		  CSV.foreach(file.path, headers: true) do |row|
		    student = find_by_id(row["id"]) || new
		    abc = student.paid
		    student.attributes = row.to_hash.slice(*row.to_hash.keys)
		    student.paid = abc + row["paid"]
		    student.date=nil
		    student.paid=0
		    student.save!
		  end
		rescue => e
	        Rails.logger.error { "Encountered an error" }
      		"ERROR UPLOADING CSV"
      	end
	end
end

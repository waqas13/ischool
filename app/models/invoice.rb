class Invoice < ActiveRecord::Base
	has_many :bills
end

class Invoice < ActiveRecord::Base
	has_many :bills
	belongs_to :customer
end

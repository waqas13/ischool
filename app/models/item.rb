class Item < ActiveRecord::Base
	validates_uniqueness_of :title
	has_many :bills
end

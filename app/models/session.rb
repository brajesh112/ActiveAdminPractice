class Session < ApplicationRecord
	has_and_belongs_to_many :labels
	validates :labels, presence: true
end

class Session < ApplicationRecord
	has_and_belongs_to_many :labels
	validates :type_of_session, :title, presence: true
end

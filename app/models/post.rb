class Post < ApplicationRecord
	belongs_to :admin_user
	has_many_attached :images
	validates :title, :body, :images, presence: true
end

class Post < ApplicationRecord
	belongs_to :admin_user
	has_many_attached :images
	validates :title, :body, :images, presence: true
	validates :images, attached: true, content_type: ['image/png','image/jpeg']
	validates :images, attached: true, size: { less_than: 2.kilobytes }
end

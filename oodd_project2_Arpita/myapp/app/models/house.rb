class House < ApplicationRecord
  validates :location, presence: true
  mount_uploader :file_name, ImageUploader
end

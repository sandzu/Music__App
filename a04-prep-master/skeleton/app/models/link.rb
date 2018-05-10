class Link < ApplicationRecord
  validates :title, :url, :user, presence: true 
end

class Like < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :post
end

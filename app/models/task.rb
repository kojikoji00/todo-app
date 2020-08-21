class Task < ApplicationRecord
  has_one_attached :eyecatch

  validates :content, presence: true
  validates :content, length: { minimum: 5, maximum: 120 }
  validates :content, uniqueness: true
  has_many :comments, dependent: :destroy
  belongs_to :board
end

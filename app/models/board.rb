class Board < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 50 }
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  validates :content, length: { minimum: 5, maximum: 120 }
  validates :content, uniqueness: true
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def display_created_at
    I18n.l(created_at, format: :default)
  end

  def author_name
    user.display_name
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  # has_one_attached :avatar

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def prepare_profile
    profile || build_profile
  end

  def display_name
    profile&.nickname || '名無し'
    # nicknameがnilじゃない時にprofileが実行される
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end

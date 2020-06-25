class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true
  validates :profile, length: { maximum: 200 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_items, through: :likes, source: :post, dependent: :destroy

  mount_uploader :image, ImageUploader

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end

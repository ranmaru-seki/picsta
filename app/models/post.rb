class Post < ApplicationRecord
  validates :image, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :image, ImageUploader

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end

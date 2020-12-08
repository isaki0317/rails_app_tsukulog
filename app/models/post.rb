class Post < ApplicationRecord

  belongs_to :end_user
  belongs_to :genre
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_end_user, through: :favorites, source: :end_user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_end_user, through: :bookmarks, source: :end_user
  has_many :materials, dependent: :destroy
  has_many :works, dependent: :destroy

  accepts_nested_attributes_for :materials, allow_destroy: true
  accepts_nested_attributes_for :works, allow_destroy: true

  default_scope -> { order(created_at: :desc) }

  mount_uploader :images, ImagesUploader

  enum cost: {
    １０００円以下: 0,
    ３０００円以下: 1,
    ５０００円以下: 2,
    ８０００円以下: 3,
    ８０００円以上: 4
  }

  enum creation_time: {
    ～３０分: 0,
    ～１時間: 1,
    ～２時間: 2,
    ～４時間: 3,
    ～６時間: 4,
    それ以上: 5
  }

  enum level: {
    低い: 0,
    中: 1,
    高い: 2,
    えぐい: 3
  }

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

  def bookmarked_by?(end_user)
    bookmarks.where(end_user_id: end_user.id).exists?
  end

  def self.search_for(value, how)
    if how == 'match'
      Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true))
    elsif how == 'partical'
      Post.where('title LIKE ?', '%'+value+'%')
    end
  end

end

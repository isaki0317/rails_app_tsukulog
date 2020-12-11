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

  # いいねに対する通知
  def create_notification_favorite!(current_end_user, end_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_end_user.id, end_user.id, id, 'favorite'])
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        post_id: id,
        visited_id: end_user.id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントに対する通知
  def create_notification_comment!(current_end_user, comment_id)
    temp_ids = Comment.select(:end_user_id).where(post_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, comment_id, temp_id['end_user_id'])
    end
    save_notification_comment!(current_end_user, comment_id, end_user_id) if temp_ids.blank?
  end
  def save_notification_comment!(current_end_user, comment_id, visited_id)
    notification = current_end_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # searchs/search → search+sort
  def self.search_for(value, how, order, terms)
    if how == 'match'
      if order == nil && terms == nil
        Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true))
      elsif order == 'cost'
        if terms == 'desc'
          Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true)).order(cost: :desc)
        else
          Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true)).order(creation_time: :asc)
        end
      elsif order == 'level'
        if terms == 'desc'
          Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true)).order(cost: :desc)
        else
          Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true)).order(creation_time: :asc)
        end
      elsif order == 'time'
        if terms == 'desc'
          Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true)).order(cost: :desc)
        else
          Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true)).order(creation_time: :asc)
        end
      end
    elsif how == 'partical'
      if order == nil && terms == nil
        Post.where('title LIKE ?', '%'+value+'%').where(post_status: true)
      elsif order == 'cost'
        if terms == 'desc'
          Post.where('title LIKE ?', '%'+value+'%').where(post_status: true).order(cost: :desc)
        else
          Post.where('title LIKE ?', '%'+value+'%').where(post_status: true).order(cost: :asc)
        end
      elsif order == 'level'
        if terms == 'desc'
          Post.where('title LIKE ?', '%'+value+'%').where(post_status: true).order(level: :desc)
        else
          Post.where('title LIKE ?', '%'+value+'%').where(post_status: true).order(level: :asc)
        end
      elsif order == 'time'
        if terms == 'desc'
          Post.where('title LIKE ?', '%'+value+'%').where(post_status: true).order(creation_time: :desc)
        else
          Post.where('title LIKE ?', '%'+value+'%').where(post_status: true).order(creation_time: :asc)
        end
      end
    end
  end

  # posts/index → sort
  def self.sort_for(order, terms)
    if order == 'none' && terms == 'none'
      Post.order(created_at: :desc)
    elsif order == 'cost'
      if terms == 'desc'
        Post.order(cost: :desc)
      else
        Post.order(cost: :asc)
      end
    elsif order == 'level'
      if terms == 'desc'
        Post.order(level: :desc)
      else
        Post.order(level: :asc)
      end
    elsif order == 'time'
      if terms == 'desc'
        Post.order(creation_time: :desc)
      else
        Post.order(creation_time: :asc)
      end
    else
      if terms == nil
        Post.order(created_at: :desc)
      end
    end
  end
end

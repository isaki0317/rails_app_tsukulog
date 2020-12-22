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

  validates :title, presence: true, length: {in: 1..24}
  validates :subtitle, presence: true, length: {maximum: 40}
  validates :end_user_id, presence: true
  validates :images, presence: true

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
  # 対象の投稿の配列の中から、blocked_by?blocker_by?を使って絞り込み
  def self.block_posts(targets, current_end_user)
    targets.select do |target|
      unless target.end_user.blocked_by?(current_end_user) || target.end_user.blocker_by?(current_end_user)
        target
      end
    end
  end
  # 対象のユーザーの配列の中から、blocked_by?blocker_by?を使って絞り込み
  def self.block_action(end_users, current_end_user)
    end_users.select do |end_user|
      unless end_user.blocked_by?(current_end_user) || end_user.blocker_by?(current_end_user)
        end_user
      end
    end
  end

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

  def create_notification_comment!(current_end_user, comment_id, visited_id)
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
      posts = Post.where(title: value, post_status: true).or(Post.where(genre_id: value, post_status: true))
    else
      posts = Post.where('title LIKE ?', '%'+value+'%').where(post_status: true)
    end
      if order == 'cost'
        if terms == 'desc'
          posts = posts.order(cost: :desc)
        else
          posts = posts.order(cost: :asc)
        end
      elsif order == 'level'
        if terms == 'desc'
          posts = posts.order(level: :desc)
        else
          posts = posts.order(level: :asc)
        end
      elsif order == 'time'
        if terms == 'desc'
          posts = posts.order(creation_time: :desc)
        else
          posts = posts.order(creation_time: :asc)
        end
      elsif order =='favorite'
        posts = posts.joins(:favorites).group(:post_id).order('count(post_id) desc')
      else
        posts = posts.order(created_at: :desc)
      end
  end

  # posts/index → sort
  def self.sort_for(order, terms, current_end_user)
    posts = Post.where(post_status: "true")
    if order == 'none' && terms == 'none'
      posts = posts.order(created_at: :desc)
    elsif order == 'cost'
      if terms == 'desc'
        posts = posts.order(cost: :desc)
      else
        posts = posts.order(cost: :asc)
      end
    elsif order == 'level'
      if terms == 'desc'
        posts = posts.order(level: :desc)
      else
        posts = posts.order(level: :asc)
      end
    elsif order == 'time'
      if terms == 'desc'
        posts = posts.order(creation_time: :desc)
      else
        posts = posts.order(creation_time: :asc)
      end
    elsif order == 'favorite'
      posts = posts.joins(:favorites).group(:post_id).order('count(post_id) desc')
    else
      if terms == nil
        posts = posts.order(created_at: :desc)
      end
    end
  end

end

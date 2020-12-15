class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :posts
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :posts

  # トーク機能
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  # フォロー機能
  # 自分がフォローしてるユーザとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # 自分がフォローされてるユーザーとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  # ブロック機能
  # 自分がブロックしているユーザーとの関連
  has_many :active_blocks, class_name: "Block", foreign_key: :blocker_id
  has_many :blockers, through: :active_blocks, source: :blocked
  # 自分をブロックしているユーザーとの関連
  has_many :passive_blocks, class_name: "Block", foreign_key: :blocked_id

  # 通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: :visitor_id, dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy

  mount_uploader :images, ImagesUploader

  enum sex: {
    未選択です:0,
    男性: 1,
    女性: 2
  }

  enum experience: {
    初心者: 0,
    中級者: 1,
    上級者: 2,
    プロ: 3
  }
  # フォロー機能で使用
  # 特定のユーザーのpassive_relationshipsの中のfollowing_idが引数で渡したユーザーのものがあるかの判定
  def followed_by?(end_user)
    passive_relationships.find_by(following_id: end_user.id).present?
  end
  # 相互フォローを探すメソッド
  def matchers
    followings & followers
  end

  # ブロック機能で使用↓
  # 特定のユーザー(投稿者など)のpassive_blocksのblocker_idの中に、引数で渡したユーザーが存在するかの判定
  def blocked_by?(end_user)
    passive_blocks.find_by(blocker_id: end_user.id).present?
  end
  # 特定のユーザー(投稿者など)のactive_blocksのblocked_idの中に、引数で渡したユーザーが存在するかの判定
  def blocker_by?(end_user)
    active_blocks.find_by(blocked_id: end_user.id).present?
  end
  # 特定のユーザーのactive_relationshipsの中のfollower_idが引数で渡したユーザーのものがあるかの判定
  def follower_by?(end_user)
    active_relationships.find_by(follower_id: end_user.id).present?
  end
  # ログインユーザーブロックしたユーザーが、自分のfollowerにいる場合は削除する
  def destry_follow!(end_user)
    follow = active_relationships.find_by(follower_id: end_user.id)
    follow.destroy
  end

  # フォローに対する通知
  def create_notification_follow!(current_end_user, end_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_end_user.id, end_user.id, 'follow'])
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        visited_id: end_user.id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.search_for(value, how)
    if how == 'match'
      EndUser.where(name: value)
    elsif how == 'partical'
      EndUser.where('name LIKE ?', '%'+value+'%')
    end
  end

  # guestログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "ゲスト太郎"
    end
  end

end

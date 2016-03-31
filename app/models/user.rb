class User < ActiveRecord::Base
  attr_accessor :remember_token

  QUERY_SEARCH_ADMIN = "id in (select users.id from users
    where users.name LIKE ? AND users.admin = 't')"
  QUERY_SEARCH_USER = "id in (select users.id from users
    where users.name LIKE ? AND (users.admin = 'f' OR users.admin is null))"
  QUERY_SEARCH_ALL = "id in (select users.id from users
    where users.name LIKE ?)"

  has_many :activities
  has_many :lessons
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password
  mount_uploader :avatar, AvatarUploader

  scope :search_admin, -> (search_name){where QUERY_SEARCH_ADMIN,
    "%#{search_name}%"}
  scope :search_user, -> (search_name){where QUERY_SEARCH_USER,
    "%#{search_name}%"}
  scope :search_all, -> (search_name){where QUERY_SEARCH_ALL,
    "%#{search_name}%"}

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :post_images, dependent: :destroy
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   attachment :profile_image

   has_many :followers,
            class_name: 'Relationship',
            foreign_key: 'follower_id',
            dependent: :destroy,
            inverse_of: :follower

  has_many :following,
            class_name: 'Relationship',
            foreign_key: 'following_id',
            dependent: :destroy,
            inverse_of: :following

  has_many :following_users, through: :followers, source: :following
  has_many :follower_users, through: :following, source: :follower

  #フォローする
    def follow(other_user_id)
      followers.create(following_id: other_user_id)
    end

    #フォローしているかの確認
    def following?(other_user)
      following_users.include?(other_user)
    end

  #フォロー解除

end

class User < ApplicationRecord
  # 文字を全て小文字に自分自身を直接変換
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  # formatは正規表現 uniquenessは重複なし case_sensitiveは大文字と小文字を区別する(つまりfalseなので区別しない)
  validates :email, presence: true, length: { maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  # パスワード付きのモデル
  has_secure_password

  has_many :microposts, dependent: :destroy

  has_many :relationships
  # followingsというものを命名する。followカラムから取ってくる。user.followingsで取れる
  has_many :followings, through: :relationships, source: :follow

  # 『多対多の図』の左半分にいるUserからフォローされている」という関係への参照。reveseは自分で命名したもの
  # ----------------------------------------------------------------------------------------------------
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end

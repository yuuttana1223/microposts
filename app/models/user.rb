class User < ApplicationRecord
  # 文字を全て小文字に自分自身を直接変換
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  # formatは正規表現 uniquenessは重複なし case_sensitiveは大文字と小文字を区別する(つまりfalseなので区別しない)
  validates :email, presence: true, length: { maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  # パスワード付きのモデル
  has_secure_password
end

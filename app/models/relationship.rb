class Relationship < ApplicationRecord
  # belongs_to :user, class_name: 'User'が省略されている
  belongs_to :user
  # FollowというクラスはないのでUserを参照するようにする
  belongs_to :follow, class_name: 'User'
end

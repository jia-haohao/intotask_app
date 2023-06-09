class User < ApplicationRecord
  before_validation { email.downcase }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  has_secure_password
  validates :password, length: { minimum: 6 } ,on: [:new, :create]

  has_many :tasks, dependent: :destroy
  before_destroy :destroy_action
  before_update :update_action

  private 

  def destroy_action
    if User.where(admin: true).count == 1 && self.admin
      throw(:abort)
    end
  end

  def update_action
    user = User.find_by(admin: true)
    if User.where(admin: true).count == 1 && self.admin_change == [true,false]
      errors.add(:admin, '管理ユーザーから外せません。最低一人の管理者が必要です')
      throw(:abort)
    end
  end
end

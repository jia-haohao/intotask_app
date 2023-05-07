class Task < ApplicationRecord
  validates :title, length: { maximum: 50 }, presence: true
  validates :content, length: { maximum: 1000 }, presence: true
  validates :deadline, :priority, :status, presence: true

  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :get_by_title, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :get_by_status, -> (status) { where(status: status)}

  belongs_to :user, optional: true
end

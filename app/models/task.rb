# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  deadline    :datetime
#  description :text
#  status      :string           default("backlog"), not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  # constants
  STATUSES = [ "backlog", "inprogress", "done" ] 

  # extensions
  
  # scopes
  STATUSES.each do |type|
    scope type, -> { where(status: type) }
  end

  # associations
  belongs_to :user

  # nested attributes

  # attachments

  # attribute accessors

  # validations
  validates :title, presence: true, :length => { maximum: 100, message: "must be less than 100 chars." }
  validates :status, presence: true, inclusion: { in: STATUSES, message: "%{value} is not a valid status." }  

  validates :description, :length => { maximum: 500, message: "must be less than 500 chars." }
  validates :deadline, presence: true
  
  # creates dynamic methods besed on statuses
  STATUSES.each do |action|
    define_method("#{action}?") do |args=nil|
      return status == action
    end
  end

  def human_readable_deadline
    deadline.strftime("%b %d, %Y") if deadline.present?
  end
end

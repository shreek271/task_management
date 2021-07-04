namespace :scheduled_tasks do
  
  desc "to notify users for deadline"
  task deadline_notification: :environment do
    Task.where("expires < (?) AND status = (?)", 25.hour.ago, "backlog").each |task| do
      TasksMailer.send_deadline_reminder(task).deliver_now
    end
  end
end
class TasksMailer < ApplicationMailer

  def send_deadline_reminder(task)
    @task = task
    mail(to: @task.user.email, subject: "25 hours remaining.")
  end
end

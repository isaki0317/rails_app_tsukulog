# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# 絶対パスから相対パス指定
env :PATH, ENV['PATH']
# ログファイルの出力先
set :output, 'log/cron.log'
# ジョブの実行環境の指定
set :environment, :development
# set :output, "/path/to/my/cron_log.log"
#
# 日本時間の午前8:00にメール送信される（JSTは+9:00なので-9:00の時間を記述）
# 未読通知が3件以上たまっているユーザーにメール通知
every 1.minutes, at: '11:00 pm' do
  runner "ScheduledProcessingMailer.check_notice_mail.deliver_now"
end
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

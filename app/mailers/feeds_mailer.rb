class FeedsMailer < ActionMailer::Base
  default :from => "RSS Feeds Read System Notifier <noreply@rssrfsys.com>"
  
  def last_feeds_email(user)
    @channels = Channel.where(:user_id => user)
    @feeds = Feed.where(:channel_id => @channels).limit(5).order("published_at desc")

    mail(:to => user.email, :subject => "last 5 feeds"
      # 
    ) do |format|
      format.html
    end
  end

end
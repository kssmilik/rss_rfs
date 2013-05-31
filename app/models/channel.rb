class Channel < ActiveRecord::Base

  attr_accessible :favourite, :name, :summary, :url, :user_id

  has_many :feed , dependent: :destroy
  has_and_belongs_to_many :user

  validates_http_url :url, :content_type => "xml"

  require 'feedzirra'
  # scope :favourite , where("favourite",true)


  def set_name_form_link
    self.name = name_from_link(self.url)
    self.save
  end

  private
  def name_from_link(url)
    u = url.gsub("http://", '').
            gsub( "/rss.xml",'').
            gsub("www.",'').
            gsub(".rss", '').
            gsub("rss", '').
            gsub(".xml", '' ).
            gsub(".php", '').
            split('/')

    u[0] = u.first.split('.')[0]
    u = u - [""]
    u = (u * ' ').capitalize
    return u
  end
end

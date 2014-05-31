class Notice < ActiveRecord::Base
  has_many :messages

  attr_accessible :close_at, :notices, :messages_attributes
  accepts_nested_attributes_for :messages

  def self.open(now = Time.now)
    where("close_at IS NULL OR ? < close_at", now)
  end

  def self.locale(locales)
    if locales.empty?
      where("1 = 1")
    else
      where("EXISTS (SELECT * FROM messages WHERE messages.notice_id = notices.id AND messages.locale IN (?))", locales)
    end
  end

  def close!(now = Time.now)
    self.update_attributes!(:close_at => now)
  end

  def as_json(options = {})
    locales = options[:locale] || []

    {
      :id => self.id,
      :created_at => self.created_at,
      :updated_at => self.updated_at,
      :close_at => self.close_at,
      :notices => self.messages.locale(*locales).as_json(options)
    }
  end
end

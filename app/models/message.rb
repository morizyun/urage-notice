class Message < ActiveRecord::Base
  belongs_to :notice

  attr_accessible :subject, :body, :locale

  validates_presence_of :subject
  validates_presence_of :body
  validates_inclusion_of :locale, :in => ["ja", "en"]

  def self.locale(*locales)
    locales.empty? ? where("1 = 1") : where(:locale => locales)
  end

  def as_json(options = {})
    {
      :id => self.id,
      :created_at => self.created_at,
      :updated_at => self.updated_at,
      :subject => self.subject,
      :body => self.body,
      :locale => self.locale,
    }
  end
end

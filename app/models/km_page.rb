class KmPage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Enablable
  include Approvable
  include Lockable
  include Permalink

  field :title, :type => String
  field :hits, :type =>  Integer
  field :content, :type => String
  field :last_updated_id, :type => BSON::ObjectId
  field :last_updated_at, :type => DateTime
  field :last_user_id, :type => BSON::ObjectId
  field :user_id, :type => BSON::ObjectId
  field :slug, :type => String

  #has_permalink_on :title , :parent => :forum

  embedded_in :km_page_category
  belongs_to :user
  #embeds_many :cm_page_fields

  before_save :create_slug

  def to_param
    self.slug
  end

  protected

  def create_slug
    self.slug = self.title.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

  def self.find_by_slug(slug)
    self.find_by(:slug => slug)
  end
  private

end

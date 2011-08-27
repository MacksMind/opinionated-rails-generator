class Content < ActiveRecord::Base
  acts_as_list
  validates_presence_of :name, :title, :html, :slug
  attr_accessible :name, :title, :html, :slug
  validates_uniqueness_of :slug

  before_validation :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end

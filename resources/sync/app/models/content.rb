class Content < ActiveRecord::Base
  validates_presence_of :name, :title, :html
  attr_accessible :name, :title, :html
  def to_param
    name
  end
end

class Project < ActiveRecord::Base

  has_many :project_categories
  has_many :categories, through: :project_categories
  has_many :comments
  belongs_to :user
  has_many :users, through: :comments
  has_many :likes

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end

end

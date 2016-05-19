class Project < ActiveRecord::Base

  has_many :project_categories
  has_many :categories, through: :project_categories
  has_many :comments

  belongs_to :creator, :class_name => "User"

  has_many :commenters, through: :comments, :class_name => "User"

  validates :title, presence: true
  has_attached_file :image
  validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end

  def update_likes(project_id)
    @project = Project.find(project_id)
    @project.likes = @project.likes + 1
    @project.save
    @project
  end

  def self.trending_projects
    where("likes > 10")
  end

end

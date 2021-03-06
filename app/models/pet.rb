class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :description, :approximate_age, :sex
  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }
  enum sex: [:female, :male]

  def self.search(search)
    key = "%#{search}%".downcase
    where("LOWER(name) ILIKE :search", search: key)
  end

  def self.average_age
    average(:approximate_age)
  end

  def self.adoptable_count
    where(adoptable: true).count
  end
end

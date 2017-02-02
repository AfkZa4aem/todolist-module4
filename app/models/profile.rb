class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female)}
  validate :not_null_name
  validate :name_check

  def not_null_name
    if first_name.nil? && last_name.nil?
      errors.add(:first_name, "cannot be null!")
    end
  end

  def name_check
    if first_name == "Sue" && gender == "male"
      errors.add(:first_name, "something wrong with this girl")
    end
  end

  def self.get_all_profiles(min_year, max_year)
    Profile.where(birth_year: min_year..max_year).order(birth_year: :asc)
  end
end

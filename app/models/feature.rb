# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feature < ApplicationRecord
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :users

  FEATURES = []

  def self.create_all_features
    Feature.transaction do
      FEATURES.each { |feature| Feature.find_or_create_by(feature) }
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_name           :string           not null
#  last_name            :string
#  email                :string           not null
#  password_digest      :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  role_id              :integer
#  password_reset_token :string
#

class User < ApplicationRecord
  has_secure_password
  has_secure_token :password_reset_token

  belongs_to :role

  has_and_belongs_to_many :features

  before_save :set_features

  def set_features
    self.features = role.features
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # JSON RESPONSES
  def token_response
    self.as_json(except: [:password_digest, :created_at, :updated_at])
  end
end

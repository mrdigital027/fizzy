class Project < ApplicationRecord
  include Accessible

  belongs_to :account
  belongs_to :creator, class_name: "User", default: -> { Current.user }

  has_many :bubbles, dependent: :destroy
end

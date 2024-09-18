module Project::Accessible
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :destroy
    has_many :users, through: :accesses

    after_create -> { grant_access(creator) }
  end

  def update_access(users)
    transaction do
      grant_access(users)
      accesses.where.not(user: Array(users)).delete_all
    end
  end

  def grant_access(users)
    Array(users).each do |user|
      accesses.create_or_find_by!(user: user)
    end
  end
end

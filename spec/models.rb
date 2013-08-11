# Ip Authorizable model
class Organization < ActiveRecord::Base
  ip_authorizable
  has_many :users, dependent: :destroy
end

class User < ActiveRecord::Base
  belongs_to :organization
end

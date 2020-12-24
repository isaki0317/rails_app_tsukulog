class Relationship < ApplicationRecord
  belongs_to :following, class_name: "EndUser"
  belongs_to :follower, class_name: "EndUser"
end

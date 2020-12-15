class Block < ApplicationRecord

  belongs_to :blocker, class_name: "EndUser"
  belongs_to :blocked, class_name: "EndUser"

end

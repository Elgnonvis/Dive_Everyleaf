class Task < ApplicationRecord
    validates :task_name, presence:true, length: {minimum:1, maximum:30}
    validates :task_details, presence: true
end

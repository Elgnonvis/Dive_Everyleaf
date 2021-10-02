class Task < ApplicationRecord
    validates :task_name, presence:true, length: {minimum:1, maximum:30}
    validates :task_details, presence: true

    scope :task_name_search, -> (query) {where("task_name LIKE ?", "%#{query}%")}
	def task_name_search(query)
	  where("task_name LIKE ?", "%#{query}%")
	end

	scope :status_search, -> (query) {where(status: query)}
	def status_search(query)
	  where(status: query)
	end
end

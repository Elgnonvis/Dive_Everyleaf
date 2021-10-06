class Task < ApplicationRecord
	belongs_to :user
	# has_many :tag_task, dependent: :destroy
    validates :task_name, presence:true, length: {minimum:1, maximum:30}
    validates :task_details, presence: true
	# self.per_page = 10
	# willPaginate.per_page = 10
	paginates_per 5
	enum priority: {Low: 1, Medium: 2 , High: 3}
	

	#search with scope1
    scope :task_name_search, -> (query) {where("task_name LIKE ?", "%#{query}%")}
	def task_name_search(query)
	  where("task_name LIKE ?", "%#{query}%")
	end

	scope :status_search, -> (query) {where(status: query)}
	def status_search(query)
	  where(status: query)
	end

	#serach with scope 2 (not tested)
	# scope :get_all, ->(){order(limit_date: :desc)}
	# scope :search_task_name, ->(name){where('task_name like ?', name)}
	# scope :search_status, ->(status){where('status like ?', status)}
	# scope :name_status_search, ->(name,status){where('name like ? and status like ?', name, status)}
	# scope :sort_priority, ->(){order(priority: :desc)}

	#search without using scope
	# def self.task_name_search(keywords)
	# 	if keywords.blank?
	# 		self
	# 	else
	# 		self.where('task_name LIKE ?', "%#{keywords}%")
	# 	end
	
	# end

	# def self.status_search(keywords)
	# 	if keywords.blank?
	# 		self
	# 	else
	# 		self.where(status: keywords )
	# 	end
	
	# end


end

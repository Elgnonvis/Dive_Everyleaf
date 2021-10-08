class Label < ApplicationRecord
    belongs_to :task, optional: true
    belongs_to :user, optional: true
    has_many :task_label_relations, dependent: :destroy
	has_many :tasks, through: :task_label_relations, source: :task
    validates :label_name, presence: true
    # validates :label_name, presence: {message: "is required"}
end

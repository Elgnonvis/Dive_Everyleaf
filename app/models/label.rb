class Label < ApplicationRecord
    belongs_to :task, optional: true
    belongs_to :user, optional: true
    has_many :task_label_relations, dependent: :destroy
	has_many :labels, through: :task_label_relations, source: :label
    validates :label_name, presence: true
end

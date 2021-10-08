FactoryBot.define do
  factory :task_label_relation do
    task_id { 2 }
    label_id { 2 }
  end
  # factory :second_task_label_relation, class: task_label_relation do
  #   task { 2 }
  #   label { 2}
  # end
# end
# factory :task_label_relation do
#   task { 1 }
#   label { 1 }
# end
# factory :second_task_label_relation, class: Task_label_relation do
#   task_id { 2 }
#   label_id { 2}
end
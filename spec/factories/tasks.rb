FactoryBot.define do
  factory :task do
    task_name { 'Task name 1 made by Factory' }
    task_details { 'Task details 1 made by Factory' }
    deadline { Date.new(2021, 10, 10) }
    # priority { 'High' }
  end
  factory :second_task, class: Task do
    task_name { 'Task name 2 made by Factory' }
    task_details { 'Task details 2 made by Factory' }
    deadline { Date.new(2021, 10, 11)}
    # priority { 'Middle' }
  end
end

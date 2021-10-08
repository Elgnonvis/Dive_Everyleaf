FactoryBot.define do
  factory :label do
    label_name { "Administration" }
  end
  factory :second_label, class: Label do
    label_name { "Commercial" }
  end

end

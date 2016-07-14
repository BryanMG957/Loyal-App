FactoryGirl.define do
  factory :appointment do
    start_time { Faker::Date.between(21.days.ago, 21.days.from_now).to_datetime + rand(6..21).hours + (rand(0..1) * 30).minutes }
    end_time { start_time + 30.minutes }
    charge { (rand(2..4) * 5) }
    reminder_before { 15 }
    uuid { UUID.generate }
    description { [].tap { |x| 6.times { x << "Walk" }
                               4.times { x << "Overnight" }
                               3.times { x << "Daycare" }
                               3.times { x << "Cat Care" }
                               1.times { x << "Lizard Care" } }.sample }
  end
end

Factory.define :user do |u|
  u.first_name "Joe"
  u.last_name "User"
  
  u.sequence(:email) { |a| "user.#{a}@example.com" }
  u.sequence(:login) { |a| "login.#{a}" }
  
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :account do |a|
  a.sequence(:name) { |n| "Account #{n}" }  
end

Factory.define :character do |c|
  c.name { Factory.next(:name) }
  c.level 80

  c.association :account
  c.association :character_class
end

Factory.sequence :name do |n|
  "User.#{n}"
end

Factory.define :raid do |r|
  r.association :account
  
  r.name "Naxxramas - Death Knight Wing"
  r.started_at Time.now
  r.ended_at Time.now + 2.hours
end

Factory.define :item do |i|
  i.number 123
end

Factory.define :attempt do |a|
  # a.association :raid
  a.association :boss
end

Factory.define :participant do |p|  
end

Factory.define :attendee do |a|
  a.association :raid
  a.association :character
end

Factory.define :boss do |b|
end

Factory.define :drop do |d|
  d.price 20
end

Factory.define :character_class do |c|
  c.sequence(:name) { |a| "CharacterClass.#{a}" }
end

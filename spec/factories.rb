Factory.define :user do |u|
  u.first_name "Joe"
  u.last_name "User"
  
  u.sequence(:email) { |a| "user.#{a}@example.com" }
  u.sequence(:login) { |a| "login.#{a}" }
  
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :account do |a|
  
end
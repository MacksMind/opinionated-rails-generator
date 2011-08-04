Factory.define :content do |f|
  f.sequence(:name) {|n| "name#{n}"}
  f.sequence(:title) {|n| "title#{n}"}
  f.sequence(:html) {|n| "html#{n}"}
end

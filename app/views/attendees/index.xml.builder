xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
  
xml.pie do
  @character_class_sums.each_with_index do |cc, index|
    xml.slice cc.count, :title => cc.name, :pull_out => (index == 1), :color => cc.color
  end
end
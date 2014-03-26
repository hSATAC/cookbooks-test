require "awesome_print" 
  
ruby_block "ap" do
  block do
   ap node[:name]
  end
end
folders = %w[config application infrastructure] 

folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
folders = %w[representers services views controllers forms]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end

folders = %w[config infrastructure application]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
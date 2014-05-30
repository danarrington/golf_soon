desc "Updates Tee Time and Golf Course data"
task :update_data => :environment do
  puts "Updating Times..."
  DataParser.new.get_latest_times
  puts "done."
end
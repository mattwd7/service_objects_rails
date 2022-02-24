require_relative "lib/service_objects_rails"

ServiceObjectsRails.config do |c|
  c.return_service_response_object = false
end

puts "=" * 10
puts ServiceObjectsRails.return_service_response_object

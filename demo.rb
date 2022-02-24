require_relative "lib/services"

Services.config do |c|
  c.return_service_response_object = false
end

puts "=" * 10
puts Services.return_service_response_object

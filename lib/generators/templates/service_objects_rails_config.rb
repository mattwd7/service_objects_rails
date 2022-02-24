require "service_objects_rails"

ServiceObjectsRails.config do |c|
  # The ServiceObjects::Response class is always returned after
  # executing the #call on a ServiceObject. This object includes
  # goodies like graceful error handling and returning with the
  # object(s) upon which the Service operated in response.body.
  # However, some consider it good practice to simply return the
  # object(s) a service operated on. Set this to false to avoid
  # ServiceObjects::Response altogether.
  # c.return_service_response_object = false
end

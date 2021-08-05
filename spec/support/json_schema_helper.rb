RSpec::Matchers.define :match_json_schema do |schema|
   match do |response|
     schema_directory = "#{Dir.pwd}/spec/support/payloads/schemas"
     schema_path = "#{schema_directory}/#{schema}.json"
     JSON::Validator.validate!(schema_path, payload, strict: true)
   end
 end
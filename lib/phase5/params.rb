require 'uri'

module Phase5
  class Params

    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      @params.merge!(parse_www_encoded_form(req.query_string)) if req.query_string
      @params.merge!(parse_www_encoded_form(req.body)) if req.body
      new_route_params = route_params.stringify_keys
      @params.merge!(new_route_params)
    end

    def [](key)
      @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      results = {}
      queries = www_encoded_form.split('&')
      queries.each do |query|
        values, result = query.split('=')
        values = parse_key(values)
        if values.is_a?(String)
          first_hash = {values => result}
        else
          first_hash = {values.pop => result}
          until values.empty?
            first_hash = { values.pop => first_hash }
          end
        end
        results.merge!(first_hash) { |key, oldval, newval| newval.merge!(oldval) }
      end
      results
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end

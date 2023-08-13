module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def with_headers(user, config = {})
    config.merge({ headers: (config[:headers] || {}) })
  end

  def with_success_response(&block)
    block.call
    expect(response).to have_http_status(:success)
  end
end

RSpec::Matchers.define :have_attributes_with_expected_types do |expected_types|
  match do |actual|
    actual.each_with_index do |obj, index|
      value = obj[1]
      attr_name = obj[0]
      attr_type = expected_types[attr_name.to_sym]
      unless value.class.name == attr_type
        @mismatched_index = index
        @mismatched_attr = attr_name
        @expected_type = attr_type
        return false
      end
    end
    true
  end

  failure_message do |_actual|
    "Expected object at index #{@mismatched_index} to have #{@mismatched_attr} of type #{@expected_type}."
  end
end

RSpec::Matchers.define :have_array do |expected_type|
  match do |actual|
    return false unless actual.class.name == expected_type

    true
  end

  failure_message do |_actual|
    "Expected object at index #{@mismatched_index} to have #{@mismatched_attr} of type #{@expected_type}."
  end
end

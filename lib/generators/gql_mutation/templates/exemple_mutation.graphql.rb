fragment errorFields on ValidationError {
  path
  message
  attributes
  error
}

mutation <%= class_name.camelize(:lower) %>($input: <%= class_name.camelize %>Input!) {
  <%= class_name.camelize(:lower) %>(input: $input) {
    changeMe {
      id
    }
    errors {
      ...errorFields
    }
  }
}

# frozen_string_literal: true

module Mutations
  class <%= class_name %> < BaseMutation
    description '<%= class_name %>'

    # argument :argument_name, String, required: false
    # field :field_name, Types::MyType, null: true

    def resolve(**args)
      # authorize! current_user, to: :<%= class_name.underscore %>?
      # todo add logic here
      # {field_name: field_name}
    end
  end
end

# app/helpers/registrations_helper.rb

module RegistrationsHelper
    def display_field_error(resource, field)
      return unless resource.errors[field].present?
      content_tag(:p, resource.errors[field].join(', '), class: 'field-error')
    end
end
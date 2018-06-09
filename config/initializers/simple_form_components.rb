module SimpleForm
  module Inputs
    class FileInput < Base
      def input(wrapper_options)
        idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"

        button = template.content_tag(:div, class: 'input-group') do
          @builder.file_field(attribute_name, class: 'nm-file-upload-input') +
          template.tag(:input, id: "#{idf}_file_name", class: 'string form-control', type: 'text', disabled: true) +
          template.content_tag(:div, class: 'input-group-append') do
            template.content_tag(:span, "Choose a file", class: 'btn btn-outline-secondary', onclick: "$('##{idf}').click();")
          end
        end

        script = template.content_tag(:script, type: 'text/javascript') do
          "$('##{idf}').change(function() { $('##{idf}_file_name').val(this.value.split('\\x5c').pop()); });".html_safe
        end

        button + script
      end
    end
  end
end

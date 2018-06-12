module SimpleForm
  module Inputs
    class FileInput < Base
      def input(wrapper_options)
        idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"

        button = template.content_tag(:div, class: 'input-group') do
          # File name box
          template.tag(:input,
            id: "#{idf}_file_name",
            class: 'string form-control',
            type: 'text',
            disabled: true,
            placeholder: 'Drop an image here') +

          # Invisible input field that stores files to upload (and acts as a drag-and-drop area)
          @builder.file_field(attribute_name, class: 'nm-file-upload-input') +

          # Button: Choose a file
          template.content_tag(:div, class: 'input-group-append') do
            template.content_tag(:span, "Choose an image file",
              class: 'btn btn-outline-secondary',
              onclick: "$('##{idf}').click();")
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

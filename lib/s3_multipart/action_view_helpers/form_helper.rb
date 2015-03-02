module S3Multipart
  module ActionViewHelpers
    module FormHelper
      def multipart_uploader_form(options = {})
        uploader_digest = S3Multipart::Uploader.serialize(options[:uploader])
        options[:input_class] = options[:input_class] || ''
        html = file_field_tag(
          options[:input_name],
          :class => options[:input_class],
          :accept => options[:types].join(','),
          :multiple => 'multiple',
          :data => {
            :uploader => uploader_digest,
            :context => options[:context]
        })

        if !options[:only_file_input].nil? && options[:only_file_input]==false
          html << options[:html].html_safe
          html << button_tag(:class => options[:button_class]) do
            content_tag(:span, options[:button_text])
          end
        end
        html
      end
    end
  end
end

ActionView::Base.send :include, S3Multipart::ActionViewHelpers::FormHelper

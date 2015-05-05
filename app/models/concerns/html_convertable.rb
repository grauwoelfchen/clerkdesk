module HtmlConvertable
  extend ActiveSupport::Concern

  class_methods do
    def html_convertable(field)
      @html_convertable_attribute = field.to_s
    end

    def html_convertable_attribute
      @html_convertable_attribute
    end
  end

  included do
    before_save :html_convert

    private

    def html_convert
      attribute = self.class.html_convertable_attribute
      if attribute.in?(changed_attributes.keys)
        markdown = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML,
          :autolink                     => true,
          :hard_wrap                    => true,
          :tables                       => true,
          :no_stiles                    => true,
          :filter_html                  => true,
          :no_intra_emphasis            => true,
          :underline                    => true,
          :disable_indented_code_blocks => true,
          :fence_code_blocks            => false
        )
        source= self.send(attribute)
        unless source.blank?
          self.send("#{attribute}_html=", markdown.render(source))
        end
      end
    end
  end
end

module Philomath
  module Rendering
    class RenderStyledLink
      class << self
        def call(value)
          if value.kind_of?(Array)
            value.map { |v| replace_links(v) }
          else
            replace_links(value)
          end
        end
  
        private
  
        def replace_links(value)
          fragment = Nokogiri::HTML.fragment(value)
          fragment.css("a").wrap("<color rgb='0000FF'><u>")
          fragment.to_html
        end
      end
    end
  end  
end

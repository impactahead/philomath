module Philomath
  module Rendering
    class RenderCodeInline
      def self.call(value)
        if value.kind_of?(Array)
          value.map { |v| v.gsub("<code>", "<color rgb='7d8182'>").gsub("</code>", "</color>") }
        else
          value.gsub("<code>", "<color rgb='7d8182'>").gsub("</code>", "</color>")
        end
      end
    end
  end
end

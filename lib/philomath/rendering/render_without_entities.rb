module Philomath
  module Rendering
    class RenderWithoutEntities
      def self.call(value)
        if value.kind_of?(Array)
          value.map { |v| v.gsub("&quot;", '"') }
        else
          value.gsub("&quot;", '"')
        end
      end
    end
  end  
end

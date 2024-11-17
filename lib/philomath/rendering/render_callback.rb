module Philomath
  module Rendering
    class RenderCallback
      CALLBACKS = [
        Philomath::Rendering::RenderCodeInline,
        Philomath::Rendering::RenderWithoutEntities,
        Philomath::Rendering::RenderStyledLink
      ]
  
      def call(value)
        parsed_value = value
  
        CALLBACKS.each do |callback|
          parsed_value = callback.call(parsed_value)
        end
  
        parsed_value
      end
    end
  end  
end

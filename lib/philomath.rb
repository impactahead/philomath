require 'markdownlyze'
require 'prawn'
require 'prawn_components'
require 'nokogiri'

require_relative 'philomath/rendering/render_code_inline'
require_relative 'philomath/rendering/render_styled_link'
require_relative 'philomath/rendering/render_without_entities'
require_relative 'philomath/rendering/render_callback'

module Philomath
  class << self
    def render(chapters:)
      table_of_contents = {}
      contents = {}
      pdf_chapters = []
      pdf = Prawn::Document.new
      pdf.default_leading(10)

      PrawnComponents.initialize_fonts(pdf: pdf)
      pdf.font('Inter')

      chapters.each do |chapter|
        pdf_chapters << {
          name: chapter[:name],
          parsed_elements: Markdownlyze.parse(chapter[:content])
        }
      end

      callback = Rendering::RenderCallback.new

      toc_pages_count = get_toc_pages_count(chapters: pdf_chapters.map { |c| c[:parsed_elements] })
      toc_pages_count.times { pdf.start_new_page }

      pdf_chapters.each_with_index do |chapter_conf, chapter_conf_i|
        chapter_elements = chapter_conf[:parsed_elements]

        table_of_contents[chapter_conf[:name]] = {
          page: pdf.page_number, headings: {}
        }

        chapter_elements.each do |node|
          case node[:element]
          when :h1
            pdf.public_send("h1", node[:value], callback: callback)
          when :h2
            table_of_contents[chapter_conf[:name]][:headings][node[:value]] = pdf.page_number
            pdf.public_send("h2", node[:value], callback: callback)
          when :h3
            pdf.public_send("h3", node[:value], callback: callback)
          when :h4
            pdf.public_send("h4", node[:value], callback: callback)
          when :paragraph
            pdf.public_send("paragraph", callback.call(node[:value]))
          when :code_block
            pdf.public_send("code_block", node[:value], node[:language])
          when :blank_line
            pdf.move_down(3)
          when :ol
            pdf.public_send("ol", node[:value], callback: callback)
          when :ul
            pdf.public_send("ul", node[:value], callback: callback)
          when :image
            pdf.move_down(6)
            pdf.image(chapter.images[node[:value]], position: :center, width: pdf.bounds.width - 25)
            pdf.move_down(6)
          when :quote
            pdf.public_send("quote", node[:value], callback: callback)
            pdf.move_down(6)
          end
        end

        pdf.start_new_page unless chapter_conf_i == pdf_chapters.size - 1
      end

      toc_page = 1

      pdf.go_to_page(toc_page)

      pdf.public_send("h1", 'Table of contents')
      pdf.move_down(50)

      pdf.public_send("table_of_contents", table_of_contents)

      # Generate clickable table of contents
      pdf.outline.define do |outline|
        table_of_contents.each do |chapter_data|
          toc_chapter_title = chapter_data.first
          toc_chapter_page = chapter_data.last[:page]
          toc_chapter_headings = chapter_data.last[:headings]

          outline.section(toc_chapter_title, destination: toc_chapter_page) do
            toc_chapter_headings.each_pair do |heading_title, heading_page|
              outline.page(title: heading_title, destination: heading_page)
            end
          end
        end
      end

      options = {
        start_count_at: 3,
        page_filter: lambda{ |pg| pg > 2 },
        at: [0, 0],
        align: :center,
        size: 13
      }

      pdf.number_pages('<page>', options)

      pdf.render
    end

    private

    def get_toc_pages_count(chapters:)
      toc_list_item_type = :h2
      subheading_height = 29
      heading_height = 43
      height_to_use_on_page = 592

      toc_metrics = chapters.map do |c| 
        c.count { |m| m[:element] == toc_list_item_type }
      end

      sum = toc_metrics.map do |n|
        heading_height + (subheading_height * n)
      end

      toc_page_length = 1
      toc_page_pos = 0
      sum.each do |chap_sum|
        if (toc_page_pos + chap_sum) > height_to_use_on_page
          toc_page_length += 1
          toc_page_pos = 0
        else
          toc_page_pos += chap_sum
        end
      end

      toc_page_length
    end
  end
end

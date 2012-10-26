require 'module_base'
require 'xml_helper'

class Goodreads < ModuleBase
  include XmlHelper
  READ_AT = "2005-01-01"
  EVERNOTE_BASE = "https://www.evernote.com/shard/s6/sh"

  def update
    num_updates = 0
    uri = "http://www.goodreads.com/review/list/#{config.user_id}.xml?v=2&per_page=200&shelf=read&sort=date_read&key=#{config.key}"
    xml_for(uri, '//reviews/review') do |r|
      note_path = r.find('recommended_for').first.content
      book = Book.new :goodreads_id => r.find('book/id').first.content, 
        :isbn13      => r.find('book/isbn13').first.content, 
        :title       => r.find('book/title').first.content.strip, 
        :finished_at => Time.parse(r.find('read_at').first.content),
        :num_pages   => r.find('book/num_pages').first.content, 
        :rating      => r.find('rating').first.content,
        :notes_url   => note_path.blank? ? nil : "#{EVERNOTE_BASE}/#{note_path}"
      r.find('book/authors/author').each do |a|
        book.add_author(a.find('name').first.content.strip)
      end

      unless Book.find_by_goodreads_id(book.goodreads_id)
        if book.valid?
          book.save
          num_updates += 1
        else
          puts book.title
          puts book.errors.full_messages
        end
      end
    end
    puts "Fetched #{num_updates} new book(s)"
  end
end

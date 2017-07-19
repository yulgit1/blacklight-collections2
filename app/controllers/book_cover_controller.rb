require 'open-uri'

class BookCoverController < ApplicationController

  def show
    isbn = params[:isbn]
    size = params[:size] || 'small'
#=begin
    openlibrary_image = openlibrary_cover_image(isbn, size)
    if openlibrary_image
      send_data openlibrary_image, type: 'image/jpeg', disposition: 'inline', filename: "#{isbn}.jpg"
    else
      google_image = google_cover_image(isbn)
      if google_image
        send_data google_image, type: 'image/jpeg', disposition: 'inline', filename: "#{isbn}.jpg"
      else
        amazon_image = amazon_cover_image(isbn)
        if amazon_image
          send_data amazon_image, type: 'image/jpeg', disposition: 'inline', filename: "#{isbn}.jpg"
        else
          redirect_to '/no_cover.png'
        end
      end
    end
#=end
=begin
    amazon_image = amazon_cover_image(isbn)
    if amazon_image
      puts "AI"
      send_data amazon_image, type: 'image/jpeg', disposition: 'inline', filename: "#{isbn}.jpg"
    else
      puts"NC"
      redirect_to '/no_cover.png'
    end
=end

    #syndetics_image = syndetics_cover_image(isbn, size)
    #librarything_image = librarything_cover_image(isbn, size)
  end

  private

  def return_image(url)
    bytes = open(url).read
    bytes = nil if bytes.length < 1000  # received a 1x1 px image; cover not found
    bytes
  end

  def openlibrary_cover_image(isbn, size)
    openlibrary_size = 'S'
    case size
      when 'medium'
        openlibrary_size = 'M'
      when 'large'
        openlibrary_size = 'L'
    end

    url = "http://covers.openlibrary.org/b/isbn/#{isbn}-#{openlibrary_size}.jpg"
    return_image(url)
  end

  def google_cover_image(isbn)
    #u = "https://books.google.com/books?bibkeys=ISBN:"+isbn+"&jscmd=viewapi" #alternate
    u = "https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn
    j = JSON.load(open(u))
    #j = open(u).string #alternate
    if j["items"] && j["items"][0] && j["items"][0]["volumeInfo"] &&
        j["items"][0]["volumeInfo"]["imageLinks"] &&
          j["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
    t = j["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"]
    else
      return nil
    end
    return_image(t)
  end

  def amazon_cover_image(isbn)
    u = "http://images.amazon.com/images/P/#{isbn}.01.20TRZZZZ.jpg"
    #bytes = open(u,"mimeType" => "text/xml; charset=x-user-defined").read #alternate with header
    return_image(u)
  end

end

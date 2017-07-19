require 'rails_helper'

RSpec.describe BookCoverController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show, :params => { :isbn => '0521547903' }
      #get :show, isbn: '0521547903'
      expect(response).to have_http_status(:success)
    end
  end

  it 'should return expected google book cover' do
    exp = "http://books.google.com/books/content?id=ZotvleqZomIC&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    BookCoverController.new.instance_eval{google_cover_image("0316769487")}.should ==
        BookCoverController.new.instance_eval{return_image(exp)}
  end

  it 'should return expected amazon book cover' do
    isbn = "0316769487"
    u = "http://images.amazon.com/images/P/#{isbn}.01.20TRZZZZ.jpg"
    exp = "http://books.google.com/books/content?id=ZotvleqZomIC&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    BookCoverController.new.instance_eval{amazon_cover_image(isbn)}.should ==
        BookCoverController.new.instance_eval{return_image(u)}
  end

  it 'should return expected syndetics book cover' do
    isbn = "0316769487"
    client_code = ENV['SYNDETICS_CLIENT_CODE']
    type = "rn12"
    u = "http://www.syndetics.com/index.aspx?isbn=#{isbn}/summary.html&client=#{client_code}&type=#{type}"
    BookCoverController.new.instance_eval{syndetics_cover_image(isbn,type)}.should ==
        BookCoverController.new.instance_eval{return_image(u)}
  end

  it 'should return expected librarything book cover' do
    isbn = "0316769487"
    devkey = ENV['LIBRARYTHING_DEV_KEY']
    u = "http://covers.librarything.com/devkey/#{devkey}/medium/isbn/#{isbn}"
    BookCoverController.new.instance_eval{librarything_cover_image(isbn)}.should ==
        BookCoverController.new.instance_eval{return_image(u)}
  end

end

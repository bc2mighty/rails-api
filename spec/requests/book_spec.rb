require 'rails_helper'

describe 'Books API', type: :request do
  describe "GETS /books" do
    it 'returns all books' do
      FactoryBot.create(:book, title: "Test Title 1", author: "Test Author 1")
      FactoryBot.create(:book, title: "Test Title 2", author: "Test Author 2")

      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
  
  describe "POSTS /books" do
    it 'should create a new book' do
      expect {
        post '/api/v1/books', params: {book: { title: "Test Book 1", author: "Test Author 1"} }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "Delete /books/:id" do
    it 'deletes a book' do
      book = FactoryBot.create(:book, title: "Test Title 1", author: "Test Author 1")

      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
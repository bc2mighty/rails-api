require 'rails_helper'

describe 'Books API', type: :request do
  describe "GETS /books" do
    it 'returns all books' do
      author = FactoryBot.create(:author, first_name: "Shade", last_name: "Blade", age: 45)
      FactoryBot.create(:book, title: "Test Title 1", author_id: author.id)
      FactoryBot.create(:book, title: "Test Title 2", author_id: author.id)

      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
  
  describe "POSTS /books" do
    it 'should create a new book' do
      author = FactoryBot.create(:author, first_name: "Shade", last_name: "Blade", age: 45)

      expect {
        post '/api/v1/books', params: {
          book: { title: "Test Book 1", author_id: author.id}
        }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({
        "id" => 1,
        "title" => "Test Book 1",
        "author_name" => "#{author.first_name} #{author.last_name}",
        "author_age" => author.age,
      })
    end
  end

  describe "Delete /books/:id" do
    it 'deletes a book' do
      author = FactoryBot.create(:author, first_name: "Shade", last_name: "Blade", age: 45)
      book = FactoryBot.create(:book, title: "Test Title 1", author_id: author.id)

      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
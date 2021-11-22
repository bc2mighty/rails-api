class BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_array_json
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        author_name: author_name(book),
        author_age: book.author.age
      }
    end
  end

  def as_object_json
    {
      id: @books.id,
      title: @books.title,
      author_name: author_name(@books),
      author_age: @books.author.age
    }
  end

  private

  def author_name(book)
    "#{book.author.first_name} #{book.author.last_name}"
  end

  attr_reader :books
end
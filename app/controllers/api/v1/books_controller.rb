module Api
  module V1
    require './app/representers/books_representer'

    class BooksController < ApplicationController
      MAX_PAGINATION_LIMIT = 100

      def index
        books = Book.limit(limit).offset(params[:offset])
        render json: BooksRepresenter.new(books).as_array_json
      end

      def create
        # binding.irb
        book = Book.new(book_params)
        if book.save
          render json: BooksRepresenter.new(book).as_object_json, status:  :created
        else
          render json: { status: false, error_messages: book.errors }, status:  :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!

        head :no_content
      end

      private

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT
        ].min
      end

      def book_params
        params.require(:book).permit(:title, :author_id)
      end
    end
  end
end
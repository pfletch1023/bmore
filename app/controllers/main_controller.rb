class MainController < ApplicationController

  def index
    filter = Word.where(string: "shit").first
    ids = filter.tweets.includes(:words).distinct(:word_ids)
    # @words = Word.where(:_id.in => ids).most_popular.limit(100)
    @words = Word.most_popular.limit(100)
  end

  def word
    @word = Word.find_by(string: params[:word])
    @tweets = @word.tweets.order_by(time: :desc).limit(100)
  end

end

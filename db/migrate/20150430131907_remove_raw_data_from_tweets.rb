class RemoveRawDataFromTweets < ActiveRecord::Migration
  def change
    Tweet.each do |t|
      t.set_images_from_hash unless t.images.length > 0
      t.update_attributes(raw: nil)
    end
  end
end

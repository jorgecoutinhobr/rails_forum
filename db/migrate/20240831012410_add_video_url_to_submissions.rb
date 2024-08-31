class AddVideoUrlToSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_column :submissions, :video_url, :string
  end
end

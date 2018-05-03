class User < ApplicationRecord
  include PgSearch

  pg_search_scope :search, against: [:name, :description, :number, :birthday],
  using: {tsearch: { prefix:true, dictionary: "english"}}

  validates_presence_of :name, :birthday, :number, :description

  class << self

    def import(file)
      if File.extname(file.original_filename) != ".csv"
        return false
      else
        CSV.foreach(file.path, headers: true) do |row|
          name, birthday, number, description = row.to_hash['name'], row.to_hash['date'], row.to_hash['number'], row.to_hash['description']
          User.find_or_create_by(name:name, birthday:birthday,number:number,description:description)
        end
        return true
      end
    end

    def perform_search(query)
      if query.present?
        search(query)
      else
        all
      end
    end
  end

end

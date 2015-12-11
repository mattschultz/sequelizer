require 'sequel'
require_relative 'options'

module Sequelizer
  # Class that handles loading/interpretting the database options and
  # creates the Sequel connection
  class ConnectionMaker
    # The options for Sequel.connect
    attr :options

    # Accepts an optional set of database options
    #
    # If no options are provided, attempts to read options from
    # config/database.yml
    #
    # If config/database.yml doesn't exist, Dotenv is used to try to load a
    # .env file, then uses any SEQUELIZER_* environment variables as
    # database options
    def initialize(options = nil)
      @options = Options.new(options)
    end

    # Returns a Sequel connection to the database
    def connection
      hash = options.to_hash
      if hash[:url]
        Sequel.connect(hash.delete(:url), hash)
      else
        Sequel.connect(hash)
      end
    end
  end
end

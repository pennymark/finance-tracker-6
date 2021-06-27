class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true


    def self.new_lookup(ticker_symbol =params[:stock])
        token = Rails.application.credentials.iex_client[:sandbox_p_api_key]

        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_p_api_key],
                                        secret_token: Rails.application.credentials.iex_client[:sandbox_s_api_key],
                                        endpoint: 'https://sandbox.iexapis.com/stable/stock/'+ticker_symbol+'/quote?token='+token)

        begin
            fetch = client.quote(ticker_symbol)
            new(ticker: ticker_symbol, name: fetch.company_name, last_price: fetch.latest_price)
        rescue => exception
            return nil
        end
    end

    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
end


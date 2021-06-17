class Stock < ApplicationRecord
    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_p_api_key],
                                        secret_token: Rails.application.credentials.iex_client[:sandbox_s_api_key],
                                        endpoint: 'https://sandbox.iexapis.com')
        return client.price(ticker_symbol)
    end
end

module Integration
  module Contact
    require 'telegram/bot'

    class ContactBot

      def initialize
        @token = '1700987771:AAHcAIZAa3AHR89mTf9eSdxdBT4MpEFBIEY'
        @chat_id = '990065756'
      end

      def send_message(base_message)
        Telegram::Bot::Client.run(@token) do |bot|
          bot.api.send_message(chat_id: @chat_id, text: base_message)
        end
      end

      def message(model)
        base_message = "
    NOVO CONTATO RECEBIDO

  Informações do Cliente:
  Nome: #{model.firstname} #{model.lastname}
  Email: #{model.email}
  Produto base: #{model.product_id}
  Messagem:
  #{model.message}
  "
        self.send_message(base_message)
      end
    end
  end
end
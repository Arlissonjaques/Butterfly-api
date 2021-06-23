# frozen_string_literal: true

module Integration
  module Contact
    require 'telegram/bot'

    class ContactBot
      def send_message(base_message)
        Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
          bot.api.send_message(chat_id: ENV['CHAT_ID'], text: base_message)
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
        send_message(base_message)
      end
    end
  end
end

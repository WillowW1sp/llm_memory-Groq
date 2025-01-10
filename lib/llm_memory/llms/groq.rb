require "groq"
require "llm_memory"

module LlmMemory
  module Llms
    module GroqCloud
      def client
        #change this to the qroc chat commands
=begin     
        @client ||= OpenAI::Client.new(
          access_token: LlmMemory.configuration.openai_access_token
        )
=end
        @client = Groq::Client.new
        
        Groq.configure do |config|
          config.api_key = "..."
          config.model_id = "llama-3.1-70b-versatile"
        end
        client = Groq::Client.new
      end
    end
  end
end

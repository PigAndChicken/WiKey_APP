module WiKey
  module Forms
    InputReg = Dry::Validation.Form do
      INPUT_REGEX = /^[a-zA-Z0-9](.*[a-zA-Z0-9])$/

      required(:topic).filled(format?: INPUT_REGEX)

      configure do
        config.messages_file = File.join(__dir__, 'errors/input_reg.yml')
      end
    end
  end
end

require 'rails_helper'

describe TempChecker do
  describe ".check_temps" do
    let(:test_message) { double(Message, 'body=' => "", body: "", send_text_message: true) }

    context 'temperatures are too high' do
      let!(:temp1) { Temperature.create(temperature: 41, created_at: (DateTime.now - 30.minutes)) }
      let!(:temp2) { Temperature.create(temperature: 44, created_at: (DateTime.now - 20.minutes)) }
      let!(:temp3) { Temperature.create(temperature: 42, created_at: (DateTime.now - 10.minutes)) }
      let!(:temp4) { Temperature.create(temperature: 42, created_at: (DateTime.now)) }

      it 'sends a text message if temperatures are too high in past half hour' do
        tc = TempChecker.new(test_message)
        expect(test_message).to receive(:send_text_message)
        tc.perform
      end

      it 'sends the correct message if temperatures are too high' do
        message = Message.new("")
        tc = TempChecker.new(message)
        allow_any_instance_of(Message).to receive(:send_text_message) {true}
        tc.perform
        expect(message.body).to eq("Temperature is too high")
      end
    end

    context 'no data' do
      it 'sends a text message if there is no data from past half hour' do
        tc = TempChecker.new(test_message)
        expect(test_message).to receive(:send_text_message)
        tc.perform
      end
      
      it 'sends the correct message if there is no data' do
        message = Message.new("")
        tc = TempChecker.new(message)
        allow_any_instance_of(Message).to receive(:send_text_message) {true}
        tc.perform
        expect(message.body).to eq("No temperature reading in the last 30 minutes")
      end
    end
  end
end
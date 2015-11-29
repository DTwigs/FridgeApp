require 'rails_helper'

describe TempChecker do
  describe ".check_temps" do
    context 'temperatures are too high' do
      let(:temp1) { Temperature.create(temperature: 41, created_at: (DateTime.now - 30.minutes)) }
      let(:temp2) { Temperature.create(temperature: 44, created_at: (DateTime.now - 20.minutes)) }
      let(:temp3) { Temperature.create(temperature: 42, created_at: (DateTime.now - 10.minutes)) }
      let(:temp4) { Temperature.create(temperature: 42, created_at: (DateTime.now)) }

      before do
        temp1;temp2;temp3;temp4
      end
      it 'sends a text message if temperatures are too high in past half hour' do
        test_message = Message.new(" ")
        tc = TempChecker.new(test_message)
        expect(test_message).to receive(:send_text_message)
        tc.perform
      end
    end
  end
end
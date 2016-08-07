RSpec.describe Transaction do
  describe 'modify_balance' do
    context 'when the transaction is a credit' do
      it 'should return the balance minus the credit' do
        let(:payment) { FactoryGirl.build(:payment, credit: 10.00) }
        let(:balance) { 20.00 }
        expect(modify_balance(:balance)).to eq(10.00)
      end
    end
  end
end

require 'atm'
require 'yaml'

describe 'Atm' do
  let(:account) { YAML.load_file('config.yml') }
  subject { Atm.new(account) }

  let (:valid_account) {subject.accounts[3321]}

  describe "validation atm accounts" do
    it "user enter valid account_id and password" do
      expect(valid_account["password"]).to eq("mypass")
    end

    it "user enter valid account_id and wrong password" do
      expect(valid_account["password"]).not_to eq("mypass1")
    end
  end
end
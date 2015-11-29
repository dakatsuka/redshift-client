require 'spec_helper'

describe Redshift::Client::Configuration do
  describe "#resolve" do
    subject { Redshift::Client::Configuration.resolve({host: "localhost"}) }
    it { is_expected.to be_a Redshift::Client::Configuration }
  end

  describe "#params" do
    let(:params) do
      {
        host: "localhost",
        port: 5439,
        user: "root",
        password: "password",
        dbname: "dev"
      }
    end

    subject { Redshift::Client::Configuration.resolve(params).params }
    it { is_expected.to eq params }
  end
end

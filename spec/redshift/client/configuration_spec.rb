require 'spec_helper'

describe Redshift::Client::Configuration do
  describe "#resolve" do
    subject { Redshift::Client::Configuration.resolve({host: "localhost"}) }
    it { is_expected.to be_a Redshift::Client::Configuration }

    context "when host param differs from redshift URL" do
      subject { Redshift::Client::Configuration.resolve({host: "my.redshift.com"}) }

      it "should NOT override params with the resolved redshift url" do
        expect(subject.host).to eq('my.redshift.com')
      end
    end
  end

  describe "#params" do
    let(:params) do
      {
        host: "localhost",
        port: 5439,
        user: "root",
        password: "password",
        dbname: "dev",
        sslmode: "require"
      }
    end

    subject { Redshift::Client::Configuration.resolve(params).params }
    it { is_expected.to eq params }
  end
end

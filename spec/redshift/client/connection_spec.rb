require 'spec_helper'

describe Redshift::Client::Connection do
  let(:configuration) { Redshift::Client::Configuration.resolve }

  describe "#initialize" do
    before do
      allow(PG).to receive(:connect)
    end

    it "calls PG#connect" do
      Redshift::Client::Connection.new(configuration)
      expect(PG).to have_received(:connect).with(configuration.params).once
    end
  end
end

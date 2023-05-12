require 'spec_helper'

describe Redshift::Client::Connection do
  let(:configuration) { Redshift::Client::Configuration.resolve }
  let(:connection) { double('connection', 'type_map_for_results=' => nil, 'exec' => nil) }

  describe "#initialize" do
    before do
      allow(PG).to receive(:connect)
    end

    it "calls PG#connect" do
      expect(PG)
        .to receive(:connect)
        .with(configuration.params)
        .once
        .and_call_original
      Redshift::Client::Connection.new(configuration)
    end

    it "registers basic type maps for JSON parsing" do
      expect(PG)
        .to receive(:connect)
        .with(configuration.params)
        .once
        .and_return(connection)
      expect(PG::BasicTypeMapForResults)
        .to receive(:new)
        .with(connection)
        .once
      Redshift::Client::Connection.new(configuration)
    end
  end
end

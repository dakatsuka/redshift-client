require 'spec_helper'

describe Redshift::Client::Connection do
  let(:configuration) { Redshift::Client::Configuration.resolve }
  let(:connection) { double('connection', 'type_map_for_results=' => nil, 'exec' => nil) }
  let(:registry) { double('registry') }

  describe "#initialize" do
    before do
      allow(PG).to receive(:connect)
      allow(PG::BasicTypeRegistry).to receive(:new).and_return(registry)
      allow(registry)
        .to receive(:register_default_types)
      allow(registry)
        .to receive(:coders_for)
      allow(registry)
        .to receive(:register_type)
        .with(0, 'timestamp', PG::TextEncoder::TimestampWithoutTimeZone, PG::TextDecoder::TimestampUtcToLocal)
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
        .with(connection, registry: registry)
        .once
      Redshift::Client::Connection.new(configuration)
    end
  end
end

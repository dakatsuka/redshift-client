require 'spec_helper'

describe Redshift::Client::Loggable do
  describe '#logger=' do
    let(:logger) do
      log = Logger.new($stdout)
      log.level = Logger::INFO
      log
    end

    before do
      Redshift::Client.logger = logger
    end

    it "sets my logger" do
      expect(Redshift::Client.logger).to eq logger
    end
  end
end

require 'spec_helper'

describe Redshift::Client do
  it 'has a version number' do
    expect(Redshift::Client::VERSION).not_to be nil
  end

  describe '#establish_connection' do
    it 'establishes connection' do
      expect {
        Redshift::Client.establish_connection
      }.to change {
        Redshift::Client.established?
      }.from(false).to(true)
    end
  end

  describe '#disconnect' do
    before do
      Redshift::Client.establish_connection
      Redshift::Client.connection
    end

    it 'disconnects from database' do
      expect {
        Redshift::Client.disconnect
      }.to change {
        Redshift::Client.connected?
      }.from(true).to(false)
    end
  end

  describe '#connected?' do
    context "when already connected" do
      before do
        Redshift::Client.establish_connection
        Redshift::Client.connection
      end

      after do
        Redshift::Client.disconnect
      end

      it "returns true" do
        expect(Redshift::Client).to be_connected
      end
    end

    context "when not yet connected" do
      it "returns false" do
        expect(Redshift::Client).not_to be_connected
      end
    end
  end

  describe "#connection" do
    context "when already established" do
      before do
        Redshift::Client.establish_connection
      end

      it "returns PG::Connection" do
        expect(Redshift::Client.connection).to be_instance_of PG::Connection
      end
    end

    context "when not yet established" do
      before do
        allow(ActiveSupport).to receive :run_load_hooks
      end

      it "calls ActiveSupport#run_load_hooks and raise error" do
        Thread.new {
          expect { Redshift::Client.connection }.to raise_error(Redshift::Client::ConnectionNotEstablished)
          expect(ActiveSupport).to have_received(:run_load_hooks).with(:redshift_client_connection).once
        }.join
      end
    end
  end

  describe "#established?" do
    context "when already established" do
      before do
        Redshift::Client.establish_connection
      end

      after do
        Redshift::Client.disconnect
      end

      it "returns true" do
        expect(Redshift::Client).to be_established
      end
    end

    context "when not yet established" do
      it "returns false" do
        Thread.new { expect(Redshift::Client).not_to be_established }.join
      end
    end
  end
end

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
        expect(Redshift::Client).not_to be_established
      end
    end
  end
end

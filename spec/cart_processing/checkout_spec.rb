# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Checkout' do
  describe 'errors handling' do
    it 'with empty source' do
      CartProcessing.reset
      expect { CartProcessing::Checkout.new }.to raise_error(CartProcessing::Errors::Configuration)
    end

    it 'with wrong source' do
      CartProcessing.configure do |c|
        c.source = :text
        c.source_path = 'wrong/file/path'
      end

      subject = CartProcessing::Checkout.new
      expect { subject.scan('VOUCHER') }.to raise_error(CartProcessing::Errors::InvalidSource)
    end

    it 'with unavailable source type' do
      config = CartProcessing.configuration
      expect { config.source = :sql }.to raise_error(CartProcessing::Errors::UnavailableSourceType)
    end
  end

  describe '.total' do
    before(:all) do
      CartProcessing.configure do |c|
        c.source = :text
        c.source_path = 'spec/cart_processing/test_data/test_products.csv'
      end
    end

    it 'counts without rules' do
      subject = CartProcessing::Checkout.new
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      subject.scan('VOUCHER')

      expect(subject.total).to eq('30.00€')
    end

    context 'with rules' do
      it 'do not apply rules' do
        pricing_rules = []
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('MUG')

        expect(subject.total).to eq('32.50€')
      end

      it 'handles nonexisting products' do
        pricing_rules = [CartProcessing::XMorePricing.new('TSHIRT', 3, 19.0)]
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('TSHIRT')
        subject.scan('MUG')
        subject.scan('SUPERMUG')

        expect(subject.total).to eq('27.50€')
        expect(subject.errors).to include CartProcessing::Errors::ProductNotFound
        expect(subject.errors.last.message).to eq "Product with code 'SUPERMUG' is not found"
      end

      it 'applies 2-for-one for VOUCHERs' do
        pricing_rules = CartProcessing::TwoForOnePricing.new('VOUCHER')
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')

        expect(subject.total).to eq('25.00€')
      end

      it 'applies x-more rule for TSHIRTs' do
        pricing_rules = CartProcessing::XMorePricing.new('TSHIRT', 3, 19.0)
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')

        expect(subject.total).to eq('81.00€')
      end

      it 'applies both x-more and 2-for-1' do
        pricing_rules = [
          CartProcessing::XMorePricing.new('TSHIRT', 3, 19.0),
          CartProcessing::TwoForOnePricing.new('VOUCHER')
        ]
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
        subject.scan('VOUCHER')
        subject.scan('MUG')
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')

        expect(subject.total).to eq('74.50€')
      end

      it 'applies last passed rule for a product' do
        pricing_rules = [
          CartProcessing::TwoForOnePricing.new('VOUCHER'),
          CartProcessing::XMorePricing.new('VOUCHER', 3, 2.0)
        ]
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('VOUCHER')
        subject.scan('VOUCHER')
        subject.scan('VOUCHER')
        subject.scan('VOUCHER')

        expect(subject.total).to eq('8.00€')
      end
    end
  end
end

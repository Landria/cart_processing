# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Checkout' do
  describe '.total' do
    it 'counts without rules' do
      subject = CartProcessing::Checkout.new
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      subject.scan('VOUCHER')

      expect(subject.total).to eq('30.00€')
    end

    context 'with rules' do
      it 'do not apply rules' do
        pricing_rules = {}
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('MUG')

        expect(subject.total).to eq('32.50€')
      end

      it 'handles nonexisting products' do
        pricing_rules = {}
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('TSHIRT')
        subject.scan('MUG')
        subject.scan('SUPERMUG')

        expect(subject.total).to eq('27.50€')
      end

      it 'applies 2-for-one for VOUCHERSs' do
        pricing_rules = {}
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')

        expect(subject.total).to eq('25.00€')
      end

      it 'applies x-more rule for TSHIRTs' do
        pricing_rules = {}
        subject = CartProcessing::Checkout.new(pricing_rules)
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')

        expect(subject.total).to eq('81.00€')
      end

      it 'applies both x-more and 2-for-1' do
        pricing_rules = {}
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
    end
  end
end

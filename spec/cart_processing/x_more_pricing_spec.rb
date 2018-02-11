# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'XmorePricing' do
  let(:subject) { CartProcessing::XMorePricing.new('TSHIRT', 3, 19.0, 20.00) }
  it { expect(subject.sub_total(0)).to eq(0) }
  it { expect(subject.sub_total(1)).to eq(20.00) }
  it { expect(subject.sub_total(2)).to eq(40.00) }
  it { expect(subject.sub_total(3)).to eq(57.00) }
  it { expect(subject.sub_total(10)).to eq(190.00) }
end

# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'TwoForOnePricing' do
  let(:subject) { CartProcessing::TwoForOnePricing.new('MUG', 7.5) }
  it { expect(subject.sub_total(0)).to eq(0) }
  it { expect(subject.sub_total(1)).to eq(7.5) }
  it { expect(subject.sub_total(2)).to eq(7.5) }
  it { expect(subject.sub_total(3)).to eq(15.0) }
  it { expect(subject.sub_total(4)).to eq(15.0) }
  it { expect(subject.sub_total(5)).to eq(22.5) }
end

# CartProcessing

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/cart_processing`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cart_processing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cart_processing

## Usage

### Configuration

Set checkout data source type and source path

```
CartProcessing.configure do |config|
  config.access_key = ''
  config.secret_key = ''
  config.personal_key = ''
end
```

### Using

You can set up two type of pricing policies:
  - XMoreProcing if you want to set a discount to specific product over x items.
  - TwoForOnePricing if you want to offer every second item for free

```
pricing_rules = [
  CartProcessing::XMorePricing.new('TSHIRT', 3, 19.0),
  CartProcessing::TwoForOnePricing.new('VOUCHER')
]

co = CartProcessing::Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("VOUCHER")
co.scan("TSHIRT")
price = co.total
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/landria/cart_processing. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

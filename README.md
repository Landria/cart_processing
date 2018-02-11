# CartProcessing

Simple cart processing gem (https://github.com/cabify/rubyChallenge challenge solution)

Ruby version >= 2.4.1

## Installation

Clone the repository

    $ git clone git@github.com:Landria/cart_processing.git

Build the gem and install it

    $ cd cart_processing && bin/setup
    $ gem build cart_processing.gemspec
    $ gem install ./cart_processing-0.1.0.gem

## Usage

### Configuration
Before test the gem copy products test data

    $ cp spec/cart_processing/test_data/test_products.csv /tmp/test_products.csv

Or specify your custom products.csv file

Now you can use the gem. Just add it to your .rb file

```
require 'cart_processing'
```

Set checkout data source type and source path. Only :text source is available (:sql source is planned to be added).

```
CartProcessing.configure do |config|
  config.source = :text
  config.source_path = '/tmp/test_products.csv'
end
```

### Using

You can set up two types of pricing policies:
  - *XMorePricing* if you want to set a discount to specific product over x items.
  - *TwoForOnePricing* if you want to offer every second item for free

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

Use *spec/cart_processing/test_data/test_products.csv* to test the gem or copy it contents.

## Solution notes

Challenge task is impelemnted as a ruby gem to let it be maintainable and used in a most simple way. It's designed to make adding new functionality as simple as possible.

Gem is configurable so you can easly switch the products source if needed. (only :text is are available right now, :sql is planned to be added).

SQL source is unavailable yet cause we have only 3 products to process and csv file is enougth.

If several pricing rules passed for the same product only the last one will be applyed at checkout.

If several products with the same code exists only the first one will be found (we assume that products are uniq.

If nonexisting product code scanned error will be added to CartProcerssing::Checkout instance.

Error is to be raised when
  - gem is not configured,
  - source is unreachable,
  - source type is unavailable.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

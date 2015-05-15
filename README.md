# Omniauth::ProviderRegistry

Provides access to your application's configured OmniAuth providers

## Motivation

Your configured providers contain a lot of information that may be useful in
other parts of your application. Sometimes you specify the information when you
configure the provider, so you already have access to it. But there is also
some information built into the strategy itself, that is not easy to access.

The `ProviderRegistry` allows you to retrieve all information available for
your configured strategies.

## Usage

```
configured_provider = OmniAuth::ProviderRegistry.find(:github)
configured_provider.options.client_id           # 1234567890123234
configured_provider.options.client_options.site # https://api.github.com
```

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-provider_registry'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-provider_registry


## Contributing

1. Fork it ( https://github.com/joshuaflanagan/omniauth-provider_registry/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# Basic Rack Application

## Table of Contents

1. [Demo Application from `rack`](#i-demo-application-from-rack)

## I. Demo Application from `rack`

The stock demo `lobster` application can run by by

```ruby
require 'rack'
require 'rack/lobster'

run Rack::Lobster.new
```

## II. Adding a Custom Middleware Module

### A. Calling the Base Application

A middleware module invokes the base application by

In middleware class,

```ruby
app.call(env)
```

In `config.ru`,

```ruby
use Shrimp # middleware module
run Rack::Lobster.new # base application
```

#### Notes

1. `app` is an instance of `Rack::Lobster` in this case
2. `env` contains header information like `REQUEST_METHOD`, `HTTP_USER_AGENT`,
etc

Please see tag `jl/middleware-calling-base-app`

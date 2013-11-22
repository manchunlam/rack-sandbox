# Basic Rack Application

## Table of Contents

1. [Demo Application from `rack`](#i-demo-application-from-rack)
2. [Adding a Custom Middleware Module](#ii-adding-a-custom-middleware-module)
    1. [Calling the Base Application](#a-calling-the-base-application)
    2. [Execute Code before Response Hits Base Application]
(#b-execute-code-before-response-hits-base-application)
    3. [Changing the `header` and `body` of the Response using Middleware]
(#c-changing-the-header-and-body-of-the-response-using-middleware)

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

### B. Execute Code before Response Hits Base Application

In the middleware class, put custom code inside the `call` method, and before
calling the base application.

```ruby
def call(env)
  do_something_custom(args)

  @app.call(env)
end
```

Checkout tag `jl/middleware-doing-something`, and observe the log. You will see

1. A "walking shrimp" is on the log (`shrimp.rb` line 13)
2. The "walking shrimp" gets printed **before** the actual request hits the
application

    ```text
       |///
        .*----___// <-- it was supposed to be a walking shrimp...
        <----/|/|/|
    127.0.0.1 - - [22/Nov/2013 15:55:53] "GET / HTTP/1.1" 200 592 0.0008
    ```

### C. Changing the `header` and `body` of the Response using Middleware

1. First, get the `status`, `header`, and `response` of the **original** base
application

    ```ruby
    status, headers, response = @app.call(env) # calling the base app
    ```

2. Modify value of header elements

    ```ruby
    headers['Content-Length'] = 1234
    ```

3. Modify the `body` of the final response
    * The **return value** of the `call` method in a middleware **dictates** the
        final response
    * Example:

        ```ruby
        [status, headers, ['My new response body']]
        ```

        The `[]` around the string is absolutely necessary. The response-body
        cannot just be a pure `String`

Please see tag `jl/middleware-change-body-header`

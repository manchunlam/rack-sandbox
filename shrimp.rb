class Shrimp
  SHRIMP_STRING = <<-END
   |///
    .*----___// <-- it was supposed to be a walking shrimp...
    <----/|/|/|
  END

  def initialize(app)
    @app = app
  end

  def call(env)
    puts SHRIMP_STRING

    @app.call(env)
  end
end

# encoding: UTF-8

class Shrimp
  SHRIMP_STRING = <<-END
  Below is a shrimp, supposedly, at least

  　　　　　 ,. '´￣￣￣￣￣￣￣￣￣￣￣｀`ヽ、
  　　　　／　　　　　 　 　 　 ＿＿＿＿＿_ 　 　 ＼
  　　 ／　 　 　 ,. -‐￢勿" 巡ｼ ,.ｨ'"il! il lｉ /ヽ、 　 ヽ
  　 （　　　　∠゛○,ｨ彡' ,.イジ゛'"　　il! li il　彡ﾍ　　　）
  　　`ｰ=ニ三三彡ク￢テﾃァｧr＿__／ﾌ水= ｒil}
  　　 　 　 　 　 　 ^ ,／ ,/〃||/||,.イ　 ´´丁ﾌ =i!
  　　　　　　　　　　　　　　｀ ヾ ヾ、ヽ、　 乃 、_!
  　　　　　　　　　　　　　　　　　　　　　 く／ //
  　　　　　　　　　　　 　 　 　 　 　 　 　 ヽ∠/
  END

  def initialize(app)
    @app = app
  end

  def call(env)
    puts SHRIMP_STRING

    status, headers, response = @app.call(env)

    response_body = ""
    response.each { |part| response_body += part }
    response_body += "<pre>#{SHRIMP_STRING}</pre>"

    headers['Content-Type'] = 'text/html; charset=utf-8'
    headers['Content-Length'] = Rack::Utils.bytesize(response_body).to_s

    [status, headers, [response_body]]
  end
end

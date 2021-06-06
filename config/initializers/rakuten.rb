RakutenWebService.configure do |c|
  # (必須) アプリケーションID
  c.application_id = '1027697410333068131'

  # (任意) 楽天アフィリエイトID
  c.affiliate_id = ENV['AFFILIATE_ID']

end
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:ac2292ba338595601b9509f2a3d3f0c5@tarpon.redistogo.com:11069/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:ac2292ba338595601b9509f2a3d3f0c5@tarpon.redistogo.com:11069/' }
end

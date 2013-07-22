
require 'rake/hooks'

after 'assets:precompile' do
  logger       = Logger.new($stderr)
  logger.level = Logger::INFO

  env = Sprockets::Environment.new(Rails.root)
  env.append_path File.join(Rails.root, "public", Rails.application.config.assets.prefix)

  files = Dir.glob(File.join(Rails.root, "public", Rails.application.config.assets.prefix, "**/**"))
  files.find_all{ |f| f =~ /\.(otf|eot|svg|ttf|woff)$/ }.each do |f|
    logger.info "Compressing #{f}"
    asset = Sprockets::StaticAsset.new(env, f, f)
    asset.write_to("#{f}.gz")
  end
end

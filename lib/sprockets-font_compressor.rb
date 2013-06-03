
module Sprockets
  class StaticCompiler

    # override method to enable compression of more filetypes
    def write_asset(asset)
      path_for(asset).tap do |path|
        env.logger.info "writing asset: #{path}"
        filename = File.join(target, path)
        FileUtils.mkdir_p File.dirname(filename)
        asset.write_to(filename)

        # monkeypatched to add more file formats
        if filename.to_s =~ /\.(css|js|otf|eot|svg|ttf|woff)$/
          env.logger.info "writing asset: #{path}.gz"
          asset.write_to("#{filename}.gz")
        end
      end
    end

  end
end

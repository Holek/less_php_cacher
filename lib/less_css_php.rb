require 'rubygems'
require 'less'
 
module Less
  class PHP
    
    def self.prepare
      FileUtils.mkdir('less-cache', :mode => 0777) unless File.directory?('less-cache')
      FileUtils.cp(File.expand_path(File.join(File.dirname(__FILE__), '..', 'src', 'less.php')), 'less.php')
    end
    
    def self.remove
      FileUtils.rm('less.php')
    end
    
    def self.update
      remove
      prepare
    end
  
    def self.ready?
      File.directory?('less-cache') && File.exist?('less.php')
    end
    
    def self.cache(source)
      @source = "#{source}.less"
      @cache = File.join('less-cache', "#{source}.css")
      css = Less::Engine.new(File.new(@source)).to_css
      FileUtils.mkpath(File.dirname(@cache))
      File.open(@cache, 'w') do |f|
        f.write css
      end
      print css
    end
  end
end
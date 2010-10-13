module YAML
  LOCATIONS = {'config' => 'config', 'view' => 'lib/merrol/views'}

  def self.method_missing(meth, *args, &block)
    dir = LOCATIONS[meth.to_s.gsub(/load_/, '')]
    super unless dir
    self.load File.open(File.app_relative("#{dir}/#{args[0]}.yml"))
  end
end


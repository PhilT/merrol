class File
  def self.app_relative relative_path
    File.join(File.dirname(__FILE__), '..', '..', relative_path)
  end
end


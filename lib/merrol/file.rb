class File
  def self.app_relative relative_path
    expand_path join(dirname(__FILE__), '..', '..', relative_path)
  end
end


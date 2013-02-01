guard 'minitest' do
  watch(%r|^spec/(.*)_spec\.rb|)
  watch(%r|^lib/merrol/(.*)([^/]+)\.rb|)  { |m| "spec/unit/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r|^lib/merrol/merrol.rb|)        { |m| "spec/merrol_spec.rb" }
  watch(%r|^spec/spec_helper\.rb|)        { "spec" }
end


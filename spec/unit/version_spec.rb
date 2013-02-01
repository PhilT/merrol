describe 'VERSION' do
  it 'returns the correct version' do
    Merrol::VERSION.must_match /[0-9]+\.[0-9]+\.[0-9]+/
  end
end


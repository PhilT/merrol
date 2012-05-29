describe 'app_path' do
  it 'points to the lib folder' do
    APP_PATH.must_match /\/merrol\/lib$/
  end
end

describe 'project_path' do
  it 'points to the folder the application was started in' do
    PROJECT_PATH.must_match /\/tmp\/project$/
  end
end


describe '0.0.0 - Basic executable GUI window' do
  before { starting_application }
  after { quit_application }

  it 'starts and closes application' do
    shows 'merrol'

    pressing 'CTRL+Q'
    quits_application
  end
end


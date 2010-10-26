require 'spec_helper'
require 'support/setup'
require 'support/actions'
require 'support/expectations'

Rspec.configure do |c|
  c.before(:all) do
    $application = Application.new WORKING_DIR, [] unless $application
  end
end


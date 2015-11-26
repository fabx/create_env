require 'spec_helper'
describe 'create_env' do

  context 'with defaults for all parameters' do
    it { should contain_class('create_env') }
  end
end

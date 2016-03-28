require 'spec_helper'
describe 'cygwin_git_encrypt' do

  context 'with defaults for all parameters' do
    it { should contain_class('cygwin_git_encrypt') }
  end
end

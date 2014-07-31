require 'spec_helper'

describe 'osx::dashboard' do
  let(:facts) { {:boxen_user => 'ilikebees'} }
  describe 'enabled' do
    let(:params) { {:ensure => 'present'} }
    it 'should set value to true' do
      should contain_boxen__osx_defaults('Toggle Whether Dashboard is Enabled').with({
        :user   => facts[:boxen_user],
        :key    => 'mcx-disabled',
        :domain => 'com.apple.dashboard',
        :value  => true,
        :notify => 'Exec[killall Dock]',
      })
    end
  end

  describe 'disabled' do
    let(:params) { {:ensure => 'absent'} }
    it 'should set value to false' do
      should contain_boxen__osx_defaults('Toggle Whether Dashboard is Enabled').with({
        :user   => facts[:boxen_user],
        :key    => 'mcx-disabled',
        :domain => 'com.apple.dashboard',
        :value  => false,
        :notify => 'Exec[killall Dock]',
      })
    end
  end

end

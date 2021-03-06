require 'spec_helper'

describe 'collectd::plugin::logfile', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0'
    }
  end
  context ':ensure => present, default params' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '4.8.0'
      }
    end

    it 'Will create /etc/collectd.d/05-logfile.conf' do
      should contain_file('logfile.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/05-logfile.conf').without_content(%r{PrintSeverity})
    end
  end

  context ':ensure => present, specific params, collectd version 4.9' do
    let :facts do
      {
        osfamily: 'Redhat',
        collectd_version: '4.9.0'
      }
    end
    let :params do
      { print_severity: true }
    end

    it 'Will create /etc/collectd.d/05-logfile.conf for collectd < 4.10' do
      should contain_file('logfile.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/05-logfile.conf').without_content(%r{PrintSeverity})
    end
  end

  context ':ensure => present, default params, collectd version 4.10' do
    let :facts do
      {
        osfamily: 'Redhat',
        collectd_version: '4.10.0'
      }
    end

    it 'Will create /etc/collectd.d/05-logfile.conf for collectd >= 4.10' do
      should contain_file('logfile.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/05-logfile.conf',
                                               content: %r{PrintSeverity false})
    end
  end

  context ':ensure => present, specific params, collectd version 4.10' do
    let :facts do
      {
        osfamily: 'Redhat',
        collectd_version: '4.10.0'
      }
    end
    let :params do
      { print_severity: true }
    end

    it 'Will create /etc/collectd.d/05-logfile.conf for collectd >= 4.10' do
      should contain_file('logfile.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/05-logfile.conf',
                                               content: %r{PrintSeverity true})
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '4.8.0'
      }
    end
    let :params do
      { ensure: 'absent' }
    end

    it 'Will not create /etc/collectd.d/05-logfile.conf' do
      should contain_file('logfile.load').with(ensure: 'absent',
                                               path: '/etc/collectd.d/05-logfile.conf')
    end
  end
end

class osx::dashboard($ensure = 'present') {

  validate_re($ensure, '^(present|absent)$', "osx::dashboard([ensure] must be present or absent, is ${ensure}")

  $enabled = $ensure ? {
    present => true,
    default => false
  }

  boxen::osx_defaults { 'Toggle Whether Dashboard is Enabled':
    user   => $::boxen_user,
    key    => 'mcx-disabled',
    domain => 'com.apple.dashboard',
    value  => $enabled,
    notify => Exec['killall Dock'],
  }
}

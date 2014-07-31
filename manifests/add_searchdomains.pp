class osx::add_searchdomains {
    $plist_buddy = '/usr/libexec/PlistBuddy'
    $plist = '/System/Library/LaunchDaemons/com.apple.mDNSResponder.plist'
    $launchctl = '/bin/launchctl'

  exec {
    'osx-add-searchdomains':
      command => "$plist_buddy -c 'Add :ProgramArguments: string -AlwaysAppendSearchDomains' $plist",
      user    => 'root',
      unless  => "$plist_buddy -c 'Print ProgramArguments' $plist | grep -q AlwaysAppendSearchDomains",
      notify  => Exec['osx-unload-mdnsresponder'];
    'osx-unload-mdnsresponder':
      command     => "$launchctl unload -w $plist",
      user        => 'root',
      refreshonly => true,
      notify  => Exec['osx-load-mdnsresponder'];
    'osx-load-mdnsresponder':
      command     => "$launchctl load -w $plist",
      user        => 'root',
      refreshonly => true,
  }
}

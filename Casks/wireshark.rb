cask 'wireshark' do
  version '3.0.4'
  sha256 '82e5d5ac1379488e7de40965d68c0f66f50a409ebf1f0b94386d40d8b4b88951'

  url "https://www.wireshark.org/download/osx/Wireshark%20#{version}%20Intel%2064.dmg"
  appcast 'https://www.macupdater.net/cgi-bin/extract_text/extract_text_split_easy.cgi?url=https://www.wireshark.org/download.html&splitter_1=stable&index_1=1&splitter_2=development&index_2=0'
  name 'Wireshark'
  homepage 'https://www.wireshark.org/'

  conflicts_with cask: 'wireshark-chmodbpf'
  depends_on macos: '>= :sierra'

  pkg "Wireshark #{version} Intel 64.pkg"

  uninstall_preflight do
    set_ownership '/Library/Application Support/Wireshark'
    system_command '/usr/sbin/dseditgroup', args: ['-o', 'delete', 'access_bpf'], sudo: true
  end

  uninstall pkgutil:   'org.wireshark.*',
            launchctl: 'org.wireshark.ChmodBPF',
            delete:    [
                         '/private/etc/manpaths.d/Wireshark',
                         '/private/etc/paths.d/Wireshark',
                         '/usr/local/bin/capinfos',
                         '/usr/local/bin/dftest',
                         '/usr/local/bin/dumpcap',
                         '/usr/local/bin/editcap',
                         '/usr/local/bin/mergecap',
                         '/usr/local/bin/randpkt',
                         '/usr/local/bin/rawshark',
                         '/usr/local/bin/text2pcap',
                         '/usr/local/bin/tshark',
                         '/usr/local/bin/wireshark',
                       ]

  zap trash: '~/Library/Saved Application State/org.wireshark.Wireshark.savedState'
end

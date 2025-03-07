cask "evernote" do
  if MacOS.version <= :el_capitan
    version "7.2.3_456885"
    sha256 "eb9a92d57ceb54570c009e37fa7657a0fa3ab927a445eef382487a3fdde6bb97"

    url "https://cdn1.evernote.com/mac-smd/public/Evernote_RELEASE_#{version}.dmg"
  elsif MacOS.version <= :high_sierra
    version "7.14_458244"
    sha256 "1049a40b8497c0e37d7fed8828552dba89fa52c826134e05b0d56e431e5033ad"

    url "https://cdn1.evernote.com/mac-smd/public/Evernote_RELEASE_#{version}.dmg"
  else
    version "10.44.8,3632,36e33ef8ac"
    sha256 "c18cbfd659249d024aeb3ec4c28826bb419db2b5b1706ba25e2cb494a27e3a7b"

    url "https://cdn1.evernote.com/boron/mac/builds/Evernote-#{version.csv.first}-mac-ddl-ga-#{version.csv.second}-#{version.csv.third}.dmg"
  end

  name "Evernote"
  desc "App for note taking, organizing, task lists, and archiving"
  homepage "https://evernote.com/"

  livecheck do
    url "https://evernote.s3.amazonaws.com/boron/mac/public/latest-mac.yml"
    regex(/Evernote[._-](\d+(?:\.\d+)+)-mac-ddl-ga-(\d+(?:\.\d+)*)-([0-9a-f]+)\.dmg/i)
    strategy :electron_builder do |yaml, regex|
      yaml["files"]&.map do |file|
        match = file["url"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]},#{match[3]}"
      end
    end
  end

  auto_updates true

  app "Evernote.app"

  uninstall quit: [
    "com.evernote.Evernote",
    "com.evernote.EvernoteHelper",
  ]

  zap trash: [
    "~/Library/Application Support/Caches/evernote-client-updater",
    "~/Library/Application Support/com.evernote.Evernote",
    "~/Library/Application Support/com.evernote.EvernoteHelper",
    "~/Library/Application Support/Evernote",
    "~/Library/Caches/com.evernote.Evernote",
    "~/Library/Cookies/com.evernote.Evernote.binarycookies",
    "~/Library/Logs/Evernote",
    "~/Library/Preferences/com.evernote.Evernote.plist",
    "~/Library/Preferences/com.evernote.EvernoteHelper.plist",
    "~/Library/Saved Application State/com.evernote.Evernote.savedState",
  ]
end

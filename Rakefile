XCODEBUILD_OPTS = "-project StringScore.xcodeproj -derivedDataPath DerivedData"
IOS = "-scheme StringScore_Swift -sdk iphonesimulator9.3 -destination 'platform=iOS Simulator,name=iPhone 6'"
MACOSX = "-scheme StringScore_Swift -destination 'generic/platform=OS X'"

def xcpretty(cmd)
  sh "set -o pipefail; #{cmd} | xcpretty -c"
end

task default: %w[test]

task ci: %w[test:ios]

desc "Run all tests"
task test: %w[test:ios test:macosx]

namespace :test do
  desc "Test on iOS"
  task :ios do
    xcpretty "xcodebuild test #{XCODEBUILD_OPTS} #{IOS}"
  end

  desc "Test on Mac OS X"
  task :macosx do
    xcpretty "xcodebuild test #{XCODEBUILD_OPTS} #{MACOSX}"
  end
end

namespace :podspec do
  desc "Validate the podspec"
  task :lint do
    sh "pod lib lint"
  end
end

desc "Clean the default scheme"
task :clean do
  rm_rf "DerivedData"
end

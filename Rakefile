def run(command)
  p command
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

def currentDestination
    if ENV['DESTINATION']
      destination = ENV['DESTINATION']
    else
      destination = 'platform=iOS Simulator,name=iPhone 6s'
    end
end


$PROJECT = "Shari"
$WORKSPACE = "#{$PROJECT}.xcworkspace"

namespace 'clean' do

  task :demo do
    run "xcodebuild -workspace #{$WORKSPACE} -scheme #{$PROJECT}Demo clean"
  end

  task :framework do
    run "xcodebuild -workspace #{$WORKSPACE} -scheme #{$PROJECT} clean"
  end

end

namespace "build" do

  desc "Build for all iOS targets"
  task :ios do |task, args|

    destination = currentDestination
    run "xcodebuild -workspace #{$WORKSPACE} -scheme #{$PROJECT} -destination '#{destination}' -configuration Debug clean build TEST_AFTER_BUILD=YES | xcpretty"

  end

end

namespace "test" do

  desc "Test for all iOS targets"
  task :ios do |task, args|

    destination = currentDestination
    run "xcodebuild -workspace #{$WORKSPACE} -scheme #{$PROJECT} -destination '#{destination}' -destination-timeout 1 -sdk iphonesimulator -configuration Debug clean test | xcpretty"

  end

end

task default: ["build:ios"]

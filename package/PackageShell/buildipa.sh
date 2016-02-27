#!/bin/sh

profile_Name=`/usr/libexec/PlistBuddy -c "print profile_Name" ./PackageConfig/packageExample.plist`
ipa_Name=`/usr/libexec/PlistBuddy -c "print app_Name" ./PackageConfig/packageExample.plist`


cd ../PackageExample
echo "go to packageExample workspace path"

#

#buildDay=$(date +%Y%m%d)

buildTime=$(date +%Y%m%d%H%M)

profile="${profile_Name}"

echo $profile $ipa_Name

if [ ! -d "../PackageShell/Package" ]; then
mkdir ../PackageShell/Package
fi

if [ ! -d "../PackageShell/Package/ArchiveProduction" ]; then
    mkdir ../PackageShell/Package/ArchiveProduction
fi

if [ ! -d "../PackageShell/Package/ArchiveProduction/QA" ]; then
    mkdir ../PackageShell/Package/ArchiveProduction/QA
    echo "Create ArchiveProduction path"
fi

if [ ! -d "../PackageShell/Package/ipa" ]; then
    mkdir ../PackageShell/Package/ipa
fi

if [ ! -d "../PackageShell/Package/ipa/QA" ]; then
    mkdir ../PackageShell/Package/ipa/QA
    echo "Create ipa path"
fi

#

buildConfiguration="QA"

buildPath="../PackageShell/Package/ArchiveProduction/QA/${ipa_Name}_${buildTime}.xcarchive"

#ipaName="../PackageShell/Package/ipa/QA/${ipa_Name}_${buildTime}.ipa"
ipaName="../PackageShell/Package/ipa/QA/${ipa_Name}.ipa"

xctool -workspace PackageExample.xcworkspace -scheme PackageExample -configuration ${buildConfiguration} clean

xctool -workspace PackageExample.xcworkspace -scheme PackageExample -configuration ${buildConfiguration} archive -archivePath ${buildPath}

xcodebuild -exportArchive -exportFormat IPA -archivePath ${buildPath} -exportPath ${ipaName} -exportProvisioningProfile "$profile"
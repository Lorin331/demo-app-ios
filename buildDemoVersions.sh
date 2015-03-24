#!/bin/sh
 
#  build_Script.sh
#  iOS_IMKit_Demo
#
#  Created by Heq.Shinoda on 14-07-11.
#  Copyright (c) 2014年 Heq.Shinoda All rights reserved.


LASTVersion=$(cat versionsConfig)

TempVer=${LASTVersion%.*.*}
OlderVer=${TempVer#*.*.}
echo OlderVer=${OlderVer}
echo ${TempVer}


CurrentVer=$[OlderVer+1]

NEWVersion=${LASTVersion%.*.*.*}.$[OlderVer+1].${LASTVersion#*.*.*.}

sed -i '' "s;${OlderVer};${CurrentVer};" versionsConfig


DestDir="bin"
ReleaseDir="build"
version="$NEWVersion"
rm -rdf "$DestDir"
mkdir "$DestDir"
rm -rdf "$ReleaseDir"

ipafilename="iOS-IMKit-demo"
xcodebuild clean -configuration "Release"      
targetName="iOS-IMKit-demo"
 
 
ipapath="${PWD}/${DestDir}/${targetName}_v${version}.ipa"
 
xcodebuild -project iOS-IMKit-demo.xcodeproj -target "${targetName}" -configuration "Release"  -sdk iphoneos clean build
appfile="${ReleaseDir}/Release-iphoneos/${targetName}.app"

#xcodebuild clean archive -target "${targetName}" -sdk iphoneos -configuration AdHoc CODE_SIGN_IDENTITY="iPhone Distribution: Feinno Communication Tech Co. Ltd."

echo "***开始打ipa包****"
xcrun -sdk iphoneos PackageApplication "$appfile" -o "$ipapath" #--sign "iPhone Distribution: Feinno Communication Tech Co. Ltd." --embed "RCloud_UIComponent_Distribution.mobileprovision"
#/usr/bin/xcrun -sdk iphoneos PackageApplication -v "$appfile" -o "$ipapath" --sign "iPhone Distribution: Feinno Communication Tech Co. Ltd."


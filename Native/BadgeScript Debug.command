#!/bin/bash

# CONFIGURE -------------------------
# Only change variables in this block, do not change anything else, unless you know what you are doing!

#### ANDROID ####
# Path to Android, starting at where the script is located
ANDROID="Android/app"
# Name of the icon file (without extension)
ANDROID_FILE_START="ic_launcher"
# The flavor+buildtype name where the icon will be applied to (check your Build Variants for the correct name)
ANDROID_FLAVOR="debug"

#### iOS ####
# Path to iOS xcassets, starting at where the script is located
IOS="iOS/BadgeApp/BadgeApp/Assets.xcassets"
# Name of the icon file (without extension)
IOS_FILE_START="appicon"
# Name of the icon set to use
IOS_ICON_SET="AppIcon"
# The scheme name where the icon will be applied to
IOS_SCHEME="Debug"
#### GENERAL ####
# The name that will be used in Fastlane's fastfile
FASTLANE_LANE="debugMyApp"
# -----------------------------------

# Store the base dir
BASEDIR=$(dirname "$0")

# Colors for logs
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m' 
END='\033[0m'

# Make user confirm everything is properly configured
echo -e "${BLUE}### START BADGING ###${END}"

read -r -p "Did you properly configure the FASTFILE in the fastlane folder? [y/N] " response

case "$response" in
    [yY][eE][sS]|[yY]) 
	#All OK
        ;;
    *)
	echo -e "${RED}Configure the FASTFILE first! ${END}"
	echo -e "${BLUE}### FINISHED BADGESCRIPT ###${END}"
        exit 1
        ;;
esac

# Make user confirm everything is correct
echo -e "${GREEN}"
echo "Root: $BASEDIR"
echo "Android: $ANDROID"
echo "iOS: $IOS"
echo -e "${END}"

read -r -p "Is this info correct? [y/N] " response

case "$response" in
    [yY][eE][sS]|[yY]) 
	#All OK
        ;;
    *)
	echo -e "${RED}Stop! ${END}"
	echo -e "${BLUE}### FINISHED BADGESCRIPT ###${END}"
        exit 1
        ;;
esac

#### ANDROID ####
# Copy files
echo -e "${GREEN}Copying Android...${END}"
echo -e "${GREEN}Mipmap...${END}"

cp $BASEDIR/$ANDROID/src/main/res/mipmap-hdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/mipmap-hdpi/
cp $BASEDIR/$ANDROID/src/main/res/mipmap-mdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/mipmap-mdpi/
cp $BASEDIR/$ANDROID/src/main/res/mipmap-xhdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/mipmap-xhdpi/
cp $BASEDIR/$ANDROID/src/main/res/mipmap-xxhdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/mipmap-xxhdpi/
cp $BASEDIR/$ANDROID/src/main/res/mipmap-xxxhdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/mipmap-xxxhdpi/

echo -e "${GREEN}Drawable...${END}"

cp $BASEDIR/$ANDROID/src/main/res/drawable-hdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/drawable-hdpi/
cp $BASEDIR/$ANDROID/src/main/res/drawable-mdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/drawable-mdpi/
cp $BASEDIR/$ANDROID/src/main/res/drawable-xhdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/drawable-xhdpi/
cp $BASEDIR/$ANDROID/src/main/res/drawable-xxhdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/drawable-xxhdpi/
cp $BASEDIR/$ANDROID/src/main/res/drawable-xxxhdpi/$ANDROID_FILE_START* $BASEDIR/$ANDROID/src/$ANDROID_FLAVOR/res/drawable-xxxhdpi/

#### iOS ####
# Copy files
echo -e "${GREEN}Copying iOS...${END}"
echo $BASEDIR/$IOS/$IOS_ICON_SET.appiconset/$IOS_FILE_START
echo $BASEDIR/$IOS/$IOS_ICON_SET.${IOS_SCHEME}.appiconset/

cp $BASEDIR/$IOS/$IOS_ICON_SET.appiconset/$IOS_FILE_START* $BASEDIR/$IOS/$IOS_ICON_SET.$IOS_SCHEME.appiconset/

#### FASTLANE ####
# Run fastline
echo -e "${GREEN}Badging...${END}"
cd $BASEDIR
bundle exec fastlane $FASTLANE_LANE

echo ""
echo -e "${BLUE}### FINISHED BADGESCRIPT ###${END}"
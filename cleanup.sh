#!/usr/bin/env bash

RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
STD='\033[0m'
echo 

# Ask for the administrator password upfront
if [ "$EUID" -ne 0  ]; then
	echo -e ${RED}"Please run as root"${STD}
	exit
fi

Directories=(
	"Empty the Trash on all mounted volumes and the main HDD..." '/Volumes/*/.Trashes'
	"Clear System Log Files..." '/var/log/asl/*'
	"Clear System Log Files..." '/private/var/log/asl/*.asl'
	"Clear Diagnostic Reports..." '/var/log/DiagnosticReports/*'
	"Clear Diagnostic Reports..." '/Library/Logs/DiagnosticReports/*'
	"Clear Iconservices Store..." '/Library/Caches/com.apple.iconservices.store/*'
	"Clear CleverFiles Logs..." '/var/log/CleverFiles/*'
	"Clear Adobe Logs..." '/Library/Logs/Adobe/*'
	####### userdirs start here #######
	"Empty the user Trash" '~/.Trash'
	"Mail.app log files" '~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*'
	"Cleanup iOS Simulator Logs..." '~/Library/Logs/CoreSimulator/*'
	"Cleanup iOS Applications..." '~/Music/iTunes/iTunes\ Media/Mobile\ Applications/*'
	"Clear Adobe Cache Files..." '~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/*'
	"Remove iOS Device Backups..." '~/Library/Application\ Support/MobileSync/Backup/*'
	"Cleanup XCode Derived Data..." '~/Library/Developer/Xcode/DerivedData/*'
	"Cleanup XCode Archives..." '~/Library/Developer/Xcode/Archives/*'
	"Remove apple bird cache" '~/Library/Caches/com.apple.bird/*'
	"Safari cache data" '~/Library/Caches/com.apple.Safari/*'
	"Google Chrome cache" '~/Library/Caches/Google/Chrome/*'
	"Firefox cache" '~/Library/Caches/Firefox/*'
	"Yarn cache" '~/Library/Caches/Yarn/*'
	"Typescript cache" '~/Library/Caches/typescript/*'
	"Skype cache" '~/Library/Caches/com.skype.skype/*'
	"iTunes cache" '~/Library/Caches/com.apple.iTunes/*'
	"Photoshop cache" '~/Library/Caches/com.adobe.Photoshop/*'
	"Helpd cache" '~/Library/Caches/com.apple.helpd/*'
	"Apple Speech Recognition" '~/Library/Caches/com.apple.SpeechRecognitionCore/*'
	"xCode Junk Files" '~/Library/Developer/Xcode/DerivedData/ModuleCache/*'
	"Lwa Tracing log files (Skype)" '~/Library/Logs/LwaTracing/*'
	"Downloads log file" '~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2'
)

count=0
while [ "x${Directories[count]}" != "x" ]
do
	echo -e ${BLUE}${Directories[count]}${STD}
	count=$(( $count + 1 ))
	## need to split sudo needed and not...
	sudo rm -rfv ${Directories[count]} &>/dev/null
	count=$(( $count + 1 ))
done

echo -e ${BLUE}'Cleanup Homebrew Cache...'${STD}
brew cleanup --force -s &>/dev/null
brew cask cleanup &>/dev/null
rm -rfv /Library/Caches/Homebrew/* &>/dev/null
brew tap --repair &>/dev/null

echo -e ${BLUE}'Cleanup any old versions of gems'${STD}
gem cleanup &>/dev/null

echo -e ${YELLOW}'Purge inactive memory...'${STD}
sudo purge

echo -e ${GREEN}'Everything is cleaned up :3'${STD}

#!/usr/bin/env bash

# Array of agents and daemons to disable (focused on telemetry and non-essential services)
AGENTS=(
  com.apple.AMPArtworkAgent
  com.apple.AMPLibraryAgent
  com.apple.AOSNotificationOSX
  com.apple.AOSPushRelay
  com.apple.AddressBook.AssistantService
  com.apple.AddressBook.SourceSync
  com.apple.AddressBook.abd
  com.apple.AirPlayUIAgent
  com.apple.AirPlayXPCHelper
  com.apple.AirPortBaseStationAgent
  com.apple.CalendarAgent
  com.apple.CallHistoryPluginHelper
  com.apple.CallHistorySyncHelper
  com.apple.CrashReporterSupportHelper
  com.apple.DictationIM
  com.apple.ManagedClient.cloudconfigurationd
  com.apple.Maps.mapspushd
  com.apple.Safari.History
  com.apple.Safari.PasswordBreachAgent
  com.apple.Safari.SafeBrowsing.Service
  com.apple.SafariBookmarksSyncAgent
  com.apple.SafariCloudHistoryPushAgent
  com.apple.SafariHistoryServiceAgent
  com.apple.SafariLaunchAgent
  com.apple.SafariNotificationAgent
  com.apple.ScreenTimeAgent
  com.apple.SubmitDiagInfo
  com.apple.UsageTrackingAgent
  com.apple.appleseed.fbahelperd
  com.apple.appleseed.seedusaged
  com.apple.applespell
  com.apple.apsd
  com.apple.assistant_service
  com.apple.awacsd
  com.apple.awdd
  com.apple.bird
  com.apple.cloudd
  com.apple.cloudfamilyrestrictionsd-mac
  com.apple.cloudpaird
  com.apple.cloudphotod
  com.apple.cloudphotosd
  com.apple.commerce
  com.apple.contacts.donation-agent
  com.apple.contactsd
  com.apple.familycircled
  com.apple.familycontrols
  com.apple.familycontrols.useragent
  com.apple.familynotificationd
  com.apple.findmymac
  com.apple.findmymacmessenger
  com.apple.gamed
  com.apple.geod
  com.apple.geodMachServiceBridge
  com.apple.helpd
  com.apple.iCloudHelper
  com.apple.iCloudNotificationAgent
  com.apple.iCloudStats
  com.apple.iCloudUserNotifications
  com.apple.iCloudUserNotificationsd
  com.apple.icloud.findmydeviced
  com.apple.icloud.findmydeviced.findmydevice-user-agent
  com.apple.icloud.fmfd
  com.apple.icloud.searchpartyuseragent
  com.apple.imagent
  com.apple.itunescloudd
  com.apple.locationd
  com.apple.maps.destinationd
  com.apple.mbicloudsetupd
  com.apple.netbiosd
  com.apple.parentalcontrols.check
  com.apple.parsecd
  com.apple.photoanalysisd
  com.apple.photolibraryd
  com.apple.podcasts.PodcastContentService
  com.apple.remotepairtool
  com.apple.rpmuxd
  com.apple.rtcreportingd
  com.apple.safaridavclient
  com.apple.screensharing
  com.apple.security.cloudkeychainproxy3
  com.apple.security.idskeychainsyncingproxy
  com.apple.security.keychain-circle-notification
  com.apple.siri-distributed-evaluation
  com.apple.siri.context.service
  com.apple.siriactionsd
  com.apple.siriknowledged
  com.apple.speech.speechdatainstallerd
  com.apple.speech.speechsynthesisd.arm64
  com.apple.speech.speechsynthesisd.x86_64
  com.apple.speech.synthesisserver
  com.apple.tipsd
)

# Initialize log file and tracking file
LOG_FILE="/tmp/stop-processes.log"
> "$LOG_FILE"

# Get current user's UID for GUI domain
USER_UID=$(id -u)

for agent in "${AGENTS[@]}"; do
  # Check for plist in LaunchAgents, LaunchDaemons, and user LaunchAgents
  agent_plist="/System/Library/LaunchAgents/${agent}.plist"
  daemon_plist="/System/Library/LaunchDaemons/${agent}.plist"
  user_plist="$HOME/Library/LaunchAgents/${agent}.plist"

  if [[ -f "$agent_plist" ]]; then
    plist_path="$agent_plist"
    domain="gui/$USER_UID"
  elif [[ -f "$daemon_plist" ]]; then
    plist_path="$daemon_plist"
    domain="system"
  elif [[ -f "$user_plist" ]]; then
    plist_path="$user_plist"
    domain="gui/$USER_UID"
  else
    echo "Plist not found: ($agent)"
    echo "Plist not found for $agent in LaunchAgents, LaunchDaemons, or user LaunchAgents" >> "$LOG_FILE"
    continue
  fi

  # Check if service is loaded
  if launchctl list "$agent" >/dev/null 2>&1; then
    # Attempt to disable and stop the agent/daemon using bootout
    if sudo launchctl bootout "$domain/$agent" >>"$LOG_FILE" 2>&1; then
      echo "Disabled and stopped: ($agent)"
      echo "$agent $domain" >> "$LOG_FILE"
    else
      echo "Failed to disable/stop: ($agent)"
      echo "Failed to bootout $agent in $domain. Check $LOG_FILE for details." >> "$LOG_FILE"
    fi
  else
    echo "Service not loaded: ($agent)"
    echo "Service $agent not loaded or already disabled" >> "$LOG_FILE"
  fi
done

echo "To re-enable an agent, use: sudo launchctl bootstrap gui/$USER_UID /System/Library/LaunchAgents/<agent>.plist"
echo "To re-enable a daemon, use: sudo launchctl bootstrap system /System/Library/LaunchDaemons/<agent>.plist"
echo "To re-enable a user agent, use: launchctl bootstrap gui/$USER_UID ~/Library/LaunchAgents/<agent>.plist"
echo "Operation complete. Check $LOG_FILE for more information"

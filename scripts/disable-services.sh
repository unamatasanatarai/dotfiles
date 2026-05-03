# version 1.4.1
# defaults
user_uid="$UID"

printf "warning: this will break some functionality. continue? (y/N): "
read -r confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    exit 0
fi

# service definitions
services=(
    com.apple.AddressBook.abd                              # address book daemon
    com.apple.AddressBook.AssistantService                 # siri contacts integration
    com.apple.AddressBook.SourceSync                       # contact syncing
    com.apple.AirPlayUIAgent                               # airplay ui
    com.apple.AirPlayXPCHelper                             # airplay backend
    com.apple.AirPortBaseStationAgent                      # apple router management
    com.apple.AMPArtworkAgent                              # media artwork downloader
    com.apple.AMPLibraryAgent                              # media library sync
    com.apple.analyticsd                                   # telemetry data collection
    com.apple.AOSNotificationOSX                           # apple online alerts
    com.apple.AOSPushRelay                                 # icloud notification relay
    com.apple.appleseed.fbahelperd                         # feedback assistant helper
    com.apple.appleseed.seedusaged                         # beta program usage
    com.apple.applespell                                   # system spell checking
    com.apple.apsd                                         # push notifications (imessage)
    com.apple.assistant_service                            # siri core service
    com.apple.awacsd                                       # wireless access control
    com.apple.awdd                                         # wireless diagnostics
    com.apple.bird                                         # icloud drive sync
    com.apple.CalendarAgent                                # calendar sync
    com.apple.CallHistoryPluginHelper                      # call log integration
    com.apple.CallHistorySyncHelper                        # sync call logs across devices
    com.apple.cloudd                                       # icloud core sync
    com.apple.cloudfamilyrestrictionsd-mac                 # icloud family limits
    com.apple.cloudpaird                                   # icloud peripheral pairing (airpods)
    com.apple.cloudphotod                                  # icloud photo sync
    com.apple.cloudphotosd                                 # legacy photo sync
    com.apple.commerce                                     # app store backend
    com.apple.contacts.donation-agent                      # automated contact suggestions
    com.apple.contactsd                                    # contacts database
    com.apple.coreduetd                                    # battery/app context management
    com.apple.coreduetd-context                            # duet storage
    com.apple.CrashReporterSupportHelper                   # crash reporting ui framework
    com.apple.diagnosticd                                  # diagnostic log management
    com.apple.DictationIM                                  # keyboard dictation
    com.apple.familycircled                                # family sharing
    com.apple.familycontrols                               # parental controls
    com.apple.familycontrols.useragent                     # parental control ui
    com.apple.familynotificationd                          # family alerts
    com.apple.findmymac                                    # find my tracking
    com.apple.findmymacmessenger                           # find my alerts
    com.apple.gamed                                        # game center
    com.apple.geod                                         # maps location provider
    com.apple.geodMachServiceBridge                        # location bridge service
    com.apple.helpd                                        # background help viewer
    com.apple.icloud.findmydeviced                         # find my device core
    com.apple.icloud.findmydeviced.findmydevice-user-agent # find my device ui
    com.apple.icloud.fmfd                                  # find my friends sync
    com.apple.icloud.searchpartyuseragent                  # find my offline network
    com.apple.iCloudHelper                                 # icloud account helper
    com.apple.iCloudNotificationAgent                      # icloud alerts agent
    com.apple.iCloudStats                                  # icloud storage tracking
    com.apple.iCloudUserNotifications                      # icloud user alerts
    com.apple.iCloudUserNotificationsd                     # icloud alert daemon
    com.apple.imagent                                      # imessage/facetime handler
    com.apple.itunescloudd                                 # apple music sync
    com.apple.knowledge-agent                              # behavior tracking for suggestions
    com.apple.locationd                                    # location services management
    com.apple.ManagedClient.cloudconfigurationd            # corporate mdm management
    com.apple.maps.destinationd                            # suggested maps destinations
    com.apple.Maps.mapspushd                               # send-to-mac maps notifications
    com.apple.mbicloudsetupd                               # icloud setup assistant tasks
    com.apple.metadata.mds                                 # spotlight indexing
    com.apple.metadata.mds_stores                          # spotlight databases
    com.apple.metadata.mds.check                           # background file checking
    com.apple.metadata.mds.index                           # background file indexing
    com.apple.metadata.mds.scan                            # background file scanning
    com.apple.netbiosd                                     # windows file sharing discovery
    com.apple.osanalytics.osanalyticshelper                # analytics upload orchestration
    com.apple.parentalcontrols.check                       # restriction enforcement
    com.apple.parsecd                                      # spotlight web suggestions
    com.apple.photoanalysisd                               # local image recognition
    com.apple.photolibraryd                                # photos library management
    com.apple.podcasts.PodcastContentService               # podcast syncing
    com.apple.proactiveeventtrackerd                       # suggestion event tracking
    com.apple.ReportCrash                                  # crash reporter
    com.apple.ReportCrash.Root                             # root crash reporter
    com.apple.rtcreportingd                                # rtc diagnostic reporting
    com.apple.Safari.History                               # safari history management
    com.apple.Safari.PasswordBreachAgent                   # password leak checks
    com.apple.Safari.SafeBrowsing.Service                  # anti-phishing filter
    com.apple.SafariBookmarksSyncAgent                     # safari bookmark syncing
    com.apple.SafariCloudHistoryPushAgent                  # safari history push sync
    com.apple.safaridavclient                              # safari webdav sync
    com.apple.SafariHistoryServiceAgent                    # background history sync
    com.apple.SafariLaunchAgent                            # safari startup optimizer
    com.apple.SafariNotificationAgent                      # website push notifications
    com.apple.screensharing                                # remote desktop listener
    com.apple.ScreenTimeAgent                              # screen time limits
    com.apple.security.cloudkeychainproxy3                 # icloud keychain sync
    com.apple.security.idskeychainsyncingproxy             # keychain encryption sync
    com.apple.security.keychain-circle-notification        # new device alerts
    com.apple.siri-distributed-evaluation                  # siri local machine learning
    com.apple.siri.context.service                         # siri app context provider
    com.apple.siriactionsd                                 # siri shortcuts
    com.apple.siriknowledged                               # siri local knowledge
    com.apple.softwareupdate_firstrun_tasks                # post-upgrade update tasks
    com.apple.softwareupdated                              # automatic system updates
    com.apple.speech.speechdatainstallerd                  # voice data downloader
    com.apple.speech.speechsynthesisd                      # text-to-speech (general)
    com.apple.speech.speechsynthesisd.arm64                # text-to-speech (silicon)
    com.apple.speech.speechsynthesisd.x86_64               # text-to-speech (intel)
    com.apple.speech.synthesisserver                       # centralized speech server
    com.apple.spindump                                     # unresponsive app monitoring
    com.apple.spotlightknowledged                          # search intelligence
    com.apple.SubmitDiagInfo                               # diagnostic submission
    com.apple.symptomsd                                    # system health monitoring
    com.apple.tipsd                                        # siri tips notifications
    com.apple.UsageTrackingAgent                           # app usage statistics
)

# manual deduplication
declare -A unique_map
final_services=()
for s in "${services[@]}"; do
    if [[ -z "${unique_map[$s]}" ]]; then
        unique_map[$s]=1
        final_services+=("$s")
    fi
done

# execution
for svc in "${final_services[@]}"; do
    printf "processing %s\n" "$svc"

    sudo launchctl disable "system/$svc" 2>/dev/null
    sudo launchctl disable "gui/$user_uid/$svc" 2>/dev/null
    sudo launchctl bootout "system/$svc" 2>/dev/null
    launchctl bootout "gui/$user_uid/$svc" 2>/dev/null
done

printf "\ndone.\n"

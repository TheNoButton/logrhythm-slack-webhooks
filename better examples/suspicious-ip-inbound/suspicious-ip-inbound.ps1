###Define the params from actions.xml
param(
[string]$AlarmId, #AlarmID Alarm <remv1:AlarmId />
[string]$AlarmDate, #AlarmDate
[string]$AlarmRuleName, #AlarmRuleName Alarm <remv1:AlarmRuleName />
[string]$FWPolicy, #Subject First Event <remv1:Subject />
[string]$Gateway, #Sender First Event <remv1:Sender />
[string]$Protocol, #Protocol First Event <remv1:Protocol />
[string]$Port, #DPort First Event <remv1:DPort />
[string]$DstCountry, #DLocationCountry First Event <remv1:DLocationCountry />
[string]$DIP, #DIP First Event <remv1:DIP />
[string]$SIP, #SIP First Event <remv1:SIP />
[string]$Service, #KnownService First Event <remv1:KnownService />
[string]$SrcCountry, #KnownSHost First Event <remv1:KnownSHost />
[string]$MPERule, #MPERule First Event <remv1:MPERule />
[string]$FWRuleNumber #Object First Event <remv1:Object />
)

<### Update these ###>
#Location of Send-SlackMessage.ps1 - https://github.com/jgigler/Powershell.Slack
$ref = "PATH_TO_FILE/Send-SlackMessage.ps1"

#Your Slack Webhook URL
$WebhookURL = "https://hooks.slack.com/services/XXXXXXXXXXXXXXXXX"

#Your LR Web Console URL
$Url = "<"+"https://YOUR_SMARTCONSOLE_LINK/alarms/" + $AlarmId+"|Alarm Link>"
<####################>

$action = "Accept"
$rule = ""
if ($FWPolicy.Contains("standard")){
    $rule = $FWRuleNumber + " - " + $FWPolicy + " (" + $action + ")"
    }else{
    $rule = "Implied Rule" + " (" + $action + ")"
    }

### Set Dflag icon; default country name
$Dflag = ""
switch ($DstCountry)
    {
    "United States" {$Dflag = ":us:"}
    "Japan" {$Dflag = ":jp:"}
    "South Korea" {$Dflag = ":kr:"}
    "China" {$Dflag = ":cn:"}
    "France" {$Dflag = ":fr:"}
    "Spain" {$Dflag = ":es:"}
    "Italy" {$Dflag = ":it:"}
    "Russia" {$Dflag = ":ru:"}
    "Great Britian" {$Dflag = ":gb:"}
    "United Kingdom" {$Dflag = ":uk:"}
    "Germany" {$Dflag = ":de:"}
    "Hong Kong" {$Dflag = ":flag-hk:"}
    "Brazil" {$Dflag = ":flag-br:"}
    "Netherlands" {$Dflag = ":flag-nl:"}
    "India" {$Dflag = ":flag-in:"}
    "Egypt" {$Dflag = ":flag-eg:"}
    "Ireland" {$Dflag = ":flag-ie:"}
    "Canada" {$Dflag = ":flag-ca:"}
    default {$Dflag = "("+$DLocationCountry+")"}
    }

### Set Sflag icon; default country name
$Sflag = ""
switch ($SrcCountry)
    {
    "United States" {$Sflag = ":us:"}
    "Japan" {$Sflag = ":jp:"}
    "South Korea" {$Sflag = ":kr:"}
    "China" {$Sflag = ":cn:"}
    "France" {$Sflag = ":fr:"}
    "Spain" {$Sflag = ":es:"}
    "Italy" {$Sflag = ":it:"}
    "Russia" {$Sflag = ":ru:"}
    "Great Britian" {$Sflag = ":gb:"}
    "United Kingdom" {$Sflag = ":uk:"}
    "Germany" {$Sflag = ":de:"}
    "Hong Kong" {$Sflag = ":flag-hk:"}
    "Brazil" {$Sflag = ":flag-br:"}
    "Netherlands" {$Sflag = ":flag-nl:"}
    "India" {$Sflag = ":flag-in:"}
    "Egypt" {$Sflag = ":flag-eg:"}
    "Ireland" {$Sflag = ":flag-ie:"}
    "Canada" {$Sflag = ":flag-ca:"}
    default {$Sflag = "("+$SLocationCountry+")"}
    }

### Manually set DHostname to a certain value; default NSLookup
switch ($DIP)
    {
    "1.2.3.4" {$DHostname = "(Example)"}
    "8.8.8.8" {$DHostname = "(Google DNS)"}
    default{
            if ($DIP -ne $null){
                $DHostname = ""
                $currentEAP = $ErrorActionPreference
                $ErrorActionPreference = "silentlycontinue"
                $DHostname = "("+([System.Net.Dns]::gethostentry($DIP)).HostName+")"
                $ErrorActionPreference = $currentEAP
                if (!($DHostname)){$DHostname=""}
            }
        }
    }

### Manually set SHostname to a certain value; default NSLookup
switch ($SIP)
    {
    "1.2.3.4" {$DHostname = "(Example)"}
    "8.8.8.8" {$DHostname = "(Google DNS)"}
    default{
            if ($SIP -ne $null){
                $SHostname = ""
                $currentEAP = $ErrorActionPreference
                $ErrorActionPreference = "silentlycontinue"
                $SHostname = "("+([System.Net.Dns]::gethostentry($SIP)).HostName+")"
                $ErrorActionPreference = $currentEAP
                if (!($SHostname)){$SHostname=""}
            }
        }
    }

### Set Webhook payload
$MyFields = @(
    @{
        title = "Source"+" "+$Sflag
        value = $SIP + " "+$SHostname
        short = 'true'
    }
    @{
        title = "Destination"+" "+$Dflag
        value = $DIP + " "+$DHostname
        short = 'true'
    }
    @{
        title = "Service"
        value = $Service + " (" + $Protocol + " " + $Port + ")"
        short = 'true'
    }
    @{
        title = "Gateway"
        value = $Gateway
        short = 'true'
    }
    @{
        title = "MPE Rule"
        value = $MPERule
        short = 'true'
    }
    @{
        title = "Firewall Rule"
        value = $rule
        short = 'true'
    }
)

#Send Webhook
. $ref
$notification = New-SlackRichNotification -Fallback $AlarmRuleName -Title $AlarmRuleName -Text $Url -AuthorName $AlarmDate -color $color -Fields $MyFields
Send-SlackNotification -Url $WebhookURL -Notification $notification
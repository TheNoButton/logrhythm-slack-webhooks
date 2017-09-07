###Define the params from actions.xml
param(
[string]$AlarmId, #AlarmID Alarm <remv1:AlarmId />
[string]$AlarmDate, #AlarmDate
[string]$AlarmRuleName, #AlarmRuleName Alarm <remv1:AlarmRuleName />
[string]$Login,  #<remv1:Login />
[string]$SrcHost, #<remv1:KnownSHost />
[string]$DstHost, #<remv1:KnownDHost />
[string]$MPERule #<remv1:MPERule />
)

<### Update these ###>
#Location of Send-SlackMessage.ps1 - https://github.com/jgigler/Powershell.Slack
$ref = "PATH_TO_FILE/Send-SlackMessage.ps1"

#Your Slack Webhook URL
$WebhookURL = "https://hooks.slack.com/services/XXXXXXXXXXXXXXXXX"

#Your LR Web Console URL
$Url = "<"+"https://YOUR_SMARTCONSOLE_LINK/alarms/" + $AlarmId+"|Alarm Link>"
<####################>

### Set webhook payload
$MyFields = @(

    @{
        title = "Login"
        value = $Login
        short = 'true'
    }
    @{
        title = "Authentication Failure"
        value = $MPERule
        short = 'true'
    }
    @{
        title = "Source"
        value = $SrcHost
        short = 'true'
    }
    @{
        title = "Destination"
        value = $DstHost
        short = 'true'
    }
)

### Send webhook
. $ref
$notification = New-SlackRichNotification -Fallback $AlarmRuleName -Title $AlarmRuleName -Text $Url -AuthorName $AlarmDate -color $color -Fields $MyFields
Send-SlackNotification -Url "https://hooks.slack.com/services/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" -Notification $notification
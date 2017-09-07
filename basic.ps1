### Define this variables in actions.xml when creating the SmartResponse plugin
param(
[string]$AlarmId,
[string]$AlarmRuleName,
[string]$AlarmDate,
[string]$MessageClass
)

<### Update these ###>
#Location of Send-SlackMessage.ps1 - https://github.com/jgigler/Powershell.Slack
$ref = "PATH_TO_FILE/Send-SlackMessage.ps1"

#Your Slack Webhook URL
$WebhookURL = "https://hooks.slack.com/services/XXXXXXXXXXXXXXXXX"

#Your LR Web Console URL
$Url = "https://YOUR_SMARTCONSOLE_LINK/alarms/" + $AlarmId
<####################>

$MyFields = @(
    @{
        title = $AlarmRuleName
        value = "<"+$Url+"|Alarm Link>"
        short = 'true'
    }
    @{
        title = "Classification"
        value = $MessageClass
        short = 'true'
    }
)

. $ref
$notification = New-SlackRichNotification -Fallback $AlarmRuleName -AuthorName $AlarmDate -Fields $MyFields
Send-SlackNotification -Url $WebhookURL -Notification $notification
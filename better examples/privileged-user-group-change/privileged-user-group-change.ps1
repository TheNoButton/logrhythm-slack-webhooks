###Define the params from actions.xml
param(
[string]$msgClass,
[string]$event,
[string]$account,
[string]$vmid,
[string]$login,
[string]$subject,
[string]$alarmId,
[string]$group
)

<### Update these ###>
#Location of Send-SlackMessage.ps1 - https://github.com/jgigler/Powershell.Slack
$ref = "PATH_TO_FILE/Send-SlackMessage.ps1"

#Your Slack Webhook URL
$WebhookURL = "https://hooks.slack.com/services/XXXXXXXXXXXXXXXXX"

#Your LR Web Console URL
$url = "<"+"https://YOUR_SMARTCONSOLE_LINK/alarms/" + $alarmId+"|Alarm Link>"
<####################>

### Determine add/remove action
if ($vmid -eq 4729){
    $action = "Account Removed from Group"
    }elseif($vmid -eq 4728){
    $action = "Account Added to Group"
    }else{
    $action = "Unknown"
}

### Set webhook payload
$MyFields = @(
    @{
        title = 'User (Impacted)'
        value = $account
        short = 'true'
    }
    @{
        title = 'User (Origin)'
        value = $login
        short = 'true'
    }
    @{
        title = 'Group'
        value = $group
        short = 'true'
    }
    @{
        title = 'Vendor Message'
        value = $action
        short = 'true'
    }
    @{
        title = 'Alarm URL'
        value = $url
    }
)

. $ref
$notification = New-SlackRichNotification -Fallback $event -Title $event -Text $url -Fields $MyFields
Send-SlackNotification -Url $WebhookURL -Notification $notification
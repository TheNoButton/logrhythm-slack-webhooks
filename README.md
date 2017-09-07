# LogRhythm to Slack Webhooks
These are some examples/quick guide on how to send Slack Webhooks from LogRhythm AIE alarms.

### Steps
1. Create your AIE alarm with fields that you want to pass to your webhook. [NOT SHOWN]
2. Create a powershell script accepting the fields as parameters. [basic.ps1]
3. Create the actions.xml manifest with the same parameters/fields. [actions.xml]
4. Create your SmartResponse Plugin using the powershell script and manifest. [NOT SHOWN]
5. Set your SmartResponse as an action to your AIE alarm, mapping the correct parameters:  
![](http://i.imgur.com/mAakBz7.png)
6. Trigger your alarm, observe the webhook:  
![](http://i.imgur.com/OAlGKxa.png)

### Better Examples
auth-failure.ps1  

### Credit
[jgigler/Powershell.Slack](https://github.com/jgigler/Powershell.Slack)
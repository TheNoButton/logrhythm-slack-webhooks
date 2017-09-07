# LogRhythm to Slack Webhooks
These are some examples/quick guide on how to send Slack Webhooks from LogRhythm AIE alarms.

### Steps
1. Add a webhook to your Slack team.
[NOT SHOWN]
2. Create your AIE alarm with fields that you want to pass to your webhook.  
[NOT SHOWN]
3. Create a powershell script accepting the fields as parameters.  
[basic.ps1]
4. Create the actions.xml manifest with the same parameters/fields.  
[actions.xml]
5. Create your SmartResponse Plugin using the powershell script and manifest.  
[NOT SHOWN]
6. Set your SmartResponse as an action to your AIE alarm, mapping the correct parameters:  

	![](http://i.imgur.com/04swGjG.png)

7. Trigger your alarm, observe the webhook:  

	![](http://i.imgur.com/OAlGKxa.png)

### Better Examples
#### auth-failure.ps1  
![](http://i.imgur.com/rzeKFqA.png)
  
#### suspicious-ip-inbound.ps1  

![](http://i.imgur.com/z2ZHs8o.png)

#### suspicious-ip-outbound.ps1  

![](http://i.imgur.com/gsZt3ao.png)

#### privileged-user-group-changes.ps1

![](http://i.imgur.com/GAeGh0p.png)
  
### Credit
[jgigler/Powershell.Slack](https://github.com/jgigler/Powershell.Slack)
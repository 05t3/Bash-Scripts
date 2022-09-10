# Sysmon Installation

1. Download the Sysmon file using the following link:

	[https://download.sysinternals.com/files/Sysmon.zip](https://download.sysinternals.com/files/Sysmon.zip)
2. Download the Sysmon configuration file to use from the following repo:

	[Neo23x0/sysmon-config](https://raw.githubusercontent.com/Neo23x0/sysmon-config/master/sysmonconfig-export.xml)
3. Navigate to the directory containing our config and executable file)

	`cd C:\Users\Admin\Downloads\Sysmon`
4. Run the following command as admin

	`.\Sysmon64.exe -accepteula -i sysmonconfig-export.xml`
	
# Integrating Sysmon with Wazuh

- Navigate to `C:\Program Files (x86)\ossec-agent` and add the following block above the **Policy monitoring** block as shown below.

```yaml
  <localfile>
    <location>Microsoft-Windows-Sysmon/Operational</location>
    <log_format>eventchannel</log_format>
  </localfile>
```

![image](https://user-images.githubusercontent.com/58165365/189477721-dee5bab9-8251-4a39-85c8-63acfa0f6f9c.png)


- Save changes and restart the wazuh manager
- If you head over to wazuh and locate the `data.win.system.channel` field, you should see sysmon logs populating.
- If sysmon logs are not being shipped, its probably a problem with the default sysmon rules. Here what you can do:
	1. Create custom rules by using navigating to **Wazuh > Management > Rules > Add new rules file**
	
	![image](https://user-images.githubusercontent.com/58165365/189478151-91ba7c6c-c24f-40ee-8412-b99d8d4b769c.png)
	![image](https://user-images.githubusercontent.com/58165365/189478179-e0a5224d-d0c2-4e70-b810-88b0aa35970f.png)	
	
	2. Name your rules file as `sysmon.xml`
	3. Create your custom rules here or use this template by [OpenSecureCo](https://raw.githubusercontent.com/OpenSecureCo/Wazuh/main/sysmon.xml) (_Prefered_)
	
	![image](https://user-images.githubusercontent.com/58165365/189478309-2ccc3bae-9826-4311-8441-c1370aa22dd3.png)
	
	4. Save the rules and click the "_Restart Manager_" button.
	
	5. Navigate to **Wazuh > Management > Groups** and modify the group of your choice. In my case its _default_
	
	![image](https://user-images.githubusercontent.com/58165365/189478485-f4950270-5ef8-4ab1-9e9e-a339f857c0f5.png)

	6. By default, the configuration block will look like this:
	
	![image](https://user-images.githubusercontent.com/58165365/189478554-3b8c40c7-0cc3-4168-a90e-b87c7ec44508.png)

	Add the same configuration block you added in your agent between the `<agent_config>` tag as shown below:
	
	![image](https://user-images.githubusercontent.com/58165365/189478664-cbf61275-9c2e-4c24-9d89-526036319b85.png)

	7. This time round, we should see sysmon events populating

	![image](https://user-images.githubusercontent.com/58165365/189478872-aff05a86-39bc-4309-951a-ed30ab34e8dc.png)
	

![wazuhscript](https://user-images.githubusercontent.com/58165365/183695788-ecdb909c-907e-4169-bbc4-82018a1257f6.png)

# What is Wazuh?

[Wazuh](https://wazuh.com/) is a comprehensive SIEM (Security Information and Event Management) solution which provides monitoring, detection, and alerting of security events and incidents. It also provides Active XDR protection from modern threats provides analysts real-time correlation and context.

You can read more about Wazuh from their website.

-----

Download the [config.yml](https://raw.githubusercontent.com/05t3/Bash-Scripts/main/Wazuh-Install/config.yml) file above in your home directory and modify the IP address indicated therein. 

![image](https://user-images.githubusercontent.com/58165365/183697878-bb15a4c5-c839-40ab-8417-08010cca021a.png)

> **NB:** _You need to have a static IP or a FQDN in order to proceed_

To install the wazuh indexer,server & dashboard run:

`source install.sh`

Then run `install`.

![image](https://user-images.githubusercontent.com/58165365/183701089-22c3c505-5a05-4e8a-b0c9-a60f4caf8e3e.png)

Once installation completes, it gives you the UI URL, login credentials and checks whether the required services are up and running

![image](https://user-images.githubusercontent.com/58165365/183700306-1d35aa17-e95f-4e87-bffa-3fd7c106b1dc.png)


## Notes

- This script has been tested on 20.04 LTS (Focal Fossa)

![wazuhscript](https://user-images.githubusercontent.com/58165365/183695788-ecdb909c-907e-4169-bbc4-82018a1257f6.png)

# What is Wazuh?

[Wazuh](https://wazuh.com/) is a comprehensive SIEM (Security Information and Event Management) solution which provides monitoring, detection, and alerting of security events and incidents. It also provides Active XDR protection from modern threats provides analysts real-time correlation and context.

You can read more about Wazuh from their website.

-----

This script depends on xautomation to run efficiently. To install `xautomation`, run the following command on a freshly installed server.

`sudo apt update && sudo apt install xautomation`

With that done, Download the [config.yml]() file above in your home directory and modify the IP address indicated therein. 

![image](https://user-images.githubusercontent.com/58165365/183697878-bb15a4c5-c839-40ab-8417-08010cca021a.png)

> **NB:** _You need to have a static IP or a FQDN in order to proceed_

To install the whole cluster, run:

`source install.sh`

Then run `install`.

## Notes

- This script has been tested on 20.04 LTS (Focal Fossa)

Role Name
=========

Role name in Ansible Galaxy: **[DovnarAlexander/oracle-java](https://galaxy.ansible.com/DovnarAlexander/oracle-java)**

You can use this role to install JDK 7 or 8 version.
This role could be used on any distributive with YUM or APT package manager.

Role Variables
--------------
### Mandatory variables

None.

### Optional variables

There are the following variables by default:

```yaml
# Java major version 7 or 8
javaMajorVersion: 8
# Java minor version
javaMinorVersion: 131

# Parent path to install JDK
javaPath: /opt/java/

# Path to download archives with JDK
javaDownloadPath: /tmp
# True if you want to use oracle web site to download archive
# False if you have already had downloaded tar archive:
# Just put this file in folder under roles/oracle-java/files folder
# Name should be in format jdk-<major_version>u<minor_version>-linux-x<64_or_86>.tar.gz
javaFromOracle: true
# True if you want to clear download files from javaDownloadPath folder
javaClearAfter: false

# Do you want to set up JAVA_HOME global variable in Linux
javaSetHome: true
```

Example Playbook
----------------

### Step 1: add role

Add role name `DovnarAlexander.oracle-java` to your playbook file.

### Step 2: add variables

Set vars in your playbook file.

Simple example:

```yaml
---
# file: simple-playbook.yml

- hosts: all

  roles:
    - DovnarAlexander.oracle-java

  vars:
    javaMajorVersion: 8
    javaMinorVersion: 112
```

### Step 3: add jdk role in your inventory file

```ini
---
# file:inventory.ini

[jdk]
your_host
```
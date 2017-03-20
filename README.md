dovnar.alexander.oracle-java for Ansible Galaxy
============

## Summary

Role name in Ansible Galaxy: **[dovnar.alexander.oracle-java](https://galaxy.ansible.com/)**

You can use this role to install JDK 7 or 8 version.
This role could be used on any distributive with YUM or APT package manager.

## Role Variables

### Mandatory variables

None.

### Optional variables


There are the following variables by default:

```yaml
# Java major version 7 or 8
javaMajorVersion: 8
# Java minor version
javaMinorVersion: 121

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
javaClearAfter: true

# Do you want to set up JAVA_HOME global variable in Linux
javaSetHome: true
```

## Usage


### Step 1: add role

Add role name `dovnar.alexander.oracle-java` to your playbook file.


### Step 2: add variables

Set vars in your playbook file.

Simple example:

```yaml
---
# file: simple-playbook.yml

- hosts: all

  roles:
    - dovnar.alexander.oracle-java

  vars:
    javaMajorVersion: 8
    javaMinorVersion: 112
```

## History

3/20/2017 init commit
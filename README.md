[![Build Status](https://travis-ci.org/DovnarAlexander/ansible-oracle-java.svg?branch=master)](https://travis-ci.org/DovnarAlexander/ansible-oracle-java)

Oracle Java
=========

Role name in Ansible Galaxy: **[DovnarAlexander/oracle-java](https://galaxy.ansible.com/DovnarAlexander/oracle-java)**

You can use this role to install any version of JDK from Oracle Site + .
This role could be used on any distributive with YUM or APT package manager.

Role Variables
--------------
### Mandatory variables

```yaml
# Link for 'link' installation mode
java_install_link: ''

# File name for 'local' installation mode
java_install_file: 'jdk-{{ java_major_version }}u{{ java_minor_version }}-linux-x64.tar.gz'

# S3 Dict for 's3' installation mode
# Also you can use AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION environment variables instead
# but bucket name (and path if differs) is still required
java_install_s3_bucket: ''
java_install_s3_path: 'jdk-{{ java_major_version }}u{{ java_minor_version }}-linux-x64.tar.gz'
java_install_s3_region: ''
java_install_s3_aws_access_key: ''
java_install_s3_aws_secret_key: ''
```

### Optional variables

There are the following variables by default:

```yaml
# Java major version
java_major_version: 8
# Java minor version
java_minor_version: 172
# Parent path to install JDKs
java_root_path: '/opt/java'
# Path to download archives with JDK
java_distr_path: '/tmp'

# Java install mode to select. The following values are possible:
# - oracle - for downloading installation Tar archive directly from Oracle Site.
# - local - for copying installation tar archive from the host.
# - link - for downloading Tar archive from some web server.
# - s3 - for downloading Tar archive from S3 bucket.
java_install_modes:
  - 'oracle'
  - 'local'
  - 'link'
  - 's3'
# Default is oracle
java_install_mode: 'oracle'

# True if you want to clear download files from java_distr_path folder
java_clean_up: false
# Do you want to set up JAVA_HOME global variable in Linux
java_set_home: true
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
    java_major_version: 10
    java_minor_version: 1
```

### Step 3: add java group in your inventory file

```ini
---
# file:inventory.ini

[java]
your_host

```
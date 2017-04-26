#!/bin/bash

set -e

git clone git://github.com/ansible/ansible.git --recursive ansible

cd ansible

pip install -r ./requirements.txt
git submodule update --init --recursive

mkdir -p roles
cd roles
#git clone https://github.com/DovnarAlexander/ansible-oracle-java.git
git clone -b develop https://github.com/DovnarAlexander/ansible-oracle-java.git

cd ansible-oracle-java/tests

# Run the playbook
ansible-playbook test.yml -i test.ini --connection=local --sudo -v
# Idempotency check
ansible-playbook test.yml -i test.ini --connection=local --sudo \
    | grep -q 'changed=0.*failed=0' \
    && (echo "Idempotence test for $JAVA passed" && exit 0) \
    || (echo "Idempotence test for $JAVA failed" && exit 1)

JAVA_MAJOR=8
JAVA_MINOR=131
JAVA="1.$JAVA_MAJOR.0_$JAVA_MINOR"
# Java version check
java -version 2>&1 \
    | grep "$JAVA" \
    && (echo "Functional test for $JAVA passed" && exit 0) \
    || (echo "Functional test for $JAVA failed" && exit 1)

# Change version
sed -ie 's/javaMinorVersion: 131/javaMinorVersion: 101/g' ../defaults/main.yml
# Change variable javaFromOracle
sed -ie 's/javaFromOracle: true/javaFromOracle: false/g' ../defaults/main.yml
# Download archive from Oracle site
 curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz \
    > ../files/jdk-8u101-linux-x64.tar.gz

# Run the playbook
ansible-playbook test.yml -i test.ini --connection=local --sudo -v
# Idempotency check
ansible-playbook test.yml -i test.ini --connection=local --sudo \
    | grep -q 'changed=0.*failed=0' \
    && (echo "Idempotence test for $JAVA passed" && exit 0) \
    || (echo "Idempotence test for $JAVA failed" && exit 1)

JAVA_MAJOR=8
JAVA_MINOR=101
JAVA="1.$JAVA_MAJOR.0_$JAVA_MINOR"
# Java version check
java -version 2>&1 \
    | grep "$JAVA" \
    && (echo "Functional test for $JAVA passed" && exit 0) \
    || (echo "Functional test for $JAVA failed" && exit 1)

# Change version
sed -ie 's/javaMajorVersion: 8/javaMajorVersion: 7/g' ../defaults/main.yml
sed -ie 's/javaMinorVersion: 101/javaMinorVersion: 79/g' ../defaults/main.yml
# Change javaClearAfter value to true
sed -ie 's/javaClearAfter: false/javaClearAfter: true/g' ../defaults/main.yml
# Download archive from Oracle site
 curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz \
    > ../files/jdk-7u79-linux-x64.tar.gz

# Run the playbook
ansible-playbook test.yml -i test.ini --connection=local --sudo -v

JAVA_MAJOR=7
JAVA_MINOR=79
JAVA="1.$JAVA_MAJOR.0_$JAVA_MINOR"
# Java version check
java -version 2>&1 \
    | grep "$JAVA" \
    && (echo "Functional test 1 for $JAVA passed" && exit 0) \
    || (echo "Functional test 1 for $JAVA failed" && exit 1)
# Downloaded files removal check
[ -f jdk-7u79-linux-x64.tar.gz ] \
    && (echo "Functional test 2 for $JAVA failed" && exit 1) \
    || (echo "Functional test 2 for $JAVA passed" && exit 0)
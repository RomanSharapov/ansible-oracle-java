#!/bin/bash

git clone git://github.com/ansible/ansible.git --recursive ansible

cd ansible

pip install -r ./requirements.txt
git submodule update --init --recursive

mkdir -p roles
cd roles
git clone https://github.com/DovnarAlexander/ansible-oracle-java.git

cd ansible-oracle-java/tests

# Run the playbook
ansible-playbook test.yml -i test.ini --connection=local --sudo -v
# Idempotency check
ansible-playbook test.yml -i test.ini --connection=local --sudo \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)

JAVA_MAJOR=8
JAVA_MINOR=121
JAVA="1.$JAVA_MAJOR.0_$JAVA_MINOR"
# Java version check
java -version 2>&1 \
    | grep "$JAVA" \
    && (echo 'Functional test passed' && exit 0) \
    || (echo 'Functional test failed' && exit 1)

# Change version
sed -ie 's/javaMinorVersion: 121/javaMinorVersion: 101/g' ../defaults/main.yml

# Run the playbook
ansible-playbook test.yml -i test.ini --connection=local --sudo -v
# Idempotency check
ansible-playbook test.yml -i test.ini --connection=local --sudo \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)

JAVA_MAJOR=8
JAVA_MINOR=101
JAVA="1.$JAVA_MAJOR.0_$JAVA_MINOR"
# Java version check
java -version 2>&1 \
    | grep "$JAVA" \
    && (echo 'Functional test passed' && exit 0) \
    || (echo 'Functional test failed' && exit 1)

# Change version
sed -ie 's/javaMajorVersion: 8/javaMajorVersion: 7/g' ../defaults/main.yml
sed -ie 's/javaMinorVersion: 101/javaMinorVersion: 79/g' ../defaults/main.yml

# Run the playbook
ansible-playbook test.yml -i test.ini --connection=local --sudo -v
# Idempotency check
ansible-playbook test.yml -i test.ini --connection=local --sudo \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)

JAVA_MAJOR=7
JAVA_MINOR=79
JAVA="1.$JAVA_MAJOR.0_$JAVA_MINOR"
# Java version check
java -version 2>&1 \
    | grep "$JAVA" \
    && (echo 'Functional test passed' && exit 0) \
    || (echo 'Functional test failed' && exit 1)
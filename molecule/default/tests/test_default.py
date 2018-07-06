import testinfra.utils.ansible_runner
import os


testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_packages(host):
    packages = [
        "tar"
    ]
    for package in packages:
        p = host.package(package)
        assert p.is_installed


def test_java_in_path(host):
    assert host.exists("java")


def test_java_version(host):
    all_variables = host.ansible.get_variables()
    java_major = all_variables['java_major_version']
    java_minor = all_variables['java_minor_version']
    if java_major >= 9:
        version = "\"%s.0.%s\"" % (java_major, java_minor)
    else:
        version = "\"1.%s.0_%s\"" % (java_major, java_minor)
    o = host.run("java -version")
    assert version in o.stderr.split()


def test_javahome(host):
    all_variables = host.ansible.get_variables()
    java_major = all_variables['java_major_version']
    java_minor = all_variables['java_minor_version']
    if java_major >= 9:
        home = "/opt/java/jdk-%s.0.%s" % (java_major, java_minor)
    else:
        home = "/opt/java/jdk1.%s.0_%s" % (java_major, java_minor)
    o = host.run(". /etc/environment && echo $JAVA_HOME")
    assert home in o.stdout.split()

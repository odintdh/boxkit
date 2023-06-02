#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=0\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
#dnf copr enable phracek/PyCharm
dnf update
dnf upgrade
#!/bin/bash

set -e  # Exit immediately on error

# Define colors
YELLOW="\e[33m"
RESET="\e[0m"

# Define the sources file path
SOURCE_LIST="/etc/apt/sources.list.d/debian.sources"

# Expected content for the sources file
EXPECTED_CONTENT="Types: deb
URIs: http://deb.debian.org/debian/
Suites: bullseye
Components: main contrib non-free
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
URIs: http://deb.debian.org/debian/
Suites: bullseye-updates
Components: main contrib non-free
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg"

# Ensure Debian archive key is added
echo -e "${YELLOW}➜ Adding Debian archive key...${RESET}"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138

# Check if the file exists and already has the expected entries
if [ -f "$SOURCE_LIST" ]; then
  if grep -Fq "bullseye" "$SOURCE_LIST" && grep -Fq "bullseye-updates" "$SOURCE_LIST"; then
    echo -e "${YELLOW}✔ $SOURCE_LIST already contains the expected entries.${RESET}"
  else
    echo -e "${YELLOW}➜ Updating $SOURCE_LIST with expected content...${RESET}"
    echo "$EXPECTED_CONTENT" | sudo tee "$SOURCE_LIST" > /dev/null
  fi
else
  echo -e "${YELLOW}➜ Creating $SOURCE_LIST with expected content...${RESET}"
  echo "$EXPECTED_CONTENT" | sudo tee "$SOURCE_LIST" > /dev/null
fi

# Update package lists
echo -e "${YELLOW}➜ Updating package lists...${RESET}"
sudo apt update

# Install libmpv1 and warn if it fails
echo -e "${YELLOW}➜ Installing libmpv1...${RESET}"
if ! sudo apt install -y libmpv1; then
  echo -e "${YELLOW}⚠ Warning: Installation of libmpv1 failed. Please check the package availability and your sources.${RESET}"
  exit 1
fi

# Download and install OpenSSL 1.1.1
OPENSSL_DEB="openssl_1.1.1-1ubuntu2.1~18.04.23_amd64.deb"
OPENSSL_URL="https://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/$OPENSSL_DEB"

echo -e "${YELLOW}➜ Downloading OpenSSL 1.1.1...${RESET}"
if ! wget -O "/tmp/$OPENSSL_DEB" "$OPENSSL_URL"; then
  echo -e "${YELLOW}⚠ Warning: Download of OpenSSL 1.1.1 failed. Please check your network connection or the URL.${RESET}"
  exit 1
fi

echo -e "${YELLOW}➜ Installing OpenSSL 1.1.1...${RESET}"
if ! sudo dpkg -i "/tmp/$OPENSSL_DEB"; then
  echo -e "${YELLOW}⚠ Warning: Installation of OpenSSL 1.1.1 failed. Please review the package and its dependencies.${RESET}"
  exit 1
fi

# Fix any missing dependencies
echo -e "${YELLOW}➜ Fixing missing dependencies...${RESET}"
sudo apt -f install -y

echo -e "${YELLOW}✔ Installation complete.${RESET}"

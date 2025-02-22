This script will make sure you get `libmpv1` and `openssl1.1.1` (which includes `libssl1.1.1`).
I made this script because whenever I have a new Ubuntu and then want to install Stremio, it always fails to install because it can't find these libs in the repos, so it's always a pain to look for it.

**Running the Script**

With curl
`curl -sL https://raw.githubusercontent.com/muriloux/get-missing-stremio-libs/refs/heads/main/get-stremio-missing-libs.sh  | bash`

With wget
`wget -O - https://raw.githubusercontent.com/muriloux/get-missing-stremio-libs/refs/heads/main/get-stremio-missing-libs.sh | bash`

TODO:

- Check and install for different archs.

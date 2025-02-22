It's always a pain to install **Stremio** on **Ubuntu**, because - if you don't want to get their flatpak version - it always misses some libs that you won't find in your default repos, so the installation will fail and you will be looking in the internet wasting your precious time. 

*This will probably work for the people that didn't try to open Stremio from the terminal and the app simply didn't open.*

The script will make sure you get `libmpv1` and `openssl1.1.1` (which includes `libssl1.1.1`) for your right architecture.

**Running the Script**

With curl:

`curl -sL https://raw.githubusercontent.com/muriloux/get-missing-stremio-libs/refs/heads/main/get-stremio-missing-libs.sh  | bash`

With wget:

`wget -O - https://raw.githubusercontent.com/muriloux/get-missing-stremio-libs/refs/heads/main/get-stremio-missing-libs.sh | bash`

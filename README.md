# zls-deb

Here are the scripts and helper files I use to create `.deb` files from precompiled binaries of [Zig language server][zls], which I host on [my apt packages server][packagesJK].

I am not endorsed by [@zigtools][zigtools]. I just like their project, and see that they aren't publishing `.deb` files of their own.

## Usage

**The easy, trusting way:**

1. Go to http://packages.joekoop.com and run the two commands at the top of the page.
1. Update your local indecies: `sudo apt update`
1. Install ZLS: `sudo apt install zls`

**The slightly more difficult, less trusting way:**

1. Clone this repo: `git clone https://github.com/jkoop/zls-deb.git`
1. Change to the directory that corresponds with the version you want to package.
1. (Trust check) Read `make-package.sh` and look for anything that you don't like.
   - The script downloads the precompiled binaries and libraries from GitHub itself,
   - copies them into a new directory along with the metadata file, DEBIAN-control,
   - and builds a `.deb` file with `dpkg-deb` ([man page][dpkg-deb]).
1. Run the script: `./make-package.sh`
1. The resulting `.deb` file will be in your CWD.

[zls]: https://github.com/zigtools/zls
[packagesJK]: http://packages.joekoop.com/
[zigtools]: https://github.com/zigtools
[dpkg-deb]: https://man7.org/linux/man-pages/man1/dpkg-deb.1.html

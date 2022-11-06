# Fedora setup

## Add these lines to dnf.conf

	sudo nano /etc/dnf/dnf.conf
      [main]
      gpgcheck=1
	  installonly_limit=3
	  clean_requirements_on_remove=True
	  best=False
	  skip_if_unavailable=True
	  # added for speed:
	  fatsestmirror=True
	  max_parallel_downloads=10
	  defaultyes=True
	  keepcache=True
#
## Enable free rpm packages

	sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
#
## Enable nonfree rpm packages

	sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#
## Group update

	sudo dnf groupupdate core
#
## Enable flathub

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#
## Media codecs

	sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin && sudo dnf groupupdate sound-and-video

---
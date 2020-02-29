![Platform: ALL](https://img.shields.io/badge/platform-ALL-green)
![Dependencies: python3+](https://img.shields.io/badge/dependencies-docker-blue)
![Follow @rubynorails on Twitter](https://img.shields.io/twitter/follow/rubynorails?label=follow&style=social)


![brutalist](./docktor.png?raw=true)

# Docktor

Docktor allows you to host a darkweb hidden service by connecting to Tor only over the `docker0` interface.
The container proxies Tor traffic to its own localhost via `nginx` and serves up the content in the `hiddenservice` directory, via host/container volume mapping as the `nginx` document root.

No ports are mapped between the host and the container, but it wouldn't be a bad idea to lock down the `docker0` interface using `iptables` for good measure, but there are zero clearnet ports exposed in this setup.

---

## Install via GitHub

- `git clone https://github.com/phx/docktor.git`
- `cd docktor`
- `docker build -t docktor.img .`
- `docker run -d -v "${PWD}/hiddenservice:/var/www/hiddenservice" --name docktor docktor.img`

## Install via DockerHub

- `mkdir -p hiddenservice`
- `touch hiddenservice/error.html`
- `echo 'Welcome to the darkweb.' > hiddenservice/index.html`
- `docker run -d -v "${PWD}/hiddenservice:/var/www/hiddenservice" --name docktor lphxl/docktor:latest`

Your `.onion` hostname will be listed in `./hiddenservice/hostname`, which you can access over Tor to view the content served in that directory.

---

### Notes

Anytime you remove the container and start a new one using the `docker run` command, your `.onion` hostname will change.

If you want to keep serving content from the same Tor domain, keep the same container and just use the normal Docker commands:

- `docker stop docktor`
- `docker start docktor`
- `docker exec -it docktor /bin/bash` (to exec into the container)

---

I will post additional instructions for running this after I push it to DockerHub and will also consider writing a `docker-compose` file.

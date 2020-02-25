# Docktor

Docktor allows you to host a darkweb hidden service by connecting to Tor only over the `docker0` interface.
The container proxies Tor traffic to its own localhost via `nginx` and serves up the content in the `hiddenservice` directory, via host/container volume mapping as the `nginx` document root.

No ports are mapped between the host and the container, but it wouldn't be a bad idea to lock down the `docker0` interface using `iptables` for good measure, but there are zero clearnet ports exposed in this setup.

---

## Install

- `git clone https://github.com/phx/docktor.git`
- `cd docktor`
- `docker build -t hiddenservice.img .`
- `docker run -d -v "${PWD}/hiddenservice:/var/www/hiddenservice" --name hiddenservice hiddenservice.img`

Your .onion hostname will be listed in `./hiddenservice/hostname`, which you can access over Tor to view the content served in that directory.

## Uninstall

- `docker stop hiddenservice`
- `docker rm hiddenservice`
- `docker rmi hiddenservice.img`
- `rm -rf docktor`

### Notes

Anytime you remove the container and start a new one using the `docker run` command, your `.onion` hostname will change.

If you want to keep serving content from the same Tor domain, keep the same container and just use the normal Docker commands:

- `docker stop hiddenservice`
- `docker start hiddenservice`
- `docker exec -it hiddenservice /bin/bash` (to exec into the container)

---

I will post additional instructions for running this after I push it to DockerHub and will also consider writing a `docker-compose` file.

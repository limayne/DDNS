# DDNS
A DDNS tool for CN dynamic ipv6 servers, using DNSPods service.

-----------------------------------------------

Current features
- None (Still in Progress)

Future Modifications
- Input Token into .conf
- Input domain & sub-domain into .conf
- Input net device into .conf
- Add selection to show current .conf
- Check curl & jq status and install
- set cron task function/maybe systemctl service to enable pendulum DDNS
- support other DNS providers
- golangized

-----------------------------------------------

Quick setup guide

Requirements

- JQ
- curl
- will get auto installed in later updates

Running
- Get a domain for DDNS your dynamic ipv6 server
- Set your domain and subdomain name on DNSPods, set it to a random ipv6 (will be automatically updated afterwards)
- Get DNSPods API token
- sh DDNS.sh
- input token and your domain/subdomain name
- Done. Try access your server by subdomain name!
- Maybe auto task it will be a better choice but I'm still working on it

-----------------------------------------------

Quick Troubleshooting
- not atm

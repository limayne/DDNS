# DDNS
A DDNS tool for dynamic ipv6 servers, using DNSPods service.

-----------------------------------------------

Current features
- (Still in Progress)

Future Modifications
- Input specified token into .conf
- Input specified domain & sub-domain into .conf
- Input specified net device into .conf
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
- Specify all the variables above by entering shell file and changing the lines on the very top
- sh DDNS.sh
- input token and your domain/subdomain name
- Done. Try access your server by subdomain name!
- Maybe auto task it will be a better choice but I'm still working on it

-----------------------------------------------

Quick Troubleshooting
- not atm
- 请使用ipv6的宝子们记得把光猫的ipv6spi防火墙关了！不然访问不到哦！

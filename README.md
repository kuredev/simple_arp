# simple_arp
Simple ARP Client for Ruby(Sender Only)

## Usage

```ruby
require_relative "./lib/simple_arp"

client = SimpleARP::Client.new(src_if_name: "eth0", dst_ip_addr: "172.31.0.1")
client.send
```

require_relative "./lib/simple_arp"

client = SimpleARP::Client.new(src_if_name: "eth0", dst_ip_addr: "172.31.0.1")
pp client.send_and_receive
#client.send_by_sock_dgram

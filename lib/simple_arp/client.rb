require "socket"

module SimpleARP
  ARPHRD_ETHER = 1
  ARPOP_REQUEST = 1
  ETH_ALEN = 6
  ETH_P_ARP = [0x0806].pack("S>").unpack1("S")
  ETH_P_IP = 0x0800
  ETH_TYPE_NUMBER_ARP = 0x0806
  PACKET_BROADCAST = 1
  PACKET_HOST = 0

  class Client
    include SimpleARP::Util

    # @param [String] src_if_name "eth0"
    # @param [String] dst_ip_addr "192.168.0.1"
    def initialize(src_if_name:, dst_ip_addr:)
      @src_if_name = src_if_name
      @dst_ip_addr = dst_ip_addr
    end

    # @return [Integer] Return value of BasicSocket#send
    def send
      bind_if(socket)
      ether_header = SimpleARP::EtherHeader.new(@src_if_name).to_pack
      ether_arp = SimpleARP::EtherArp.new(@src_if_name, @dst_ip_addr).to_pack
      data = ether_header + ether_arp

      socket.send(data, 0)
      # socket.send(data, 0, SimpleARP::SockAddressLL.new(@src_if_name).to_pack_to)
    end

    private

    def bind_if(socket)
      sll = SimpleARP::SockAddressLL.new(@src_if_name).to_pack_from
      socket.bind(sll)
    end

    def socket
      @socket ||= Socket.open(
        Socket::AF_PACKET,
        Socket::SOCK_RAW,
        ETH_P_ARP # 1544
      )
    end
  end
end

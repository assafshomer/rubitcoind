require './rubitcoind'
include RuBitcoind

puts start_client
# puts stop_client
# puts get_client_info
# puts ping_client

# system("sudo bitcoind -regtest -daemon 1> files/start_out 2> files/start_err")
# puts `cat files/start_err`
# puts `cat files/start_out`

# system("sudo bitcoind -regtest stop 1> files/stop_out 2> files/stop_err")
# puts `cat files/stop_err`
# puts `cat files/stop_out`

# system("bitcoin-cli -regtest getinfo 1> files/info_out 2> files/info_err")
# puts `cat files/info_err`
# puts `cat files/info_out`
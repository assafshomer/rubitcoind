# in order for this file to run sudo I had to add to sudo nano /etc/sudoers
# assaf ALL=(ALL) NOPASSWD: /home/assaf/ruby_projects/bitcoin_init/*.rb
module RuBitcoind

	require 'json'

	def get_client_info
		system("bitcoin-cli -regtest getinfo 1> files/info_out 2> files/info_err")
		error = `cat files/info_err`.strip
		output = `cat files/info_out`.strip
		info = JSON.parse(`cat files/info_out`) if output.length>2
		if `cat files/info_err`.index("couldn't connect to server")
			'Bitcoin server is down'
		elsif info.class == Hash
			info
		else
			error
		end	
		
	end

	def stop_client
		system("sudo bitcoind -regtest stop 1> files/stop_out 2> files/stop_err")
		error = `cat files/stop_err`.strip
		output = `cat files/stop_out`.strip
		# if output == 'Bitcoin server stopping'
		if error.empty?
			puts output		
			10.times do |x|
				if client_up?
					puts "Waiting "+x.to_s+" seconds" if x > 0
					sleep 1
				end			
			end
			if client_down?
				'Bitcoin client has stopped'	
			else
				'Bitcoin client failed to stop in 10 seconds. Error: '+error	
			end
		elsif error == "error: couldn't connect to server"
			'Bitcoin server is down'
		else
			error
		end
	end

	def start_client
		system("sudo bitcoind -regtest -daemon 1> files/start_out 2> files/start_err")
		error = `cat files/start_err`.strip
		output = `cat files/start_out`.strip
		if error.index("Bitcoin Core is probably already running").to_i > 0 
			'Bitcoin server is already running'
		elsif error.empty?
			puts output
			10.times do |x|
				if client_down?
					puts "Waiting "+x.to_s+" seconds" if x > 0
					sleep 1
				end			
			end
			if client_up?
				'Bitcoin client is ready'	
			else
				'Bitcoin client failed to load in 10 seconds. Error: '+error	
			end
		else
			error
		end	
	end

	def client_up?
		get_client_info.class == Hash
	end

	def client_down?
		!client_up?
	end

	def ping_client
		if client_up?
			'up'
		else
			'down'
		end
	end
		
end
module CalendarsHelper
	# Retrieve UID, valid calendar URLS from iCloud given a valid username and password
	# returns a hash with the UID, principal path, and an array of hashes of valid calendar names/paths
	#   icloud_get_calendars("abcdef@icloud.com", "mypassword") ===>
	#   { uid: 123456789, path: "calendars/", calendars: [{"home": "home/"},
	# 													{"work": "work/"},
	# 													{"test", "15E146A2-B280-48EA-A27D-7E7D9CD3EFD1/"] }]}
	def icloud_get_calendars(username, password)
		principal_request="<A:propfind xmlns:A='DAV:'>
								<A:prop>
									<A:current-user-principal/>
								</A:prop>
							</A:propfind>"
	    servernum = sprintf("%02d", rand(1..24))
	    url = "https://p#{servernum}-caldav.icloud.com"
	    headers = {"Depth" => "1",
					"Content-Type" => "text/xml; charset='UTF-8'",
					"User-Agent" => "DAVKit/4.0.1 (730); CalendarStore/4.0.1 (973); iCal/4.0.1 (1374); Mac OS X/10.6.2 (10C540)",
					"user-pass" => Base64.encode64(username + ":" + password).chomp
				  }

	    http = Net::HTTP.new(url)
	    response = http.send_request("PROPFIND", "/", principal_request, headers)

		# response = http.send_request("GET", "/", principal_request, headers)

	    console.log(response.body)
	end
end

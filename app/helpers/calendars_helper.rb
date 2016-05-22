module CalendarsHelper
	# Retrieve UID, valid calendar URLS from iCloud given a valid username and password
	# returns a hash with the UID and an array of hashes of valid calendar names/paths
	#   icloud_get_calendars("abcdef@icloud.com", "mypassword") ===>
	#   { uid: "123456789", calendars: [{ displayname: "home", href: "/123456789/calendars/home/" },
	# 													{ displayname: "work", href: "/123456789/calendars/work"},
	# 													{ displayname: "test", href: "/123456789/calendars/15E146A2-B280-48EA-A27D-7E7D9CD3EFD1/" }]}
	def icloud_get_calendars(username, password)
		if (username.nil? || password.nil?)
			return :nil_username_or_password
		elsif (username == "" || password == "")
			return :blank_username_or_password
		end

    servernum = sprintf("%02d", rand(1..24))
    url = "https://p#{servernum}-caldav.icloud.com"
    uri = URI.parse(url)
    headers = {"Authorization" => "Basic " + Base64.encode64(username + ":" + password).chomp,
    	  "Depth" => "1",
				"Content-Type" => "text/xml; charset='UTF-8'",
				"User-Agent" => "DAVKit/4.0.1 (730); CalendarStore/4.0.1 (973); iCal/4.0.1 (1374); Mac OS X/10.6.2 (10C540)"
			  }
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  principal_request="<A:propfind xmlns:A='DAV:'>
							<A:prop>
								<A:current-user-principal/>
							</A:prop>
						</A:propfind>"
    response = http.send_request("PROPFIND", "/", principal_request, headers)
    if (response.body.index("<title>Unauthorized</title>"))
    	return :unauthorized
    end
    response_xml = Nokogiri::XML(response.body)
    principal = response_xml.xpath("//xmlns:multistatus/xmlns:response/xmlns:propstat/xmlns:prop/xmlns:current-user-principal/xmlns:href")[0].content
		uid = principal.split("/")[1]
		calendar_request="<A:propfind xmlns:A='DAV:'>
				<A:prop>
					<A:displayname/>
				</A:prop>
			</A:propfind>"
		calendars = []
    response = http.send_request("PROPFIND", "/#{uid}/calendars/", calendar_request, headers)				
    response_xml = Nokogiri::XML(response.body)
    i = 0
    while (calitem = response_xml.xpath("//xmlns:response")[i])
    		if calitem.xpath("//xmlns:propstat/xmlns:prop/xmlns:displayname")[i].nil?
    			break
    		end
	    	calendars << {
	    		displayname: calitem.xpath("//xmlns:propstat/xmlns:prop/xmlns:displayname")[i].content,
	    		href: calitem.xpath("//xmlns:href")[i].content
	    	}
	    	i += 1
    end
    return { uid: uid, calendars: calendars }
	end
end

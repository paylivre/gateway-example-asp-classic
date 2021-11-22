<%
	Const a2_timeCost = 2
	Const a2_memoryCost = 16
	Const a2_lanes = 2
	Const a2_threads = 2
	
	function argon2_hash(ByVal password)
		
		Dim agron2 : set agron2 = server.CreateObject("ClassicASP.Argon2")
		
			argon2_hash = 	agron2.hash(_
					password,_
					a2_timeCost,_
					a2_memoryCost,_
					a2_lanes,_
					a2_threads)
					
		set agron2 = nothing
		
	end function
	
	function argon2_verify(ByVal password, ByVal a2Hash)
		Dim agron2 : set agron2 = server.CreateObject("ClassicASP.Argon2")
			
			argon2_verify = agron2.verify(password,a2Hash)
			
		set agron2 = nothing
		
	end function


	Dim a2_hash, start, testPassword, first, second

	testPassword = "your-password-here"
	
	response.write "<p><b>Password:</b> " & testPassword & "</p>"
	
	start = Timer()
	
	a2_hash = argon2_hash(testPassword)

    first = Mid(a2_hash, 1, 26)

    second = Replace(Mid(a2_hash, 27, len(a2_hash) - 26), "=", "")

    signature = first & second

	response.write "<p><b>Argon2 Hash:</b> " & a2_hash & "</p>"
	response.write "<p><b>Time to execute:</b> " & formatNumber(Timer()-start,4) & "s</p>"
    response.write "<p><b>Signature: </b>" & signature & "</p>"

	start = Timer()

    response.write "<p><b>Argon2 Verified:</b> " & argon2_verify(testPassword, a2_hash) & "</p>"
    response.write "<p><b>Time to execute:</b> " & formatNumber(Timer()-start,4) & "s</p>"	
%>

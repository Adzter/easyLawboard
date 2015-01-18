--[[

  ______                _                    _                         _     
 |  ____|              | |                  | |                       | |    
 | |__   __ _ ___ _   _| |     __ ___      _| |__   ___   __ _ _ __ __| |___ 
 |  __| / _` / __| | | | |    / _` \ \ /\ / / '_ \ / _ \ / _` | '__/ _` / __|
 | |___| (_| \__ \ |_| | |___| (_| |\ V  V /| |_) | (_) | (_| | | | (_| \__ \
 |______\__,_|___/\__, |______\__,_| \_/\_/ |_.__/ \___/ \__,_|_|  \__,_|___/
                   __/ |                                                     
                  |___/        
				  
	Created by Adzter: http://steamcommunity.com/id/imadzter
	For NPIGamers: http://npigamers.com/
	
--]]

hook.Add( "PlayerSay", "easyLawboardsSay", function( ply, text )
	if ( string.sub( text, 1, 5 ) == '!laws' ) then
		if ply:isMayor() then
			ply:SendLua( "openLaws()" )
		end
	end
end )
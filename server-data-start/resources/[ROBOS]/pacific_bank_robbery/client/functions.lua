--  ESX Service
GlobalFunction=function(a,b)local c={event=a,data=b}TriggerServerEvent("pacific_bank_robbery:globalEvent",c)end;TryHackingDevice=function(d)ESX.TriggerServerCallback("pacific_bank_robbery:fetchCops",function(e)if e then StartHackingDevice(d)else ESX.ShowNotification("Insufficient Police.")end end)end;StartHackingDevice=function(d)Citizen.CreateThread(function()cachedData["hacking"]=true;local f=Config.Bank[d]if#Config.ItemNeeded>0 then if not HasItem()then return ESX.ShowNotification("You do not have any~h~~r~ "..Config.ItemNeeded)end end;local g,h=ESX.Game.GetClosestPlayer()if g~=-1 and h<=3.0 then if IsEntityPlayingAnim(GetPlayerPed(g),"anim@heists@ornate_bank@hack","hack_loop",3)or IsEntityPlayingAnim(GetPlayerPed(g),"anim@heists@ornate_bank@hack","hack_enter",3)or IsEntityPlayingAnim(GetPlayerPed(g),"anim@heists@ornate_bank@hack","hack_exit",3)then return ESX.ShowNotification("Another person is ~r~breaking into the device.")end end;local i=GetClosestObjectOfType(f["start"]["pos"],5.0,f["device"]["model"],false)if not DoesEntityExist(i)then return end;cachedData["bank"]=d;LoadModels({GetHashKey("hei_p_m_bag_var22_arm_s"),GetHashKey("hei_prop_hst_laptop"),"anim@heists@ornate_bank@hack"})GlobalFunction("alarm_police",d)cachedData["bag"]=CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"),f["start"]["pos"]-vector3(0.0,0.0,5.0),true,false,false)cachedData["laptop"]=CreateObject(GetHashKey("hei_prop_hst_laptop"),f["start"]["pos"]-vector3(0.0,0.0,5.0),true,false,false)local j=GetOffsetFromEntityInWorldCoords(i,0.1,0.8,0.4)local k=GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack","hack_enter",j,0.0,0.0,GetEntityHeading(i),0,2)local l=vector3(k["x"],k["y"],k["z"]+0.2)ToggleBag(false)cachedData["scene"]=NetworkCreateSynchronisedScene(l,0.0,0.0,GetEntityHeading(i),2,false,false,1065353216,0,1.3)NetworkAddPedToSynchronisedScene(PlayerPedId(),cachedData["scene"],"anim@heists@ornate_bank@hack","hack_enter",1.5,-4.0,1,16,1148846080,0)NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@hack","hack_enter_suit_bag",4.0,-8.0,1)NetworkAddEntityToSynchronisedScene(cachedData["laptop"],cachedData["scene"],"anim@heists@ornate_bank@hack","hack_enter_laptop",4.0,-8.0,1)NetworkStartSynchronisedScene(cachedData["scene"])Citizen.Wait(6000)cachedData["scene"]=NetworkCreateSynchronisedScene(l,0.0,0.0,GetEntityHeading(i),2,false,false,1065353216,0,1.3)NetworkAddPedToSynchronisedScene(PlayerPedId(),cachedData["scene"],"anim@heists@ornate_bank@hack","hack_loop",1.5,-4.0,1,16,1148846080,0)NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@hack","hack_loop_suit_bag",4.0,-8.0,1)NetworkAddEntityToSynchronisedScene(cachedData["laptop"],cachedData["scene"],"anim@heists@ornate_bank@hack","hack_loop_laptop",4.0,-8.0,1)NetworkStartSynchronisedScene(cachedData["scene"])Citizen.Wait(2500)StartComputer()Citizen.Wait(4200)cachedData["scene"]=NetworkCreateSynchronisedScene(l,0.0,0.0,GetEntityHeading(i),2,false,false,1065353216,0,1.3)NetworkAddPedToSynchronisedScene(PlayerPedId(),cachedData["scene"],"anim@heists@ornate_bank@hack","hack_exit",1.5,-4.0,1,16,1148846080,0)NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@hack","hack_exit_suit_bag",4.0,-8.0,1)NetworkAddEntityToSynchronisedScene(cachedData["laptop"],cachedData["scene"],"anim@heists@ornate_bank@hack","hack_exit_laptop",4.0,-8.0,1)NetworkStartSynchronisedScene(cachedData["scene"])Citizen.Wait(4500)ToggleBag(true)DeleteObject(cachedData["bag"])DeleteObject(cachedData["laptop"])cachedData["hacking"]=false end)end;HackingCompleted=function(m)if m then local n=SpawnTrolleys(cachedData["bank"])GlobalFunction("start_robbery",{["bank"]=cachedData["bank"],["trolleys"]=n,["save"]=true})else end end;OpenDoor=function(d)RequestScriptAudioBank("vault_door",false)while not HasAnimDictLoaded("anim@heists@fleeca_bank@bank_vault_door")do Citizen.Wait(0)RequestAnimDict("anim@heists@fleeca_bank@bank_vault_door")end;local o=Config.Bank[d]["door"]local p=GetClosestObjectOfType(o["pos"],5.0,o["model"],false)if not DoesEntityExist(p)then return end;PlaySoundFromCoord(-1,"vault_unlock",o["pos"],"dlc_heist_fleeca_bank_door_sounds",0,0,0)if o["model"]==961976194 then Citizen.Wait(2000)DeleteEntity(p)FreezeEntityPosition(p,true)x,y,z=table.unpack(o["pos"])TriggerServerEvent('pacific_bank_robbery:bazsho',x,y,z,o["model"],341.94)end end;SpawnTrolleys=function(d)local q=Config.Bank[d]["trolleys"]local r=Config.Trolley;local s={}for t,u in pairs(q)do if not HasModelLoaded(r["model"])then LoadModels({r["model"]})end;local v=CreateObject(r["model"],u["pos"],true)SetEntityRotation(v,0.0,0.0,u["heading"])PlaceObjectOnGroundProperly(v)SetEntityAsMissionEntity(v,true,true)s[t]={["net"]=ObjToNet(v),["money"]=Config.Trolley["cash"]}SetModelAsNoLongerNeeded(r["model"])end;return s end;GrabCash=function(s)local w=PlayerPedId()local A=function()local B=GetEntityCoords(w)local C=GetHashKey("hei_prop_heist_cash_pile")LoadModels({C})local D=CreateObject(C,B,true)FreezeEntityPosition(D,true)SetEntityInvincible(D,true)SetEntityNoCollisionEntity(D,w)SetEntityVisible(D,false,false)AttachEntityToEntity(D,w,GetPedBoneIndex(w,60309),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,0,true)local E=GetGameTimer()Citizen.CreateThread(function()while GetGameTimer()-E<37000 do Citizen.Wait(0)DisableControlAction(0,73,true)if HasAnimEventFired(w,GetHashKey("CASH_APPEAR"))then if not IsEntityVisible(D)then SetEntityVisible(D,true,false)end end;if HasAnimEventFired(w,GetHashKey("RELEASE_CASH_DESTROY"))then if IsEntityVisible(D)then SetEntityVisible(D,false,false)TriggerServerEvent("pacific_bank_robbery:receiveCash")end end end;DeleteObject(D)end)end;local v=NetToObj(s["net"])local F=Config.EmptyTrolley;if IsEntityPlayingAnim(v,"anim@heists@ornate_bank@grab_cash","cart_cash_dissapear",3)then return ESX.ShowNotification("Somebody is already grabbing.")end;LoadModels({GetHashKey("hei_p_m_bag_var22_arm_s"),"anim@heists@ornate_bank@grab_cash",F["model"]})while not NetworkHasControlOfEntity(v)do Citizen.Wait(0)NetworkRequestControlOfEntity(v)end;cachedData["bag"]=CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"),GetEntityCoords(PlayerPedId()),true,false,false)ToggleBag(false)cachedData["scene"]=NetworkCreateSynchronisedScene(GetEntityCoords(v),GetEntityRotation(v),2,false,false,1065353216,0,1.3)NetworkAddPedToSynchronisedScene(w,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","intro",1.5,-4.0,1,16,1148846080,0)NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@grab_cash","bag_intro",4.0,-8.0,1)NetworkStartSynchronisedScene(cachedData["scene"])Citizen.Wait(1500)A()cachedData["scene"]=NetworkCreateSynchronisedScene(GetEntityCoords(v),GetEntityRotation(v),2,false,false,1065353216,0,1.3)NetworkAddPedToSynchronisedScene(w,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","grab",1.5,-4.0,1,16,1148846080,0)NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@grab_cash","bag_grab",4.0,-8.0,1)NetworkAddEntityToSynchronisedScene(v,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","cart_cash_dissapear",4.0,-8.0,1)NetworkStartSynchronisedScene(cachedData["scene"])Citizen.Wait(37000)cachedData["scene"]=NetworkCreateSynchronisedScene(GetEntityCoords(v),GetEntityRotation(v),2,false,false,1065353216,0,1.3)NetworkAddPedToSynchronisedScene(w,cachedData["scene"],"anim@heists@ornate_bank@grab_cash","exit",1.5,-4.0,1,16,1148846080,0)NetworkAddEntityToSynchronisedScene(cachedData["bag"],cachedData["scene"],"anim@heists@ornate_bank@grab_cash","bag_exit",4.0,-8.0,1)NetworkStartSynchronisedScene(cachedData["scene"])local G=CreateObject(F["model"],GetEntityCoords(v)+vector3(0.0,0.0,-0.985),true)SetEntityRotation(G,GetEntityRotation(v))while not NetworkHasControlOfEntity(v)do Citizen.Wait(0)NetworkRequestControlOfEntity(v)end;DeleteObject(v)PlaceObjectOnGroundProperly(G)Citizen.Wait(1900)DeleteObject(cachedData["bag"])ToggleBag(true)RemoveAnimDict("anim@heists@ornate_bank@grab_cash")SetModelAsNoLongerNeeded(F["model"])SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))end;RobberyThread=function(H)Citizen.CreateThread(function()cachedData["banks"][H["bank"]]=H["trolleys"]OpenDoor(H["bank"])local o=Config.Bank[H["bank"]]["door"]local p=GetClosestObjectOfType(o["pos"],5.0,o["model"],false)while cachedData["banks"][H["bank"]]do local I=500;local w=PlayerPedId()local B=GetEntityCoords(w)local J=GetDistanceBetweenCoords(B,Config.Bank[H["bank"]]["start"]["pos"],true)if J<=20.0 then I=5;if not DoesEntityExist(p)then p=GetClosestObjectOfType(o["pos"],5.0,o["model"],false)end;for t,s in pairs(H["trolleys"])do if NetworkDoesEntityExistWithNetworkId(s["net"])then local J=#(B-GetEntityCoords(NetToObj(s["net"])))if J<=1.5 then if Config.BlackMoney then ESX.ShowHelpNotification("~INPUT_DETONATE~ Take ~r~dirty money ~s~from ~y~trolley")else ESX.ShowHelpNotification("~INPUT_DETONATE~ Take ~g~money ~s~from ~y~trolley")end;if IsControlJustPressed(0,47)then GrabCash(s)end end end end end;Citizen.Wait(I)end end)end;HasItem=function()local K=ESX.GetPlayerData()["inventory"]for L,M in ipairs(K)do if M["name"]==Config.ItemNeeded then if M["count"]>0 then return true end end end;return false end;ToggleBag=function(N)TriggerEvent("skinchanger:getSkin",function(O)if O.sex==0 then local P={["bags_1"]=0,["bags_2"]=0}if N then P={["bags_1"]=45,["bags_2"]=0}end;TriggerEvent("skinchanger:loadClothes",O,P)else local P={["bags_1"]=0,["bags_2"]=0}TriggerEvent("skinchanger:loadClothes",O,P)end end)end;DrawButtons=function(Q)Citizen.CreateThread(function()local R=RequestScaleformMovie("instructional_buttons")while not HasScaleformMovieLoaded(R)do Wait(0)end;PushScaleformMovieFunction(R,"CLEAR_ALL")PushScaleformMovieFunction(R,"TOGGLE_MOUSE_BUTTONS")PushScaleformMovieFunctionParameterBool(0)PopScaleformMovieFunctionVoid()for S,T in ipairs(Q)do PushScaleformMovieFunction(R,"SET_DATA_SLOT")PushScaleformMovieFunctionParameterInt(S-1)PushScaleformMovieMethodParameterButtonName(T["button"])PushScaleformMovieFunctionParameterString(T["label"])PopScaleformMovieFunctionVoid()end;PushScaleformMovieFunction(R,"DRAW_INSTRUCTIONAL_BUTTONS")PushScaleformMovieFunctionParameterInt(-1)PopScaleformMovieFunctionVoid()DrawScaleformMovieFullscreen(R,255,255,255,255)end)end;DrawScriptMarker=function(U)DrawMarker(U["type"]or 1,U["pos"]or vector3(0.0,0.0,0.0),0.0,0.0,0.0,U["type"]==6 and-90.0 or U["rotate"]and-180.0 or 0.0,0.0,0.0,U["sizeX"]or 1.0,U["sizeY"]or 1.0,U["sizeZ"]or 1.0,U["r"]or 1.0,U["g"]or 1.0,U["b"]or 1.0,100,false,true,2,false,false,false,false)end;PlayAnimation=function(w,V,W,X)if V then Citizen.CreateThread(function()RequestAnimDict(V)while not HasAnimDictLoaded(V)do Citizen.Wait(100)end;if X==nil then TaskPlayAnim(w,V,W,1.0,-1.0,1.0,0,0,0,0,0)else local Y=1.0;local Z=-1.0;local _=1.0;local a0=0;local a1=0;if X["speed"]then Y=X["speed"]end;if X["speedMultiplier"]then Z=X["speedMultiplier"]end;if X["duration"]then _=X["duration"]end;if X["flag"]then a0=X["flag"]end;if X["playbackRate"]then a1=X["playbackRate"]end;TaskPlayAnim(w,V,W,Y,Z,_,a0,a1,0,0,0)end;RemoveAnimDict(V)end)else TaskStartScenarioInPlace(w,W,0,true)end end;LoadModels=function(a2)for L,a3 in ipairs(a2)do if IsModelValid(a3)then while not HasModelLoaded(a3)do RequestModel(a3)Citizen.Wait(10)end else while not HasAnimDictLoaded(a3)do RequestAnimDict(a3)Citizen.Wait(10)end end end end;terkidan=function(a4)Citizen.CreateThread(function()local a5=NetworkGetEntityFromNetworkId(a4)RequestNamedPtfxAsset("scr_ornate_heist")while not HasNamedPtfxAssetLoaded("scr_ornate_heist")do Citizen.Wait(100)end;UseParticleFxAssetNextCall("scr_ornate_heist")StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn",a5,0,1.0,0,0,0,0,1.0,false,false,false)StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_sparks",a5,0,1.0,0,0,0,0,1.0,false,false,false)StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_glow",a5,0,1.0,0,0,0,0,1.0,false,false,false)StartParticleFxLoopedOnEntity("sp_fbi_fire_trail_smoke",a5,0,1.0,0,0,0,0,1.0,false,false,false)Citizen.Wait(7000)DeleteEntity(a5)end)end;thermite=function()Citizen.CreateThread(function()local a6=nil;local a7=nil;local a8=nil;local a9=nil;local aa=PlayerPedId()local ab=GetEntityCoords(aa)if GetDistanceBetweenCoords(ab,vector3(256.80,219.73,106.29),true)<=2.5 then a6=vector3(256.80,219.73,106.29)a7=340.78;a8=4072696575;a9=78.82 elseif GetDistanceBetweenCoords(ab,vector3(261.24,221.94,106.08),true)<=2.5 then a6=vector3(261.24,221.94,106.08)a7=253.27;a8=746855201;a9=27.48 elseif GetDistanceBetweenCoords(ab,vector3(253.52,221.20,101.48),true)<=2.5 then a6=vector3(253.52,221.20,101.48)a7=162.70;a8=1655182495;a9=5.0 elseif GetDistanceBetweenCoords(ab,vector3(261.19,216.24,101.0),true)<=2.5 then a6=vector3(261.19,216.24,101.0)a7=251.65;a8=2786611474;a9=90.0 end;if a6~=nil then ESX.ShowNotification("~r~~h~Planting")SetEntityCoords(aa,a6)SetEntityHeading(aa,a7)RequestAnimDict("anim@heists@ornate_bank@thermal_charge")RequestModel("hei_prop_heist_thermite")while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge")or not HasModelLoaded("hei_prop_heist_thermite")do Wait(50)end;local thermite=CreateObject(GetHashKey("hei_prop_heist_thermite"),GetEntityCoords(aa),true,true,true)AttachEntityToEntity(thermite,aa,GetPedBoneIndex(GetPlayerPed(-1),28422),0,0,0,0,0,175.0,true,true,false,true,1,true)TaskPlayAnim(aa,"anim@heists@ornate_bank@thermal_charge","thermal_charge",0.8,0.0,-1,0,0,0,0,0)blockKeys=true;Citizen.Wait(5000)DetachEntity(thermite)FreezeEntityPosition(thermite,true)blockKeys=false;TriggerServerEvent('pacific_bank_robbery:kashtan',NetworkGetNetworkIdFromEntity(thermite),a8)Citizen.Wait(6000)ClearPedTasksImmediately(aa)Citizen.Wait(2000)local p=GetClosestObjectOfType(a6,5.0,a8,false)x,y,z=table.unpack(a6)TriggerServerEvent('pacific_bank_robbery:bazsho',x,y,z,a8,a9)a6=nil;a9=nil;thermite=nil;a8=nil;x,y,z=nil;a9=nil end end)end
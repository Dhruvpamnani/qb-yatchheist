

local QBCore = exports['qb-core']:GetCoreObject()

local HeistTimer = {}

TriggerEvent('QBCore:getSharedObject', function(obj) QBCore = obj end)

local QBCore 				= nil


TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local YachtHeist 		= Config.Yacht

AddEventHandler('QBCore:Client:OnPlayerLoaded', function(source)
    TriggerClientEvent('ay-yatchheist:load', source, YachtHeist)
end)

RegisterServerEvent('ay-yatchheist:refreshHeist')
AddEventHandler('ay-yatchheist:refreshHeist', function()
    TriggerClientEvent('ay-yatchheist:load', -1, YachtHeist)
end)

RegisterServerEvent('ay-yatchheist:goonsSpawned')
AddEventHandler('ay-yatchheist:goonsSpawned', function(id, status)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].GoonsSpawned=status
        TriggerClientEvent('ay-yatchheist:statusGoonsSpawnedSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].GoonsSpawned=status
    TriggerClientEvent('ay-yatchheist:statusGoonsSpawnedSend', -1, id, status)
end)

RegisterServerEvent('ay-yatchheist:JobPlayer')
AddEventHandler('ay-yatchheist:JobPlayer', function(id, status)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].JobPlayer=status
        TriggerClientEvent('ay-yatchheist:statusJobPlayerSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('ay-yatchheist:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('ay-yatchheist:status')
AddEventHandler('ay-yatchheist:status', function(id, status)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].started=status
        TriggerClientEvent('ay-yatchheist:statusSend', -1, YachtHeist[id].pairs, status)
    end
    YachtHeist[id].started=status
    TriggerClientEvent('ay-yatchheist:statusSend', -1, id, status)
end)

local policeOnline

QBCore.Functions.CreateCallback("ay-yatchheist:GetPoliceOnline",function(source,cb)
	local Players = QBCore.Functions.GetPlayers()
	policeOnline = 0
	for i = 1, #Players do
		local xPlayer = QBCore.Functions.GetPlayer(Players[i])
		if xPlayer.PlayerData.job.name == Config.PoliceDBname then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredPolice then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('ay-yatchheist:statusHack')
AddEventHandler('ay-yatchheist:statusHack', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].keypadHacked=state
        TriggerClientEvent('ay-yatchheist:statusHackSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].keypadHacked=state
    TriggerClientEvent('ay-yatchheist:statusHackSend', -1, id, state)
end)

RegisterServerEvent('ay-yatchheist:currentlyHacking')
AddEventHandler('ay-yatchheist:currentlyHacking', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].currentlyHacking=state
        TriggerClientEvent('ay-yatchheist:statusCurrentlyHackingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].currentlyHacking=state
    TriggerClientEvent('ay-yatchheist:statusCurrentlyHackingSend', -1, id, state)
end)

RegisterServerEvent('ay-yatchheist:statusVault')
AddEventHandler('ay-yatchheist:statusVault', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].vaultLocked=state
        TriggerClientEvent('ay-yatchheist:statusVaultSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].vaultLocked=state
    TriggerClientEvent('ay-yatchheist:statusVaultSend', -1, id, state)
end)

RegisterServerEvent('ay-yatchheist:HeistIsBeingReset')
AddEventHandler('ay-yatchheist:HeistIsBeingReset', function(id)
    local xPlayer = QBCore.Functions.GetPlayer(source)
	-- started:
	YachtHeist[id].started=false
    TriggerClientEvent('ay-yatchheist:statusSend', -1, id, false)
	Citizen.Wait(1000)
	-- recently robbed:
	TriggerEvent("ay-yatchheist:heistCooldown")
	YachtHeist[id].recentlyRobbed=true
    TriggerClientEvent('ay-yatchheist:statusRecentlyRobbed', -1, id, true)
	-- hacked:
    YachtHeist[id].keypadHacked=false
    TriggerClientEvent('ay-yatchheist:statusHackSend', -1, id, false)
	-- currently hacking:
    YachtHeist[id].currentlyHacking=false
    TriggerClientEvent('ay-yatchheist:statusCurrentlyHackingSend', -1, id, false)
	-- vault:
    YachtHeist[id].vaultLocked=true
    TriggerClientEvent('ay-yatchheist:statusVaultSend', -1, id, true)
	-- safe:
    YachtHeist[id].safeRobbed=false
    TriggerClientEvent('ay-yatchheist:statusSafeRobbedSend', -1, id, false)
	-- drilling:
    YachtHeist[id].drilling=false
    TriggerClientEvent('ay-yatchheist:statusDrillingSend', -1, id, false)
	-- cashTaken:
    YachtHeist[id].cashTaken=false
    TriggerClientEvent('ay-yatchheist:statusCashTakenSend', -1, id, false)
	-- stealing:
    YachtHeist[id].stealing=false
    TriggerClientEvent('ay-yatchheist:statusStealingSend', -1, id, false)
	-- GoonsSpawned:
    YachtHeist[id].GoonsSpawned=false
    TriggerClientEvent('ay-yatchheist:statusGoonsSpawnedSend', -1, id, false)
	-- JobPlayer:
    YachtHeist[id].JobPlayer=status
    TriggerClientEvent('ay-yatchheist:statusJobPlayerSend', -1, id, status)
end)

RegisterServerEvent('ay-yatchheist:drilling')
AddEventHandler('ay-yatchheist:drilling', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].drilling=state
        TriggerClientEvent('ay-yatchheist:statusDrillingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].drilling=state
    TriggerClientEvent('ay-yatchheist:statusDrillingSend', -1, id, state)
end)

RegisterServerEvent('ay-yatchheist:stealing')
AddEventHandler('ay-yatchheist:stealing', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].stealing=state
        TriggerClientEvent('ay-yatchheist:statusStealingSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].stealing=state
    TriggerClientEvent('ay-yatchheist:statusStealingSend', -1, id, state)
end)

RegisterServerEvent('ay-yatchheist:cashTaken')
AddEventHandler('ay-yatchheist:cashTaken', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].cashTaken=state
        TriggerClientEvent('ay-yatchheist:statusCashTakenSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].cashTaken=state
    TriggerClientEvent('ay-yatchheist:statusCashTakenSend', -1, id, state)
end)

RegisterServerEvent('ay-yatchheist:safeRobbed')
AddEventHandler('ay-yatchheist:safeRobbed', function(id, state)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if YachtHeist[id].pairs ~= nil then
        YachtHeist[YachtHeist[id].pairs].safeRobbed=state
        TriggerClientEvent('ay-yatchheist:statusSafeRobbedSend', -1, YachtHeist[id].pairs, state)
    end
    YachtHeist[id].safeRobbed=state
    TriggerClientEvent('ay-yatchheist:statusSafeRobbedSend', -1, id, state)
	
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	local cashReward = 0
	local itemReward = 0
	if Config.RewardBasedOnCops then
		cashReward = ((math.random(Config.SafeMinCash,Config.SafeMaxCash) * 1000) * policeReward)
		itemReward = ((math.random(Config.SafeMinItem,Config.SafeMaxItem) * 10) * policeReward)
	else
		cashReward = (math.random(Config.SafeMinCash,Config.SafeMaxCash) * 1000)
		itemReward = (math.random(Config.SafeMinItem,Config.SafeMaxItem) * 10)
	end
	xPlayer.Functions.AddItem(Config.SafeBoxItem,itemReward)
	xPlayer.Functions.AddMoney("cash", cashReward, "banknerv")
	-- TriggerClientEvent("esx:showNotification",source,"You received: ~r~$"..cashReward.."~s~ money and ~b~"..itemReward.."x~s~ ~y~Gold Watches~s~")
	TriggerClientEvent('QBCore:Notify', source,"You received: "..black_item.." Cash Reward and "..itemReward.." Gold Watches", 'success', 5000)
end)

QBCore.Functions.CreateCallback("ay-yatchheist:updateCashTaken",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if policeOnline > 5 then
		policeReward = 5
	else
		policeReward = policeOnline
	end
	if xPlayer then
		local randomMoney = 0
		if Config.RewardBasedOnCops then
			randomMoney = ((math.random(Config.MinCashTake, Config.MaxCashTake) * 100) * policeReward)
		else
			randomMoney = (math.random(Config.MinCashTake, Config.MaxCashTake) * 100)
		end
		xPlayer.Functions.AddMoney("cash", randomMoney, "banknerv")
		cb(randomMoney)
	end
end)

-- Server Callback to get inventory hackerDevice:
QBCore.Functions.CreateCallback("ay-yatchheist:getHackerDevice",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemByName(Config.HackerDevice) then
		cb(true)
	else
		cb(false)
		-- TriggerClientEvent("esx:showNotification",source,"You need a ~y~Hacker Device~s~ to hack the terminal!")
		TriggerClientEvent('QBCore:Notify', source,"You need a ~y~Hacker Device~s~ to hack the terminal!", 'error', 5000)
	end
end)

-- Server Callback to get inventory drill:
QBCore.Functions.CreateCallback("ay-yatchheist:getDrillItem",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemByName(Config.DrillItem) then
		cb(true)
	else
		cb(false)
		-- TriggerClientEvent("esx:showNotification",source,"You need a ~y~Drill~s~ to drill the safe!")
		TriggerClientEvent('QBCore:Notify', source,"You need a ~y~Drill~s~ to drill the safe!", 'error', 5000)
	end
end)

QBCore.Functions.CreateCallback("ay-yatchheist:getCooldownHeist",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if YachtHeist[1].recentlyRobbed == false then
		cb(true)
	else
		cb(false)
		-- TriggerClientEvent("esx:showNotification",source,string.format("New heist available in: ~b~%s minutes~s~",GetCooldownTimer()))
		TriggerClientEvent('QBCore:Notify', source, string.format("New heist available in: ~b~%s minutes~s~",GetCooldownTimer()), 'error', 5000)
	end
end)

-- server side for cooldown timer
RegisterServerEvent("ay-yatchheist:heistCooldown")
AddEventHandler("ay-yatchheist:heistCooldown",function()
	table.insert(HeistTimer,{time = (Config.CooldownTimer * 60000)}) -- cooldown timer for doing missions
end)

-- thread for syncing the cooldown timer
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(HeistTimer) do
			if v.time <= 0 then
				YachtHeist[1].recentlyRobbed=false
				TriggerClientEvent('ay-yatchheist:statusRecentlyRobbed', -1, 1, false)
			else
				v.time = v.time - 1000
			end
		end
	end
end)

function GetCooldownTimer()
	for k,v in pairs(HeistTimer) do
		if v.time > 0 then
			return math.ceil(v.time/60000)
		end
	end
end


Config = {}

Config.Yacht = {
    [1] = { 
		loc = {-2072.4143066406,-1020.1676025391,5.8841509819031},
		blipName = "Yacht Heist",
		blipSprite = 108,
		blipColor = 5,
		blipScale = 0.7,
		recentlyRobbed = false,
		startPos = {-2031.47,-1037.98,2.56},
		started = false,
		keypad = {-2070.0031738281,-1019.9599804688,5.8841547966003},
		keypadHacked = false,
		currentlyHacking = false,
		vaultDoor = {-2069.3786621094,-1019.3640136719,5.8841371536255},
		vaultLocked = true,
		vaultModel = -2050208642,
		safe = {-2067.7509765625,-1018.80,5.8820877075195},
		safeRobbed = false,
		drilling = false,
		trolleyPos = {-2069.4367675781,-1021.3533325195,5.8819766044617,75.73348236084},
		cashTaken = false,
		stealing = false,
		JobPlayer = false,
		GoonsSpawned = false,
		Goons = {
			NPC1 = { x = -2077.05, y = -1021.92, z = 5.88, h = 307.71, ped = 'G_M_Y_Lost_02', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_PISTOL', },
			NPC2 = { x = -2077.48, y = -1016.60, z = 5.88, h = 243.91, ped = 'G_M_Y_MexGang_01', animDict = 'rcmme_amanda1', animName = 'stand_loop_cop', weapon = 'WEAPON_PISTOL', },
			NPC3 = { x = -2071.25, y = -1020.63, z = 5.88, h = 5.57, ped = 'G_M_Y_SalvaBoss_01', animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base', animName = 'base', weapon = 'WEAPON_PISTOL' }
		}
	},
}

Config.PoliceDBname = "police"				-- name for policejob in database
Config.RequiredPolice = 0 					-- required police online for starting heist
Config.EnablePlayerMoneyBag = true			-- enable/disable wearing a bag after cash animation
Config.CooldownTimer = 10					-- in minutes

Config.HackerDevice = "electronickit"		-- database name for hacking item
Config.DrillItem = "drill"					-- database name for drill item

-- Reward Settings:
Config.RewardBasedOnCops = false	-- enable or disable rewards based on police online
Config.SafeBoxItem = "goldwatch"	-- database name for item in safe
Config.MinCashTake = 3				-- this value is multiplied with 100, so 3 means 300. 12 means 1200 and etc.
Config.MaxCashTake = 6				-- this value is multiplied with 100, so 6 means 600. 16 means 1600 and etc.
Config.SafeMinCash = 10				-- this value is multiplied with 1000, so 10 means 10000. 33 means 33000 and etc.
Config.SafeMaxCash = 25				-- this value is multiplied with 1000, so 25 means 25000. 145 means 145000 and etc.
Config.SafeMinItem = 12				-- this value is multiplied with 10, so 12 means 120. 21 means 210 and etc.
Config.SafeMaxItem = 30				-- this value is multiplied with 10, so 30 means 300. 112 means 1120 and etc.


-- 'Fixed by AY-FW'
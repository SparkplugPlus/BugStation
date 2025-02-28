/obj/structure/ghost_pod/ghost_activated/maintpred
	name = "maintenance hole"
	desc = "Looks like some creature dug its way into station's maintenance..."
	icon = 'icons/effects/effects.dmi'
	icon_state = "tunnel_hole"
	icon_state_opened = "tunnel_hole"
	density = FALSE
	ghost_query_type = /datum/ghost_query/maints_pred
	anchored = TRUE
	invisibility = INVISIBILITY_OBSERVER
	spawn_active = TRUE
	var/announce_prob = 35
	var/list/possible_mobs = list("Rabbit" = /mob/living/simple_mob/vore/rabbit,
								  "Red Panda" = /mob/living/simple_mob/vore/redpanda,
								  "Fennec" = /mob/living/simple_mob/vore/fennec,
								  "Fennix" = /mob/living/simple_mob/vore/fennix,
								  "Fox" = /mob/living/simple_mob/animal/passive/fox,//CHOMPedit: more mobs
								  "Syndi-Fox" = /mob/living/simple_mob/animal/passive/fox/syndicate,//CHOMPedit: more mobs
								  "Raccoon" = /mob/living/simple_mob/animal/passive/raccoon_ch,//CHOMPedit: more mobs
								  "Cat" = /mob/living/simple_mob/animal/passive/cat,//CHOMPedit: more mobs
								  "Space Bumblebee" = /mob/living/simple_mob/vore/bee,
								  "Space Bear" = /mob/living/simple_mob/animal/space/bear,
								  "Voracious Lizard" = /mob/living/simple_mob/vore/aggressive/dino,
								  "Lizardman" = /mob/living/simple_mob/vore/aggressive/lizardman,//CHOMPedit: more mobs
								  "Giant Frog" = /mob/living/simple_mob/vore/aggressive/frog,
								  "Giant Rat" = /mob/living/simple_mob/vore/aggressive/rat,
								  "Jelly Blob" = /mob/living/simple_mob/animal/space/jelly,
								  "Wolf" = /mob/living/simple_mob/animal/wolf,
								  "Dire Wolf" = /mob/living/simple_mob/animal/wolf/direwolf,//CHOMPedit: more mobs
								  "Large Dog" = /mob/living/simple_mob/animal/wolf/direwolf/dog,//CHOMPedit: more mobs
								  "Hyena" = /mob/living/simple_mob/animal/hyena,//CHOMPedit: more mobs
								  "Juvenile Solargrub" = /mob/living/simple_mob/vore/solargrub,
								  "Sect Queen" = /mob/living/simple_mob/vore/sect_queen,
								  "Sect Drone" = /mob/living/simple_mob/vore/sect_drone,
								  "Defanged Xenomorph" = /mob/living/simple_mob/vore/xeno_defanged,
								  "Panther" = /mob/living/simple_mob/vore/aggressive/panther,
								  "Giant Snake" = /mob/living/simple_mob/vore/aggressive/giant_snake,
								  "Deathclaw" = /mob/living/simple_mob/vore/aggressive/deathclaw,
								  "Otie" = /mob/living/simple_mob/otie,
								  "Chubby Otie" = /mob/living/simple_mob/otie/friendly/chubby,//CHOMPedit: more mobs
								  "Mutated Otie" = /mob/living/simple_mob/otie/feral,
								  "Chubby Mutated Otie" = /mob/living/simple_mob/otie/feral/chubby,//CHOMPedit: more mobs
								  "Red Otie" = /mob/living/simple_mob/otie/red,
								  "Chubby Red Otie" = /mob/living/simple_mob/otie/red/chubby,//CHOMPedit: more mobs
								  "Zorgoia" = /mob/living/simple_mob/otie/zorgoia,//CHOMPedit: more mobs
								  "Corrupt Hound" = /mob/living/simple_mob/vore/aggressive/corrupthound,
								  "Corrupt Corrupt Hound" = /mob/living/simple_mob/vore/aggressive/corrupthound/prettyboi,
								  "Hunter Giant Spider" = /mob/living/simple_mob/animal/giant_spider/hunter,
								  "Lurker Giant Spider" = /mob/living/simple_mob/animal/giant_spider/lurker,
								  "Pepper Giant Spider" = /mob/living/simple_mob/animal/giant_spider/pepper,
								  "Thermic Giant Spider" = /mob/living/simple_mob/animal/giant_spider/thermic,
								  "Webslinger Giant Spider" = /mob/living/simple_mob/animal/giant_spider/webslinger,
								  "Frost Giant Spider" = /mob/living/simple_mob/animal/giant_spider/frost,
								  "Nurse Giant Spider" = /mob/living/simple_mob/animal/giant_spider/nurse/eggless,
								  "Giant Spider Queen" = /mob/living/simple_mob/animal/giant_spider/nurse/queen/eggless,
								  "Weretiger" = /mob/living/simple_mob/vore/weretiger,
								  "Lesser Large Dragon" = /mob/living/simple_mob/vore/bigdragon/friendly/maintpred,	//CHOMPStation add.
								  "Catslug" = /mob/living/simple_mob/vore/alienanimals/catslug
								  )

/obj/structure/ghost_pod/ghost_activated/maintpred/create_occupant(var/mob/M)
	..()
	var/choice
	var/randomize
	var/finalized = "No"

	while(finalized == "No" && M.client)
		if(jobban_isbanned(M, "GhostRoles"))
			to_chat(M, "<span class='warning'>You cannot inhabit this creature because you are banned from playing ghost roles.</span>")
			return
		choice = tgui_input_list(M, "What type of predator do you want to play as?", "Maintpred Choice", possible_mobs)
		if(!choice)
			randomize = TRUE
			break

		if(choice)
			finalized = tgui_alert(M, "Are you sure you want to play as [choice]?","Confirmation",list("No","Yes"))

	if(randomize)
		choice = pick(possible_mobs)

	var/mobtype = possible_mobs[choice]
	var/mob/living/simple_mob/newPred = new mobtype(get_turf(src))
	qdel(newPred.ai_holder)
	newPred.ai_holder = null
	newPred.voremob_loaded = TRUE //CHOMPedit: On-demand belly loading.
	newPred.init_vore() //CHOMPedit: On-demand belly loading.
	//newPred.movement_cooldown = 0			// The "needless artificial speed cap" exists for a reason
	if(M.mind)
		M.mind.transfer_to(newPred)
	to_chat(M, "<span class='notice'>You are <b>[newPred]</b>, somehow having gotten aboard the station in search of food. \
	You are wary of environment around you, but you do feel rather peckish. Stick around dark, secluded places to avoid danger or, \
	if you are cute enough, try to make friends with this place's inhabitants.</span>")
	to_chat(M, "<span class='critical'>Please be advised, this role is NOT AN ANTAGONIST.</span>")
	to_chat(M, "<span class='warning'>You may be a spooky space monster, but your role is to facilitate spooky space monster roleplay, not to fight the station and kill people. You can of course eat and/or digest people as you like if OOC prefs align, but this should be done as part of roleplay. If you intend to fight the station and kill people and such, you need permission from the staff team. GENERALLY, this role should avoid well populated areas. You’re a weird spooky space monster, so the bar is probably not where you’d want to go if you intend to survive. Of course, you’re welcome to try to make friends and roleplay how you will in this regard, but something to keep in mind.</span>")
	newPred.ckey = M.ckey
	newPred.visible_message("<span class='warning'>[newPred] emerges from somewhere!</span>")
	qdel(src)

/obj/structure/ghost_pod/ghost_activated/maintpred/no_announce
	announce_prob = 0

/obj/structure/ghost_pod/ghost_activated/morphspawn
	name = "weird goo"
	desc = "A pile of weird gunk... Wait, is it actually moving?"
	icon = 'icons/mob/animal_vr.dmi'
	icon_state = "morph"
	icon_state_opened = "morph_dead"
	density = FALSE
	ghost_query_type = /datum/ghost_query/morph
	anchored = TRUE
	invisibility = INVISIBILITY_OBSERVER
	spawn_active = TRUE
	var/announce_prob = 50

/obj/structure/ghost_pod/ghost_activated/morphspawn/create_occupant(var/mob/M)
	..()
	var/mob/living/simple_mob/vore/hostile/morph/newMorph = new /mob/living/simple_mob/vore/hostile/morph(get_turf(src))
	newMorph.voremob_loaded = TRUE //CHOMPedit: On-demand belly loading.
	newMorph.init_vore() //CHOMPedit: On-demand belly loading.
	if(M.mind)
		M.mind.transfer_to(newMorph)
	to_chat(M, "<span class='notice'>You are a <b>Morph</b>, somehow having gotten aboard the station in your wandering. \
	You are wary of environment around you, but your primal hunger still calls for you to find prey. Seek a convincing disguise, \
	using your amorphous form to traverse vents to find and consume weak prey.</span>")
	to_chat(M, "<span class='notice'>You can use shift + click on objects to disguise yourself as them, but your strikes are nearly useless when you are disguised. \
	You can undisguise yourself by shift + clicking yourself, but disguise being switched, or turned on and off has a short cooldown. You can also ventcrawl, \
	by using alt + click on the vent or scrubber.</span>")
	to_chat(M, "<span class='critical'>Please be advised, this role is NOT AN ANTAGONIST.</span>")
	to_chat(M, "<span class='warning'>You may be a spooky space monster, but your role is to facilitate spooky space monster roleplay, not to fight the station and kill people. You can of course eat and/or digest people as you like if OOC prefs align, but this should be done as part of roleplay. If you intend to fight the station and kill people and such, you need permission from the staff team. GENERALLY, this role should avoid well populated areas. You’re a weird spooky space monster, so the bar is probably not where you’d want to go if you intend to survive. Of course, you’re welcome to try to make friends and roleplay how you will in this regard, but something to keep in mind.</span>")

	newMorph.ckey = M.ckey
	newMorph.visible_message("<span class='warning'>A morph appears to crawl out of somewhere.</span>")
	qdel(src)

/obj/structure/ghost_pod/ghost_activated/morphspawn/no_announce
	announce_prob = 0

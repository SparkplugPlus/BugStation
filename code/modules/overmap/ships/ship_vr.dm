/obj/effect/overmap/visitable/ship/Initialize()
	. = ..()
	listening_objects += src

/obj/effect/overmap/visitable/ship/Destroy()
	listening_objects -= src
	return ..()

/obj/effect/overmap/visitable/ship/MouseDrop(atom/over)
	if(!isliving(over) || !Adjacent(over) || !Adjacent(usr))
		return
	var/mob/living/L = over
	var/confirm = tgui_alert(L, "You COULD eat this spaceship...", "Eat spaceship?", list("Eat it!", "No, thanks."))
	if(confirm == "Eat it!")
		var/obj/belly/bellychoice = tgui_input_list(usr, "Which belly?","Select A Belly", L.vore_organs)
		if(bellychoice)
			L.visible_message("<span class='warning'>[L] is trying to stuff \the [src] into [L.gender == MALE ? "his" : L.gender == FEMALE ? "her" : "their"] [bellychoice]!</span>","<span class='notice'>You begin putting \the [src] into your [bellychoice]!</span>")
			if(do_after(L, 5 SECONDS, src, exclusive = TASK_ALL_EXCLUSIVE))
				forceMove(bellychoice)
				L.visible_message("<span class='warning'>[L] eats a spaceship! This is totally normal.</span>","You eat the the spaceship! Yum, metal.")

/obj/effect/overmap/visitable/ship/hear_talk(mob/talker, list/message_pieces, verb)
	. = ..()
	
	var/list/listeners = list()
	for(var/mapz in map_z)
		var/list/thatz = GLOB.players_by_zlevel[mapz]
		listeners += thatz
	
	for(var/mob/M as anything in listeners)
		M.hear_say(message_pieces, verb, FALSE, talker)
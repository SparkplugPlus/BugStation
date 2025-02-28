/mob/living/carbon/human/verb/give(var/mob/living/carbon/target in living_mobs(1))
	set category = "IC"
	set name = "Give"

	// TODO :  Change to incapacitated() on merge.
	if(src.stat || src.lying || src.resting || src.handcuffed)
		return
	if(!istype(target) || target.stat || target.lying || target.resting || target.handcuffed || target.client == null)
		return

	var/obj/item/I = src.get_active_hand()
	if(!I)
		I = src.get_inactive_hand()
	if(!I)
		to_chat(src, "<span class='warning'>You don't have anything in your hands to give to \the [target].</span>")
		return

	usr.visible_message(SPAN_NOTICE("\The [usr] holds out \the [I] to \the [target]."), SPAN_NOTICE("You hold out \the [I] to \the [target], waiting for them to accept it."))

	if(tgui_alert(target,"[src] wants to give you \a [I]. Will you accept it?","Item Offer",list("Yes","No")) == "No")
		target.visible_message(SPAN_NOTICE("\The [src] tried to hand \the [I] to \the [target], but \the [target] didn't want it."))
		return

	if(!I) return

	if(!Adjacent(target))
		to_chat(src, "<span class='warning'>You need to stay in reaching distance while giving an object.</span>")
		to_chat(target, "<span class='warning'>\The [src] moved too far away.</span>")
		return

	if(I.loc != src || !src.item_is_in_hands(I))
		to_chat(src, "<span class='warning'>You need to keep the item in your hands.</span>")
		to_chat(target, "<span class='warning'>\The [src] seems to have given up on passing \the [I] to you.</span>")
		return

	if(target.hands_are_full())
		to_chat(target, "<span class='warning'>Your hands are full.</span>")
		to_chat(src, "<span class='warning'>Their hands are full.</span>")
		return

	if(src.unEquip(I))
		target.put_in_hands(I) // If this fails it will just end up on the floor, but that's fitting for things like dionaea.
		target.visible_message("<span class='notice'>\The [src] handed \the [I] to \the [target].</span>")

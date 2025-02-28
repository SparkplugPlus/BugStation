
/*
VVVVVVVV           VVVVVVVV     OOOOOOOOO     RRRRRRRRRRRRRRRRR   EEEEEEEEEEEEEEEEEEEEEE
V::::::V           V::::::V   OO:::::::::OO   R::::::::::::::::R  E::::::::::::::::::::E
V::::::V           V::::::V OO:::::::::::::OO R::::::RRRRRR:::::R E::::::::::::::::::::E
V::::::V           V::::::VO:::::::OOO:::::::ORR:::::R     R:::::REE::::::EEEEEEEEE::::E
 V:::::V           V:::::V O::::::O   O::::::O  R::::R     R:::::R  E:::::E       EEEEEE
  V:::::V         V:::::V  O:::::O     O:::::O  R::::R     R:::::R  E:::::E
   V:::::V       V:::::V   O:::::O     O:::::O  R::::RRRRRR:::::R   E::::::EEEEEEEEEE
    V:::::V     V:::::V    O:::::O     O:::::O  R:::::::::::::RR    E:::::::::::::::E
     V:::::V   V:::::V     O:::::O     O:::::O  R::::RRRRRR:::::R   E:::::::::::::::E
      V:::::V V:::::V      O:::::O     O:::::O  R::::R     R:::::R  E::::::EEEEEEEEEE
       V:::::V:::::V       O:::::O     O:::::O  R::::R     R:::::R  E:::::E
        V:::::::::V        O::::::O   O::::::O  R::::R     R:::::R  E:::::E       EEEEEE
         V:::::::V         O:::::::OOO:::::::ORR:::::R     R:::::REE::::::EEEEEEEE:::::E
          V:::::V           OO:::::::::::::OO R::::::R     R:::::RE::::::::::::::::::::E
           V:::V              OO:::::::::OO   R::::::R     R:::::RE::::::::::::::::::::E
            VVV                 OOOOOOOOO     RRRRRRRR     RRRRRRREEEEEEEEEEEEEEEEEEEEEE

-Aro <3 */

#define VORE_VERSION	2	//This is a Define so you don't have to worry about magic numbers.

//
// Overrides/additions to stock defines go here, as well as hooks. Sort them by
// the object they are overriding. So all /mob/living together, etc.
//
/datum/configuration
	var/items_survive_digestion = TRUE	//For configuring if the important_items survive digestion

//
// The datum type bolted onto normal preferences datums for storing Virgo stuff
//
/client
	var/datum/vore_preferences/prefs_vr

/hook/client_new/proc/add_prefs_vr(client/C)
	C.prefs_vr = new/datum/vore_preferences(C)
	if(C.prefs_vr)
		return TRUE

	return FALSE

/datum/vore_preferences
	//Actual preferences
	var/digestable = TRUE
	var/devourable = TRUE
	var/absorbable = TRUE
	var/feeding = TRUE
	var/can_be_drop_prey = FALSE
	var/can_be_drop_pred = FALSE
	var/allow_spontaneous_tf = FALSE
	var/digest_leave_remains = FALSE
	var/allowmobvore = TRUE
	var/permit_healbelly = TRUE

	var/resizable = TRUE
	var/show_vore_fx = TRUE
	var/step_mechanics_pref = FALSE
	var/pickup_pref = TRUE

	//CHOMP stuff
	var/receive_reagents = FALSE
	var/give_reagents = FALSE
	var/latejoin_vore = FALSE
	var/latejoin_prey = FALSE
	var/autotransferable = TRUE
  //CHOMP stuff end

	var/list/belly_prefs = list()
	var/vore_taste = "nothing in particular"
	var/vore_smell = "nothing in particular"

	//Mechanically required
	var/path
	var/slot
	var/client/client
	var/client_ckey

/datum/vore_preferences/New(client/C)
	if(istype(C))
		client = C
		client_ckey = C.ckey
		load_vore()

//
//	Check if an object is capable of eating things, based on vore_organs
//
/proc/is_vore_predator(mob/living/O)
	if(istype(O,/mob/living))
		if(istype(O,/mob/living/simple_mob)) //CHOMPEdit: On-demand belly loading.
			var/mob/living/simple_mob/SM = O
			if(SM.vore_active && !SM.voremob_loaded)
				SM.voremob_loaded = TRUE
				SM.init_vore()
		if(O.vore_organs.len > 0)
			return TRUE

	return FALSE

//
//	Belly searching for simplifying other procs
//  Mostly redundant now with belly-objects and isbelly(loc)
//
/proc/check_belly(atom/movable/A)
	return isbelly(A.loc)

//
// Save/Load Vore Preferences
//
/datum/vore_preferences/proc/load_path(ckey, slot, filename="character", ext="json")
	if(!ckey || !slot)
		return
	path = "data/player_saves/[copytext(ckey,1,2)]/[ckey]/vore/[filename][slot].[ext]"


/datum/vore_preferences/proc/load_vore()
	if(!client || !client_ckey)
		return FALSE //No client, how can we save?
	if(!client.prefs || !client.prefs.default_slot)
		return FALSE //Need to know what character to load!

	slot = client.prefs.default_slot

	load_path(client_ckey,slot)

	if(!path)
		return FALSE //Path couldn't be set?
	if(!fexists(path)) //Never saved before
		save_vore() //Make the file first
		return TRUE

	var/list/json_from_file = json_decode(file2text(path))
	if(!json_from_file)
		return FALSE //My concern grows

	var/version = json_from_file["version"]
	json_from_file = patch_version(json_from_file,version)

	digestable = json_from_file["digestable"]
	devourable = json_from_file["devourable"]
	resizable = json_from_file["resizable"]
	feeding = json_from_file["feeding"]
	absorbable = json_from_file["absorbable"]
	digest_leave_remains = json_from_file["digest_leave_remains"]
	allowmobvore = json_from_file["allowmobvore"]
	vore_taste = json_from_file["vore_taste"]
	vore_smell = json_from_file["vore_smell"]
	permit_healbelly = json_from_file["permit_healbelly"]
	show_vore_fx = json_from_file["show_vore_fx"]
	can_be_drop_prey = json_from_file["can_be_drop_prey"]
	can_be_drop_pred = json_from_file["can_be_drop_pred"]
	allow_spontaneous_tf = json_from_file["allow_spontaneous_tf"]
	step_mechanics_pref = json_from_file["step_mechanics_pref"]
	pickup_pref = json_from_file["pickup_pref"]
	belly_prefs = json_from_file["belly_prefs"]


	//CHOMP stuff
	latejoin_vore = json_from_file["latejoin_vore"]
	latejoin_prey = json_from_file["latejoin_prey"]
	receive_reagents = json_from_file["receive_reagents"]
	give_reagents = json_from_file["give_reagents"]
	autotransferable = json_from_file["autotransferable"]


	//Quick sanitize
	if(isnull(digestable))
		digestable = TRUE
	if(isnull(devourable))
		devourable = TRUE
	if(isnull(resizable))
		resizable = TRUE
	if(isnull(feeding))
		feeding = TRUE
	if(isnull(absorbable))
		absorbable = TRUE
	if(isnull(digest_leave_remains))
		digest_leave_remains = FALSE
	if(isnull(allowmobvore))
		allowmobvore = TRUE
	if(isnull(permit_healbelly))
		permit_healbelly = TRUE
	if(isnull(show_vore_fx))
		show_vore_fx = TRUE
	if(isnull(can_be_drop_prey))
		can_be_drop_prey = FALSE
	if(isnull(can_be_drop_pred))
		can_be_drop_pred = FALSE
	if(isnull(allow_spontaneous_tf))
		allow_spontaneous_tf = FALSE
	if(isnull(step_mechanics_pref))
		step_mechanics_pref = TRUE
	if(isnull(pickup_pref))
		pickup_pref = TRUE
	if(isnull(belly_prefs))
		belly_prefs = list()

	//CHOMP stuff
	if(isnull(latejoin_vore))
		latejoin_vore = FALSE
	if(isnull(latejoin_prey))
		latejoin_prey = FALSE
	if(isnull(receive_reagents))
		receive_reagents = FALSE
	if(isnull(give_reagents))
		give_reagents = FALSE
	if(isnull(autotransferable))
		autotransferable = TRUE

	return TRUE

/datum/vore_preferences/proc/save_vore()
	if(!path)
		return FALSE

	var/version = VORE_VERSION	//For "good times" use in the future
	var/list/settings_list = list(
			"version"				= version,
			"digestable"			= digestable,
			"devourable"			= devourable,
			"resizable"				= resizable,
			"absorbable"			= absorbable,
			"feeding"				= feeding,
			"digest_leave_remains"	= digest_leave_remains,
			"allowmobvore"			= allowmobvore,
			"vore_taste"			= vore_taste,
			"vore_smell"			= vore_smell,
			"permit_healbelly"		= permit_healbelly,
			"show_vore_fx"			= show_vore_fx,
			"can_be_drop_prey"		= can_be_drop_prey,
			"can_be_drop_pred"		= can_be_drop_pred,
			"latejoin_vore"			= latejoin_vore, //CHOMPedit
			"latejoin_prey"			= latejoin_prey,
			"allow_spontaneous_tf"	= allow_spontaneous_tf,
			"step_mechanics_pref"	= step_mechanics_pref,
			"pickup_pref"			= pickup_pref,
			"belly_prefs"			= belly_prefs,
			"receive_reagents"		= receive_reagents,
			"give_reagents"			= give_reagents,
			"autotransferable"		= autotransferable
		)

	//List to JSON
	var/json_to_file = json_encode(settings_list)
	if(!json_to_file)
		log_debug("Saving: [path] failed jsonencode")
		return FALSE

	//Write it out
	rustg_file_write(json_to_file, path)

	if(!fexists(path))
		log_debug("Saving: [path] failed file write")
		return FALSE

	return TRUE

//Can do conversions here
/datum/vore_preferences/proc/patch_version(var/list/json_from_file,var/version)
	return json_from_file

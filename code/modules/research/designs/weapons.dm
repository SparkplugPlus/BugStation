/datum/design/item/weapon/AssembleDesignName()
	..()
	name = "Weapon prototype ([item_name])"

/datum/design/item/weapon/ammo/AssembleDesignName()
	..()
	name = "Weapon ammo prototype ([item_name])"

/datum/design/item/weapon/AssembleDesignDesc()
	if(!desc)
		if(build_path)
			var/obj/item/I = build_path
			desc = initial(I.desc)
		..()

// Energy weapons

/datum/design/item/weapon/energy/AssembleDesignName()
	..()
	name = "Energy weapon prototype ([item_name])"

/datum/design/item/weapon/energy/stunrevolver
	id = "stunrevolver"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_POWER = 2)
	materials = list(MAT_STEEL = 4000)
	build_path = /obj/item/weapon/gun/energy/stunrevolver
	sort_string = "MAAAA"

/datum/design/item/weapon/energy/nuclear_gun
	id = "nuclear_gun"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 5, TECH_POWER = 3)
	materials = list(MAT_STEEL = 5000, MAT_GLASS = 1000, "uranium" = 500)
	build_path = /obj/item/weapon/gun/energy/gun/nuclear
	sort_string = "MAAAB"

/datum/design/item/weapon/energy/phoronpistol
	id = "ppistol"
	req_tech = list(TECH_COMBAT = 5, TECH_PHORON = 4)
	materials = list(MAT_STEEL = 5000, MAT_GLASS = 1000, "phoron" = 3000)
	build_path = /obj/item/weapon/gun/energy/toxgun
	sort_string = "MAAAC"

/datum/design/item/weapon/energy/lasercannon
	desc = "The lasing medium of this prototype is enclosed in a tube lined with uranium-235 and subjected to high neutron flux in a nuclear reactor core."
	id = "lasercannon"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	materials = list(MAT_STEEL = 10000, MAT_GLASS = 1000, "diamond" = 2000)
	build_path = /obj/item/weapon/gun/energy/lasercannon
	sort_string = "MAAAD"

/datum/design/item/weapon/energy/decloner
	id = "decloner"
	req_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 7, TECH_BIO = 5, TECH_POWER = 6)
	materials = list("gold" = 5000,"uranium" = 10000)
	build_path = /obj/item/weapon/gun/energy/decloner
	sort_string = "MAAAE"

/datum/design/item/weapon/energy/temp_gun
	desc = "A gun that shoots high-powered glass-encased energy temperature bullets."
	id = "temp_gun"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 4, TECH_POWER = 3, TECH_MAGNET = 2)
	materials = list(MAT_STEEL = 5000, MAT_GLASS = 500, "silver" = 3000)
	build_path = /obj/item/weapon/gun/energy/temperature
	sort_string = "MAAAF"

/datum/design/item/weapon/energy/flora_gun
	id = "flora_gun"
	req_tech = list(TECH_MATERIAL = 2, TECH_BIO = 3, TECH_POWER = 3)
	materials = list(MAT_STEEL = 2000, MAT_GLASS = 500, "uranium" = 500)
	build_path = /obj/item/weapon/gun/energy/floragun
	sort_string = "MAAAG"

/datum/design/item/weapon/energy/vinstunrevolver
	id = "vinstunrevolver"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_POWER = 2)
	materials = list(MAT_STEEL = 4000)
	build_path = /obj/item/weapon/gun/energy/stunrevolver/vintage
	sort_string = "MAAAH"

// Ballistic weapons

/datum/design/item/weapon/ballistic/AssembleDesignName()
	..()
	name = "Ballistic weapon prototype ([item_name])"

/datum/design/item/weapon/ballistic/advanced_smg
	id = "smg"
	desc = "An advanced 9mm SMG with a reflective laser optic."
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3)
	materials = list(MAT_STEEL = 8000, "silver" = 2000, "diamond" = 1000)
	build_path = /obj/item/weapon/gun/projectile/automatic/advanced_smg
	sort_string = "MABAA"

// Ballistic ammo

/datum/design/item/weapon/ballistic/ammo/AssembleDesignName()
	..()
	name = "Ballistic weapon ammo prototype ([name])"

/datum/design/item/weapon/ballistic/ammo/ammo_9mmAdvanced
	name = "9mm magazine"
	id = "ammo_9mm"
	desc = "A 21 round magazine for an advanced 9mm SMG."
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3)
	materials = list(MAT_STEEL = 3750, "silver" = 100) // Requires silver for proprietary magazines! Or something.
	build_path = /obj/item/ammo_magazine/m9mmAdvanced
	sort_string = "MABBA"

/datum/design/item/weapon/ballistic/ammo/stunshell
	name = "stun shells"
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3)
	materials = list(MAT_STEEL = 4000)
	build_path = /obj/item/weapon/storage/box/stunshells
	sort_string = "MABBB"

/datum/design/item/weapon/ballistic/ammo/empshell
	name = "emp shells"
	desc = "An electromagnetic shell for a shotgun."
	id = "empshell"
	req_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 3)
	materials = list(MAT_STEEL = 4000, MAT_URANIUM = 1000)
	build_path = /obj/item/weapon/storage/box/empshells
	sort_string = "MABBC"

// Phase weapons

/datum/design/item/weapon/phase/AssembleDesignName()
	..()
	name = "Phase weapon prototype ([item_name])"

/* //VOREStation Removal Start // Chomp Edit : uncomment those weapons //CHOMP Edit: Comment again, move to weapons_ch because they have weapons locks now.
/datum/design/item/weapon/phase/phase_pistol
	id = "phasepistol"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2, TECH_POWER = 2)
	materials = list(MAT_STEEL = 4000)
	build_path = /obj/item/weapon/gun/energy/phasegun/pistol
	sort_string = "MACAA"

/datum/design/item/weapon/phase/phase_carbine
	id = "phasecarbine"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2, TECH_POWER = 2)
	materials = list(MAT_STEEL = 6000, MAT_GLASS = 1500)
	build_path = /obj/item/weapon/gun/energy/phasegun
	sort_string = "MACAB"

/datum/design/item/weapon/phase/phase_rifle
	id = "phaserifle"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	materials = list(MAT_STEEL = 7000, MAT_GLASS = 2000, "silver" = 500)
	build_path = /obj/item/weapon/gun/energy/phasegun/rifle
	sort_string = "MACAC"

/datum/design/item/weapon/phase/phase_cannon
	id = "phasecannon"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4, TECH_POWER = 4)
	materials = list(MAT_STEELL = 10000, MAT_GLASS = 2000, "silver" = 1000, "diamond" = 750)
	build_path = /obj/item/weapon/gun/energy/phasegun/cannon
	sort_string = "MACAD"
*/ //VOREStation Removal End // Chomp Edit : uncomment those weapons

// Other weapons

/datum/design/item/weapon/rapidsyringe
	id = "rapidsyringe"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3, TECH_ENGINEERING = 3, TECH_BIO = 2)
	materials = list(MAT_STEEL = 5000, MAT_GLASS = 1000)
	build_path = /obj/item/weapon/gun/launcher/syringe/rapid
	sort_string = "MADAA"

/datum/design/item/weapon/dartgun
	desc = "A gun that fires small hollow chemical-payload darts."
	id = "dartgun_r"
	req_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 4, TECH_BIO = 4, TECH_MAGNET = 3, TECH_ILLEGAL = 1)
	materials = list(MAT_STEEL = 5000, "gold" = 5000, "silver" = 2500, MAT_GLASS = 750)
	build_path = /obj/item/weapon/gun/projectile/dartgun/research
	sort_string = "MADAB"

/datum/design/item/weapon/chemsprayer
	desc = "An advanced chem spraying device."
	id = "chemsprayer"
	req_tech = list(TECH_MATERIAL = 3, TECH_ENGINEERING = 3, TECH_BIO = 2)
	materials = list(MAT_STEEL = 5000, MAT_GLASS = 1000)
	build_path = /obj/item/weapon/reagent_containers/spray/chemsprayer
	sort_string = "MADAC"

/datum/design/item/weapon/fuelrod
	id = "fuelrod_gun"
	req_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 4, TECH_PHORON = 4, TECH_ILLEGAL = 5, TECH_MAGNET = 5)
	materials = list(MAT_STEEL = 10000, MAT_GLASS = 2000, "gold" = 500, "silver" = 500, "uranium" = 1000, "phoron" = 3000, "diamond" = 1000)
	build_path = /obj/item/weapon/gun/magnetic/fuelrod
	sort_string = "MADAD"

// Ammo for those

/datum/design/item/weapon/ammo/dartgunmag_small
	id = "dartgun_mag_s"
	req_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 2, TECH_BIO = 2, TECH_MAGNET = 1, TECH_ILLEGAL = 1)
	materials = list(MAT_STEEL = 300, "gold" = 100, "silver" = 100, MAT_GLASS = 300)
	build_path = /obj/item/ammo_magazine/chemdart/small
	sort_string = "MADBA"

/datum/design/item/weapon/ammo/dartgun_ammo_small
	id = "dartgun_ammo_s"
	req_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 2, TECH_BIO = 2, TECH_MAGNET = 1, TECH_ILLEGAL = 1)
	materials = list(MAT_STEEL = 50, "gold" = 30, "silver" = 30, MAT_GLASS = 50)
	build_path = /obj/item/ammo_casing/chemdart/small
	sort_string = "MADBB"

/datum/design/item/weapon/ammo/dartgunmag_med
	id = "dartgun_mag_m"
	req_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 2, TECH_BIO = 2, TECH_MAGNET = 1, TECH_ILLEGAL = 1)
	materials = list(MAT_STEEL = 500, "gold" = 150, "silver" = 150, "diamond" = 200, MAT_GLASS = 400)
	build_path = /obj/item/ammo_magazine/chemdart
	sort_string = "MADBC"

/datum/design/item/weapon/ammo/dartgun_ammo_med
	id = "dartgun_ammo_m"
	req_tech = list(TECH_COMBAT = 7, TECH_MATERIAL = 2, TECH_BIO = 2, TECH_MAGNET = 1, TECH_ILLEGAL = 1)
	materials = list(MAT_STEEL = 80, "gold" = 40, "silver" = 40, MAT_GLASS = 60)
	build_path = /obj/item/ammo_casing/chemdart
	sort_string = "MADBD"

/datum/design/item/weapon/ammo/flechette
	id = "magnetic_ammo"
	req_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 4, TECH_MAGNET = 4)
	materials = list(MAT_STEEL = 500, "gold" = 300, MAT_GLASS = 150, MAT_PHORON = 100)
	build_path = /obj/item/weapon/magnetic_ammo
	sort_string = "MADBE"

// Melee weapons

/datum/design/item/weapon/melee/AssembleDesignName()
	..()
	name = "Melee weapon prototype ([item_name])"

/datum/design/item/weapon/melee/esword
	name = "Portable Energy Blade"
	id = "chargesword"
	req_tech = list(TECH_COMBAT = 6, TECH_MAGNET = 4, TECH_ENGINEERING = 5, TECH_ILLEGAL = 4, TECH_ARCANE = 1)
	materials = list(MAT_PLASTEEL = 3500, MAT_GLASS = 1000, MAT_LEAD = 2250, MAT_METALHYDROGEN = 500)
	build_path = /obj/item/weapon/melee/energy/sword/charge
	sort_string = "MBAAA"

/datum/design/item/weapon/melee/eaxe
	name = "Energy Axe"
	id = "chargeaxe"
	req_tech = list(TECH_COMBAT = 6, TECH_MAGNET = 5, TECH_ENGINEERING = 4, TECH_ILLEGAL = 4)
	materials = list(MAT_PLASTEEL = 3500, MAT_OSMIUM = 2000, MAT_LEAD = 2000, MAT_METALHYDROGEN = 500)
	build_path = /obj/item/weapon/melee/energy/axe/charge
	sort_string = "MBAAB"

// Grenade stuff
/datum/design/item/weapon/grenade/AssembleDesignName()
	..()
	name = "Grenade casing prototype ([item_name])"

/datum/design/item/weapon/grenade/large_grenade
	id = "large_Grenade"
	req_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2)
	materials = list(MAT_STEEL = 3000)
	build_path = /obj/item/weapon/grenade/chem_grenade/large
	sort_string = "MCAAA"

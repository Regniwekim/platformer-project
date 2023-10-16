if (part_system_exists(global.bg_particle_system))
{
	part_emitter_destroy_all(global.bg_particle_system);
	//part_system_destroy(global.bg_particle_system);	
}

if (part_system_exists(global.mg_particle_system)) {
	part_emitter_destroy_all(global.mg_particle_system);
	//part_system_destroy(global.mg_particle_system);	
}
	
if (part_system_exists(global.fg_particle_system)){
	part_emitter_destroy_all(global.fg_particle_system);
	//part_system_destroy(global.fg_particle_system);	
}
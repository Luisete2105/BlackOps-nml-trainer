#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

#using_animtree( "generic_human" );

init()
{
    //return; //uncomment the return if you want to disable the full script
    level endon( "game_ended" );

    //Check in case the script loads when it shouldnt
    if ( GetDvar( "zombiemode" ) != "1" ) return;
    if(level.script != "zombie_moon") return;

    level thread onplayerconnect();

    level thread change_nml_funciton();
	level thread Change_Perks();
    level thread create_huds();
    level thread luisete_credits();

}


onplayerconnect()
{
    level endon( "game_ended" );

    for (;;)
	{
        level waittill( "connected", player ); 
	    player thread onplayerspawned();

		//if you want infinite ammo and godmode uncomment the line below
        //player thread infgod();

	}
}

onplayerspawned()
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    for(;;)
    {
        self waittill( "spawned_player" );
        self iPrintLn( "Welcome ^6"+self.playername+"^7 to ^1Lui^3se^1te's^7 NML trainer!" );
    }

}

// Starts the HuDs and timer
create_huds(){

    level.general_timer = NewHudElem();
        level.general_timer.hidewheninmenu = true;
	    level.general_timer.horzAlign = "left";
	    level.general_timer.vertAlign = "top";
	    level.general_timer.alignX = "left";
	    level.general_timer.alignY = "top";
	    level.general_timer.x = 10;
	    level.general_timer.y = 25;
	    level.general_timer.foreground = true;
	    level.general_timer.font = "default";
	    level.general_timer.fontScale = 1.5;
	    level.general_timer.color = ( 1.0, 1.0, 1.0 );        
	    level.general_timer.alpha = 1.0;
    level.general_timer.label = "^7General Time: ^3";

    level.dev1 = NewHudElem();
        level.dev1.hidewheninmenu = true;
	    level.dev1.horzAlign = "left";
	    level.dev1.vertAlign = "top";
	    level.dev1.alignX = "left";
	    level.dev1.alignY = "top";
	    level.dev1.x = 10;
	    level.dev1.y = 45;
	    level.dev1.foreground = true;
	    level.dev1.font = "default";
	    level.dev1.fontScale = 1.5;
	    level.dev1.color = ( 1.0, 1.0, 1.0 );        
	    level.dev1.alpha = 1.0;
    level.dev1.label = "^7Mode: ^5";

    level.dev2 = NewHudElem();
        level.dev2.hidewheninmenu = true;
	    level.dev2.horzAlign = "left";
	    level.dev2.vertAlign = "top";
	    level.dev2.alignX = "left";
	    level.dev2.alignY = "top";
	    level.dev2.x = 10;
	    level.dev2.y = 65;
	    level.dev2.foreground = true;
	    level.dev2.font = "default";
	    level.dev2.fontScale = 1.5;
	    level.dev2.color = ( 1.0, 1.0, 1.0 );        
	    level.dev2.alpha = 1.0;
    level.dev2.label = "^7Next mode in: ^3";

    level.dev3 = NewHudElem();
        level.dev3.hidewheninmenu = true;
	    level.dev3.horzAlign = "left";
	    level.dev3.vertAlign = "top";
	    level.dev3.alignX = "left";
	    level.dev3.alignY = "top";
	    level.dev3.x = 10;
	    level.dev3.y = 85;
	    level.dev3.foreground = true;
	    level.dev3.font = "default";
	    level.dev3.fontScale = 1.5;
	    level.dev3.color = ( 1.0, 1.0, 1.0 );        
	    level.dev3.alpha = 1.0;
    level.dev3.label = "^7Area: ^5";

    level.zombie_counter = NewHudElem();
        level.zombie_counter.hidewheninmenu = true;
	    level.zombie_counter.horzAlign = "left";
	    level.zombie_counter.vertAlign = "top";
	    level.zombie_counter.alignX = "left";
	    level.zombie_counter.alignY = "top";
	    level.zombie_counter.x = 10;
	    level.zombie_counter.y = 105;
	    level.zombie_counter.foreground = true;
	    level.zombie_counter.font = "default";
	    level.zombie_counter.fontScale = 1.5;
	    level.zombie_counter.color = ( 1.0, 1.0, 1.0 );        
	    level.zombie_counter.alpha = 1.0;
    level.zombie_counter.label = "^7Zombies Alive: ^1";

	level.dogs_spawns = NewHudElem();
        level.dogs_spawns.hidewheninmenu = true;
	    level.dogs_spawns.horzAlign = "left";
	    level.dogs_spawns.vertAlign = "top";
	    level.dogs_spawns.alignX = "left";
	    level.dogs_spawns.alignY = "top";
	    level.dogs_spawns.x = 10;
	    level.dogs_spawns.y = 125;
	    level.dogs_spawns.foreground = true;
	    level.dogs_spawns.font = "default";
	    level.dogs_spawns.fontScale = 1.5;
	    level.dogs_spawns.color = ( 1.0, 1.0, 1.0 );        
	    level.dogs_spawns.alpha = 1.0;
    level.dogs_spawns.label = "^7Dogs can spawn: ^5";

	level.sally_shoots = NewHudElem();
        level.sally_shoots.hidewheninmenu = true;
	    level.sally_shoots.horzAlign = "left";
	    level.sally_shoots.vertAlign = "top";
	    level.sally_shoots.alignX = "left";
	    level.sally_shoots.alignY = "top";
	    level.sally_shoots.x = 10;
	    level.sally_shoots.y = 145;
	    level.sally_shoots.foreground = true;
	    level.sally_shoots.font = "default";
	    level.sally_shoots.fontScale = 1.5;
	    level.sally_shoots.color = ( 1.0, 1.0, 1.0 );        
	    level.sally_shoots.alpha = 1.0;
    level.sally_shoots.label = "^7Sally shoots: ^5";

    level.zombie_counter thread zombie_counter();

    flag_wait( "starting final intro screen fadeout" );
    wait 2.15;

	level.general_timer setTenthsTimerUp(0.05);

}

// Credits scripts
luisete_credits(){

    level endon( "game_ended" );

    flag_wait( "starting final intro screen fadeout" );
    wait 7;

    if(!isdefined(level.luisete_credits)){

	    level.luisete_credits = newHudElem();
            level.luisete_credits.alignx = "center";
            level.luisete_credits.aligny = "top";
            level.luisete_credits.horzalign = "user_center";
            level.luisete_credits.vertalign = "user_top";
            //level.luisete_credits.x = -350;
            level.luisete_credits.x = 0;
            level.luisete_credits.y = 5;
            level.luisete_credits.fontscale = 2;
            level.luisete_credits.alpha = 1;
            level.luisete_credits.color = (1,1,1);
            level.luisete_credits.hidewheninmenu = 1;
        level.luisete_credits.label = "NML Trainer V1 made by ^1Luis^3ete^12105^7! link on ^0Github^7 and ^6Discord^7 for support";

        level thread flashing();
    }

}

flashing(){
    level endon( "game_ended" );

    for(;;){

        level.luisete_credits fadeOverTime(7);
        level.luisete_credits.alpha = 0;

        wait 7;

        level.luisete_credits fadeOverTime(7);
        level.luisete_credits.alpha = 1;

        wait 7;
    }

}


//Custom utility scripts
zombie_counter(){
    level endon( "game_ended" );

    for(;;){
        wait 0.05;
        //self setValue( GetAiSpeciesArray( "axis", "all" ).size );
		self setText( GetAiSpeciesArray( "axis", "all" ).size+" /20");
        
    }

}

infgod(){
    level endon( "game_ended" );
    self endon( "disconnect" );

    for(;;){
        wait 1;
        self enableInvulnerability();
        self GiveMaxAmmo( self getCurrentWeapon() );
        self GiveMaxAmmo( self GetCurrentOffHand() );
        self.score = 7777777;
    }

}

get_sally_shoots(){

	if(level.zombie_health % 950) extra = 1;
	else extra = 0;


	return extra + int(level.zombie_health / 950);

}


//Overrides original nml function to use mine and be able to output info
change_nml_funciton(){
    while(!isDefined(level.round_spawn_func)) wait 0.05;
    wait 0.5;
    level.round_spawn_func = ::nml_round_manager;
}

//Copy of 3arc's nml function to debug information
nml_round_manager()
{
	level endon("restart_round");

	// *** WHAT IS THIS? *** 
	level.dog_targets = getplayers();
	for( i=0; i<level.dog_targets.size; i++ )
	{
		level.dog_targets[i].hunted_by = 0;
	}
	
	level.nml_start_time = GetTime();
	
	// Time when dog spawns start in NML
	dog_round_start_time = 2000;
	dog_can_spawn_time = -1000*10;
	dog_difficulty_min_time = 3000;
	dog_difficulty_max_time = 9500;
	
	// Attack Waves setup
	wave_1st_attack_time = (1000 * 25);//(1000 * 40);
	prepare_attack_time = (1000 * 2.1);
	wave_attack_time = (1000 * 35);		// 40
	cooldown_time = (1000 * 16);		// 25
	next_attack_time = (1000 * 26);		// 32

	max_zombies = 20;
	
	next_round_time = level.nml_start_time + wave_1st_attack_time;
	mode = "normal_spawning";
	
	area = 1;
	
	// Once some AI appear, make sure the round never ends
	level thread nml_round_never_ends();

	level.dev2 setTimer( (next_round_time-GetTime())/1000 );
	level.dogs_spawns setText( "Cant spawn dogs during first 30s" );
	

	while( 1 )
	{
		current_time = GetTime();
		
		wait_override = 0.0;


		zombies = GetAiSpeciesArray( "axis", "all" );
		
		while( zombies.size >= max_zombies )
		{
			level.dogs_spawns setText("Zombies cap hit!");
			level.sally_shoots setValue( get_sally_shoots() );
			zombies = GetAiSpeciesArray( "axis", "all" );
			wait( 0.5 );
		}

		level.sally_shoots setValue( get_sally_shoots() );

        level.dev1 setText(mode);

		switch( mode )
		{
            

			// Default Ambient Zombies
			case "normal_spawning":

                level.dev3 setText("Everywhere");
				
				if(level.initial_spawn == true)
				{
					spawn_a_zombie( 10, "nml_zone_spawners", 0.01 );
				}
				else
				{	
					ai = spawn_a_zombie( max_zombies, "nml_zone_spawners", 0.01 );
					if( isdefined (ai) )
					{
						ai.zombie_move_speed = "sprint";
						
						//Normal sprint (1,4)
						//Super-sprint (5,6)
						
						if(flag("start_supersprint"))
						{
							theanim = "sprint" + randomintrange(1, 6);
						}	
						else
						{
							theanim = "sprint" + randomintrange(1, 4);
						}	 
						
						if( IsDefined( ai.pre_black_hole_bomb_run_combatanim ) )
						{
							ai.pre_black_hole_bomb_run_combatanim = theanim;
						}
						else
						{
							ai set_run_anim( theanim );                         
							ai.run_combatanim = level.scr_anim[ai.animname][theanim];
							ai.walk_combatanim = level.scr_anim[ai.animname][theanim];
							ai.crouchRunAnim = level.scr_anim[ai.animname][theanim];
							ai.crouchrun_combatanim = level.scr_anim[ai.animname][theanim];
							ai.needs_run_update = true;			
						}

					}
				}
				
				// Check for Spawner Wave to Start
				if( current_time > next_round_time )
				{
					next_round_time = current_time + prepare_attack_time;
					level.dev2 setTimer( prepare_attack_time/1000 );
					mode = "preparing_spawn_wave";
					level thread screen_shake_manager( next_round_time );
				}
			break;


			// Shake screen, start existing zombies running, then start a wave
			case "preparing_spawn_wave":
				zombies = GetAiSpeciesArray( "axis" );
				for( i=0; i < zombies.size; i++ )
				{
					if( zombies[i].has_legs && zombies[i].animname == "zombie") // make sure not a dog.
					{
						zombies[i].zombie_move_speed = "sprint";
						
						//Normal sprint (1,4)
						//Super-sprint (5,6)
						if(flag("start_supersprint"))
						{
							theanim = "sprint" + randomintrange(1, 6);
						}	
						else
						{
							theanim = "sprint" + randomintrange(1, 4);
						}	 
												
						level.initial_spawn = false;
						level notify( "start_nml_ramp" );
						
						if( IsDefined( zombies[i].pre_black_hole_bomb_run_combatanim ) )
						{
							zombies[i].pre_black_hole_bomb_run_combatanim = theanim;
						}
						else
						{
							zombies[i] set_run_anim( theanim );                         
							zombies[i].run_combatanim = level.scr_anim[zombies[i].animname][theanim];
							zombies[i].walk_combatanim = level.scr_anim[zombies[i].animname][theanim];
							zombies[i].crouchRunAnim = level.scr_anim[zombies[i].animname][theanim];
							zombies[i].crouchrun_combatanim = level.scr_anim[zombies[i].animname][theanim];
							zombies[i].needs_run_update = true;
						}
								

					}
				}
				
				if( current_time > next_round_time )
				{
					level notify( "nml_attack_wave" );
					mode = "spawn_wave_active";
					
					if( area == 1 )
					{
						area = 2;
						level thread nml_wave_attack( max_zombies, "nml_area2_spawners" );
                        level.dev3 setText("Right side spawns");
					}
					else
					{
						area = 1;
						level thread nml_wave_attack( max_zombies, "nml_area1_spawners" );
                        level.dev3 setText("Left side spawns");
					}
									
					next_round_time = current_time + wave_attack_time;
					level.dev2 setTimer( wave_attack_time/1000 );
				}
				wait_override = 0.1;
			break;


			// Attack wave in progress
			// Occasionally spawn a zombie
			case "spawn_wave_active":
				if( current_time < next_round_time )
				{
					if( randomfloatrange(0, 1) < 0.05 )
					{
						ai = spawn_a_zombie( max_zombies, "nml_zone_spawners", 0.01 );
						if( isdefined (ai) )
						{
							ai.ignore_gravity = true;
							ai.zombie_move_speed = "sprint";
							
							//Normal sprint (1,4)
							//Super-sprint (5,6)
							if(flag("start_supersprint"))
							{
								theanim = "sprint" + randomintrange(1, 6);
							}	
							else
							{
								theanim = "sprint" + randomintrange(1, 4);
							}	 
							
							if( IsDefined( ai.pre_black_hole_bomb_run_combatanim ) )
							{
								ai.pre_black_hole_bomb_run_combatanim = theanim;
							}
							else
							{
								ai set_run_anim( theanim );                         
								ai.run_combatanim = level.scr_anim[ai.animname][theanim];
								ai.walk_combatanim = level.scr_anim[ai.animname][theanim];
								ai.crouchRunAnim = level.scr_anim[ai.animname][theanim];
								ai.crouchrun_combatanim = level.scr_anim[ai.animname][theanim];
								ai.needs_run_update = true;			
							}
															
						}			
					}
				}
				else
				{
					level notify("wave_attack_finished");
					mode = "wave_finished_cooldown";
					next_round_time = current_time + cooldown_time;
					level.dev2 setTimer( cooldown_time/1000 );
				}
			break;
			

			// Round over, cooldown period
			case "wave_finished_cooldown":
			
				if( current_time > next_round_time )
				{
					next_round_time = current_time + next_attack_time;
					level.dev2 setTimer( next_attack_time/1000 );
					mode = "normal_spawning";
				}
				
				wait_override = 0.01;
			break;


		}




		num_dog_targets = 0;
		if( (current_time - level.nml_start_time) > dog_round_start_time )
		{
			skip_dogs = 0;
			
			// *** DIFFICULTY FOR 1 Player ***
			players = get_players();
			if( players.size <= 1 )
			{
				dt = current_time - dog_can_spawn_time;
				if( dt < 0 )
				{
					//iPrintLn( "DOG SKIP" );
					skip_dogs = 1;
				}
				else
				{
					dog_can_spawn_time = current_time + randomfloatrange(dog_difficulty_min_time, dog_difficulty_max_time);
				}
			}
			
			if( mode == "preparing_spawn_wave" )
			{
				skip_dogs = 1;
			}

			if( !skip_dogs && level.nml_dogs_enabled == true)
			{
				//level.dogs_spawns setText("Yes");
				level.dogs_spawns setTimer( (dog_can_spawn_time-current_time)/1000);

				num_dog_targets = level.num_nml_dog_targets;
				//iPrintLn( "Num Dog Targets: " + num_dog_targets );
		
				if( num_dog_targets )
				{
					// Send 2 dogs after each player
					dogs = getaispeciesarray( "axis", "dog" );
					num_dog_targets *= 2;
						
					if( dogs.size < num_dog_targets )
					{
						//IPrintLnBold("Spawn a dog");
						ai = maps\_zombiemode_ai_dogs::special_dog_spawn();
						
						//set their health to current level immediately.
						zombie_dogs = GetAISpeciesArray("axis","zombie_dog");
						if(IsDefined(zombie_dogs))
						{
							for( i=0; i<zombie_dogs.size; i++ )
							{
								zombie_dogs[i].maxhealth = int( level.nml_dog_health);
								zombie_dogs[i].health = int( level.nml_dog_health );
							}	
						}
					}
				}
			}else{
				if( !level.nml_dogs_enabled  ) level.dogs_spawns setText( "Cant spawn dogs during first 30s" );
				else if( mode == "preparing_spawn_wave" ) level.dogs_spawns setText( "No because its preparing wave" );
				else if(!level.num_nml_dog_targets) level.dogs_spawns setText( "All players are on the teleporter" );
				else level.dogs_spawns setTimer( (dog_can_spawn_time-current_time)/1000 );
				//else level.dogs_spawns setText("No");
			}
		}
	
		if( wait_override != 0.0 )
		{
			wait( wait_override );
		}
		else
		{
			wait randomfloatrange( 0.1, 0.8 );
		}
	}
}

//3arc scripts
nml_round_never_ends()
{
	wait( 2 );
	
	level endon( "restart_round" );

	while( flag("enter_nml") )
	{
		zombies = GetAiSpeciesArray( "axis", "all" );
		if( zombies.size >= 2 )
		{
			// This ensures the round will never end
			level.zombie_total = 100;
			return;
		}
		wait( 1 );
	}
}

screen_shake_manager( next_round_time )
{
	level endon( "nml_attack_wave" );
	level endon("restart_round");

	time = 0;
	while( time < next_round_time )
	{
		level thread attack_wave_screen_shake();
		wait_time = randomfloatrange(0.25, 0.35);
		wait( wait_time );
		time = gettime();
	}
}

attack_wave_screen_shake()
{

	num_valid = 0;
	players = get_players();
	pos = ( 0, 0, 0 );
	
	for( i=0; i<players.size; i++ )
	{
		player = players[i];
		if( is_player_valid(player) )
		{
			pos += player.origin;
			num_valid ++;
		}
	}
	
	if( !num_valid )
	{
		return;
	}
	
	shake_position = ( (pos[0]/num_valid), (pos[1]/num_valid), (pos[2]/num_valid) );



	thread rumble_all_players( "damage_heavy" );
	
	

	
	scale = 0.4;
	duration = 1.0;
	radius = 42 * 400;
	
	//earthquake( scale, duration, shake_position, radius );
}

rumble_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range)
{
	players = get_players();
	
	for (i = 0; i < players.size; i++)
	{
		if (isdefined (high_rumble_range) && isdefined (low_rumble_range) && isdefined(rumble_org))
		{
			if (distance (players[i].origin, rumble_org) < high_rumble_range)
			{
				players[i] playrumbleonentity(high_rumble_string);
			}
			else if (distance (players[i].origin, rumble_org) < low_rumble_range)
			{
				players[i] playrumbleonentity(low_rumble_string);
			}
		}
		else
		{
			players[i] playrumbleonentity(high_rumble_string);
		}
	}
}

spawn_a_zombie( max_zombies, spawner_zone_name, wait_delay )
{
	// Don't spawn a new zombie if we are at the limit
	zombies = getaispeciesarray( "axis" );
	if( zombies.size >= max_zombies )
	{
		return( undefined );
	}

	zombie_spawners = getentarray( spawner_zone_name, "targetname" );

	spawn_point = zombie_spawners[RandomInt( zombie_spawners.size )]; 

	ai = spawn_zombie( spawn_point ); 
	if( IsDefined( ai ) )
	{	
		//ai thread maps\_zombiemode::round_spawn_failsafe();
		ai.zone_name = spawner_zone_name;

		if ( is_true( level.mp_side_step ) )
		{
			ai.shouldSideStepFunc = ::nml_shouldSideStep;
			ai.sideStepAnims = [];
			
			ai.sideStepAnims["step_left"]	= array( %ai_zombie_MP_sidestep_left_a, %ai_zombie_MP_sidestep_left_b );
			ai.sideStepAnims["step_right"]	= array( %ai_zombie_MP_sidestep_right_a, %ai_zombie_MP_sidestep_right_b );
		}
	}
	
	wait( wait_delay );
	wait_network_frame();
	
	return( ai );
}

nml_shouldSideStep()
{
	if ( self nml_canSideStep() )
	{
		return "step";
	}

	return "none";
}

nml_canSideStep()
{
	if( GetTime() - self.a.lastSideStepTime < level.NML_REACTION_INTERVAL )
		return false;
	
	if( !IsDefined(self.enemy) )
		return false;
	
	if( self.a.pose != "stand" )
		return false;
	
	distSqFromEnemy = DistanceSquared(self.origin, self.enemy.origin);

	// don't do it too close to the enemy
	if( distSqFromEnemy < level.NML_MIN_REACTION_DIST_SQ )
	{
		return false;
	}

	// don't do it too far from the enemy
	if( distSqFromEnemy > level.NML_MAX_REACTION_DIST_SQ )
	{
		return false;
	}

	// don't do it if not path or too close to destination
	if( !IsDefined(self.pathgoalpos) || DistanceSquared(self.origin, self.pathgoalpos) < level.NML_MIN_REACTION_DIST_SQ )
	{
		return false;
	}

	// make sure the AI's running straight
	if( abs(self GetMotionAngle()) > 15 )
	{
		return false;
	}

	return true;
}

nml_wave_attack( num_in_wave, spawner_name )
{
	level endon("wave_attack_finished");
	level endon("restart_round");

	while( 1 )
	{
		zombies = GetAiSpeciesArray( "axis", "all" );
		if( zombies.size < num_in_wave )
		{
			ai = spawn_a_zombie( num_in_wave, spawner_name, 0.01 );
			if( isdefined (ai) )
			{
				ai.ignore_gravity = true;
				ai.zombie_move_speed = "sprint";
				
				//Normal sprint (1,4)
				//Super-sprint (5,6)
				if(flag("start_supersprint"))
				{
					theanim = "sprint" + randomintrange(1, 6);
				}	
				else
				{
					theanim = "sprint" + randomintrange(1, 4);
				}
					 						
				if( IsDefined( ai.pre_black_hole_bomb_run_combatanim ) )
				{
					ai.pre_black_hole_bomb_run_combatanim = theanim;
				}
				else
				{
					ai set_run_anim( theanim );                         
					ai.run_combatanim = level.scr_anim[ai.animname][theanim];
					ai.walk_combatanim = level.scr_anim[ai.animname][theanim];
					ai.crouchRunAnim = level.scr_anim[ai.animname][theanim];
					ai.crouchrun_combatanim = level.scr_anim[ai.animname][theanim];
					ai.needs_run_update = true;		
				}
	
			}
		}

		wait randomfloatrange( 0.3, 1.0 );
	}
}


//Scripts to make sure we always get jugg
Change_Perks()
{

	while(!isDefined(level.speed_cola_ents) || !isDefined(level.jugg_ents)) wait 0.05;
	wait 0.5;
	level thread perk_machine_arrival_update();


}



//3arc scripts
perk_machine_arrival_update() //Only needed to modify this one
{
	top_height = 1200;		// 700
	fall_time = 4;
	num_model_swaps = 20;

	//perk_index = randomintrange( 0, 2 );
	perk_index = 0; // 0 = jugg | 1 = speed

	// Flash an effect to the perk machines destination
	ent = level.speed_cola_ents[0];
	level thread perk_arrive_fx( ent.origin );

	//while( 1 )
	//{
		// Move the perk machines high in the sky
		//	move_perk( top_height, 0.01, 0.001 ); // we cancel the move because its done by the original script
		wait( 0.3 );
		//	perk_machines_hide( 0, 0, true ); // we cancel the hide because its done by the original script
		wait( 1 );

		// Start the machines falling
		//	move_perk( top_height*-1, fall_time, 1.5 ); // we cancel the move because its done by the original script

		// Swap visible Perk as we fall
		wait_step = fall_time / num_model_swaps;
		for( i=0; i<num_model_swaps; i++ )
		{
			perk_machine_show_selected( perk_index, true ); // perk_index = 0 para jug
			wait( wait_step );
			
			perk_index++;
			if( perk_index > 1 )
			{
				perk_index = 0;
			}
		}

		// Make sure we don't get a perk machine duplicate next time we visit
		while( perk_index == level.last_perk_index )
		{
			perk_index = randomintrange( 0, 2 );
		}
		
		level.last_perk_index = perk_index;
		wait 0.5;
		perk_machine_show_selected( perk_index, false );
	
	//}
}

perk_arrive_fx( pos )
{
	wait( 0.15 );

	Playfx( level._effect["lightning_dog_spawn"], pos );
	playsoundatposition( "zmb_hellhound_spawn", pos );
	playsoundatposition( "zmb_hellhound_bolt", pos );
		
	wait( 1.1 );
	Playfx( level._effect["lightning_dog_spawn"], pos );
	playsoundatposition( "zmb_hellhound_spawn", pos );
	playsoundatposition( "zmb_hellhound_bolt", pos );
}

move_perk( dist, time, accel )
{


	ent = level.speed_cola_ents[0];
	pos = (ent.origin[0], ent.origin[1], ent.origin[2]+dist);
	ent moveto ( pos, time, accel, accel );
	
	level.speed_cola_ents[1] trigger_off();

	


	ent = level.jugg_ents[0];
	pos = (ent.origin[0], ent.origin[1], ent.origin[2]+dist);
	ent moveto ( pos, time, accel, accel );
	
	level.jugg_ents[1] trigger_off();
	
}

perk_machine_show_selected( perk_index, moving )
{
	switch( perk_index )
	{
		case 0:
			perk_machines_hide( 0, 1, moving );
		break;
		
		case 1:
			perk_machines_hide( 1, 0, moving );
		break;
	}
}

perk_machines_hide( cola, jug, moving )
{
	if(!IsDefined(moving))
	{
		moving = false;
	}
	if( cola )
	{
		level.speed_cola_ents[0] hide();
	}
	else
	{
		level.speed_cola_ents[0] show();
	}
	
	if( jug )
	{
		level.jugg_ents[0] hide();
	}
	else
	{
		level.jugg_ents[0] show();
	}
	
	if(moving)
	{
		level.speed_cola_ents[1] trigger_off();
		level.jugg_ents[1] trigger_off();
		
		if(IsDefined(level.speed_cola_ents[1].hackable))
		{
			maps\_zombiemode_equip_hacker::deregister_hackable_struct(level.speed_cola_ents[1].hackable);
		}
		
		if(IsDefined(level.jugg_ents[1].hackable))
		{
			maps\_zombiemode_equip_hacker::deregister_hackable_struct(level.jugg_ents[1].hackable);
		}
	}
	else
	{
		hackable = undefined;
		
		if(cola)
		{
			level.jugg_ents[1] trigger_on();
			if(IsDefined(level.jugg_ents[1].hackable))
			{
				hackable = level.jugg_ents[1].hackable;
			}
		}
		else
		{
			level.speed_cola_ents[1] trigger_on();
			
			if(IsDefined(level.speed_cola_ents[1].hackable))
			{
				hackable = level.speed_cola_ents[1].hackable;
			}
		}		
		
		maps\_zombiemode_equip_hacker::register_pooled_hackable_struct(hackable, maps\_zombiemode_hackables_perks::perk_hack, maps\_zombiemode_hackables_perks::perk_hack_qualifier);		
	}			
}

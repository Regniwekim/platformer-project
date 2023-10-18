{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "par_actor",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":null,"propertyId":{"name":"event_tick","path":"objects/__entity_1/__entity_1.yy",},"value":"platformer_event_tick",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"par_entity","path":"objects/par_entity/par_entity.yy",},"propertyId":{"name":"event_tick","path":"objects/par_entity/par_entity.yy",},"value":"platformer_event_tick",},
  ],
  "parent": {
    "name": "Actors",
    "path": "folders/Objects/Entities/Actors.yy",
  },
  "parentObjectId": {
    "name": "par_entity",
    "path": "objects/par_entity/par_entity.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"walk_speed_standard","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"2","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"run_multiplier","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"3","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"crouch_multiplier","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0.33","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"acceleration_standard","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0.2","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"braking_standard","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"1","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"resistance_standard","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"1","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"resistance_ground","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"1","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"resistance_air","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0.5","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"resistance_water","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0.5","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"jump_height_standard","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"8","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"jump_height_wall","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"10","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"jump_height_wall_angle","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"35","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"wall_stick_max","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"coyote_time","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"climbing_speed","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"4","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"multijump_max","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_right","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check(\"right\")","varType":4,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_left","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check(\"left\")","varType":4,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_up","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check(\"up\")","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_down","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check(\"down\")","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_jump","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check(\"jump\")","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_jump_pressed","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check_pressed(\"jump\")","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"input_run","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"input_check(\"run\")","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_walk","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_walk","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_idle","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_idle","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_run","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_run","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_jump","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_jump","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_fall","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_fall","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_skid","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_skid","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_slide","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_slide","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_land","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_land","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_roll","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_roll","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_hurt","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_hurt","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_crouch_idle","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_crouch_idle","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_crouch_walk","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_crouch_walk","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_air_jump","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_air_jump","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_wall_climb","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_wall_climb","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_wall_land","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_wall_land","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spr_wall_slide","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_wall_slide","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"mask_stand","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_mask_stand","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"mask_crouch","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_mask_crouch","varType":5,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"mask_slide","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"spr_player_mask_slide","varType":5,},
  ],
  "solid": false,
  "spriteId": null,
  "spriteMaskId": null,
  "visible": true,
}
CREATE SEQUENCE public.jmg_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;   

-------------------------- FAMILY --------------------------------
CREATE TABLE public.family(
    family_id integer DEFAULT nextval('jmg_seq'),
    family_name text NOT NULL,
    image text DEFAULT ''
);
ALTER TABLE family ADD CONSTRAINT family_pk PRIMARY KEY (family_id);
/*CREATE unique index family_idx_name on family (family_name);*/

---------------------------------------------- MACHINE --------------------------------------
CREATE TABLE public.machine(
    machine_id integer DEFAULT nextval('jmg_seq'),
    machine_name text NOT NULL,
    family_id integer NOT NULL,
    image text DEFAULT '',
    min_arm_lh double precision DEFAULT 0,
    max_arm_lh double precision DEFAULT 0,
    min_swing double precision DEFAULT 0,
    max_swing double precision DEFAULT 0,
    front_wheel integer DEFAULT 2,
    rear_wheel integer DEFAULT 2,
    plate_area double precision DEFAULT 0,
    multiplier_distance_hub_to_arm double precision DEFAULT 0,
    offset_distance_hub_to_arm double precision DEFAULT 0,
    on_tyre boolean DEFAULT true,
    wheel_base double precision DEFAULT 0,
    multiplier_front_ground_pressure double precision DEFAULT 0,
    multiplier_rear_groud_pressure double precision DEFAULT 0,
    offset_front_groud_pressure double precision DEFAULT 0,
    offset_rear_groud_pressure double precision DEFAULT 0,
    battery_weight double precision DEFAULT 0,
    empty_weight double precision DEFAULT 0,
    arm_weight double precision DEFAULT 0,
    distance_arm_hub_rotation_center double precision DEFAULT 0,
    distance_sheld_roation_center double precision DEFAULT 0,
    distance_cog_empty_machine_rotation_center double precision DEFAULT 0,
    distance_cog_battery_rotation_center_mm double precision DEFAULT 0,
    distance_arm_hub_ground_mm double precision DEFAULT 0
);
ALTER TABLE machine ADD CONSTRAINT machine_pk PRIMARY KEY (machine_id);
ALTER TABLE machine ADD CONSTRAINT machine_fk FOREIGN KEY (family_id) REFERENCES family(family_id) ON DELETE NO ACTION;

------------------------------------- BALLAST -------------------------------------
CREATE TABLE public.ballast(
    ballast_id integer DEFAULT nextval('jmg_seq') NOT NULL,
    ballast_name text NOT NULL
);
ALTER TABLE ballast ADD CONSTRAINT ballast_pk PRIMARY KEY (ballast_id);
/*CREATE UNIQUE INDEX ballast_idx_name ON ballast (ballast_name);*/

CREATE TABLE public.machine_ballast(
	machine_id integer NOT NULL,
	ballast_id integer NOT NULL,
	image text DEFAULT '',
	ballast_weight double precision DEFAULT 0,
    kgmm double precision DEFAULT 0,
    predefined boolean DEFAULT false
);
ALTER TABLE machine_ballast ADD CONSTRAINT machine_ballast_pk PRIMARY KEY (machine_id, ballast_id);
ALTER TABLE machine_ballast ADD CONSTRAINT machine_ballast_fk_machine FOREIGN KEY (machine_id) REFERENCES machine (machine_id) ON DELETE CASCADE;
ALTER TABLE machine_ballast ADD CONSTRAINT machine_ballast_fk_ballast FOREIGN KEY (ballast_id) REFERENCES ballast (ballast_id) ON DELETE NO ACTION;


------------------------------------------- ACCESSORY --------------------------------------------
CREATE TABLE public.accessory(
    accessory_id integer DEFAULT nextval('jmg_seq') NOT NULL,
    accessory_name text NOT NULL
);
ALTER TABLE accessory ADD CONSTRAINT accessory_pk PRIMARY KEY (accessory_id);
/*CREATE UNIQUE INDEX accessory_idx_name ON accessory (accessory_name);*/

CREATE TABLE public.machine_accessory(
	machine_id integer NOT NULL,
	accessory_id integer NOT NULL,
	image text DEFAULT '',
	accessory_weight bigint DEFAULT 0,
    accessory_distance bigint DEFAULT 0,
    accessory_length bigint DEFAULT 0,
    head_offset text DEFAULT '',
    predefined boolean DEFAULT false
);
ALTER TABLE machine_accessory ADD CONSTRAINT machine_accessory_pk PRIMARY KEY (machine_id,accessory_id);
ALTER TABLE machine_accessory ADD CONSTRAINT machine_accessory_fk_machine FOREIGN KEY (machine_id) REFERENCES machine (machine_id) ON DELETE CASCADE;
ALTER TABLE machine_accessory ADD CONSTRAINT machine_accessory_fk_accessory FOREIGN KEY (accessory_id) REFERENCES accessory (accessory_id) ON DELETE NO ACTION;


------------------------------ FAMILY ID: 1-->16 ---------------------------------------
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC25S"},{"code":"en","value":"MC25S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC45S"},{"code":"en","value":"MC45S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC60S"},{"code":"en","value":"MC60S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC80.06"},{"code":"en","value":"MC80.06"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC90S"},{"code":"en","value":"MC90S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC100S"},{"code":"en","value":"MC100S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC110"},{"code":"en","value":"MC110"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC130S"},{"code":"en","value":"MC130S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC160"},{"code":"en","value":"MC160"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC180S"},{"code":"en","value":"MC180S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC250"},{"code":"en","value":"MC250"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC300S"},{"code":"en","value":"MC300S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC350S"},{"code":"en","value":"MC350S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC400"},{"code":"en","value":"MC400"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC450S"},{"code":"en","value":"MC450S"}]}');
INSERT INTO public.family(family_name) VALUES ('{"labels":[{"code":"it","value":"MC580"},{"code":"en","value":"MC580"}]}');

---------------------------- ZAVORRE ID: 17-->23 -----------------------------------
    INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"nessuna"},{"code":"en","value":"none"}]}');
INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"Z1"},{"code":"en","value":"Z1"}]}');
INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"Z1+Z2"},{"code":"en","value":"Z1+Z2"}]}');
INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"Z1+Z2+Z3"},{"code":"en","value":"Z1+Z2+Z3"}]}');
INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"Z1+Z2+Z3+Z4"},{"code":"en","value":"Z1+Z2+Z3+Z4"}]}');
INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"Z1+Z2+Z3+Z4+Z5"},{"code":"en","value"::"Z1+Z2+Z3+Z4+Z5"}]}');
INSERT INTO public.ballast(ballast_name) VALUES ('{"labels":[{"code":"it","value":"Z1+Z2+Z3+Z4+Z5+Z6"},{"code":"en","value":"Z1+Z2+Z3+Z4+Z5+Z6"}]}');

-------------- ACCESSORI ID : 24-->71 --------------------------------
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Testa Flottante"},{"code":"en","value":"Floating Head"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Meccanico"},{"code":"en","value":"Mechanical Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Meccanico 0,5t"},{"code":"en","value":"Mechanical Jib 0,5t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Meccanico 3,5t"},{"code":"en","value":"Mechanical Jib 3,5t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Meccanico 4t"},{"code":"en","value":"Mechanical Jib 4t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Meccanico 5t"},{"code":"en","value":"Mechanical Jib 5t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Meccanico 30t"},{"code":"en","value":"Mechanical Jib 30 t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Posizione A"},{"code":"en","value":"Position A Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Posizione B"},{"code":"en","value":"Position B Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Posizione C"},{"code":"en","value":"Position C Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico"},{"code":"en","value":"Hydraulic Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico 3t"},{"code":"en","value":"Hydraulic Jib 3t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico 10t"},{"code":"en","value":"Hydraulic Jib 10t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico 13t"},{"code":"en","value":"Hydraulic Jib 13t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico 18t"},{"code":"en","value":"Hydraulic Jib18t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico 4t Corto"},{"code":"en","value":"Short Hydraulic Jib 4t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico 4t Lungo"},{"code":"en","value":"Long Hydraulic Jib 4t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico Telescopico Corto"},{"code":"en","value":"Short Telescopic Hydraulic Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Idraulico Telescopico Lungo"},{"code":"en","value":"Long Telescopic Hydraulic Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica"},{"code":"en","value":"Mechanical Extension"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 2t"},{"code":"en","value":"Mechanical Extension 2t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 2,6t"},{"code":"en","value":"Mechanical Extension 2,6t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 3t"},{"code":"en","value":"Mechanical Extension 3t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 4,5t"},{"code":"en","value":"Mechanical Extension 4,5t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 5t"},{"code":"en","value":"Mechanical Extension 5t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 7t"},{"code":"en","value":"Mechanical Extension 7t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Meccanica 10t"},{"code":"en","value":"Mechanical Extension 10t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Idraulica Corta 0"},{"code":"en","value":"Short Hydraulic Extension 0"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Idraulica Corta 40"},{"code":"en","value":"Short Hydraulic Extension 40"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Idraulica Corta 80"},{"code":"en","value":"Short Hydraulic Extension 80"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Idraulica Lunga 0"},{"code":"en","value":"Long Hydraulic Extension 0"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Idraulica Lunga 40"},{"code":"en","value":"Long Hydraulic Extension 40"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Idraulica Lunga 80"},{"code":"en","value":"Long Hydraulic Extension 80"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga 17t"},{"code":"en","value":"Extension 17t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga 10t"},{"code":"en","value":"Extension 10t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga 14t"},{"code":"en","value":"Extension 14t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Posizione A"},{"code":"en","value":"Position A Extension"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Posizione B"},{"code":"en","value":"Position B Extension"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga Posizione C"},{"code":"en","value":"Position C Extension"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga 3t Su Jib Meccanico 4t"},{"code":"en","value":"Extension 3t on Mechanical Jib 4t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Prolunga 2t Su Jib Idraulico"},{"code":"en","value":"Extension 2t on Hydraulic Jib"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Forche"},{"code":"en","value":"Pitchforks"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Forche FEM"},{"code":"en","value":"FEM Pitchforks"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Forche 3t"},{"code":"en","value":"Pitchforks 3t"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Forche 8t@0,6m"},{"code":"en","value":"pitchforks 8t@0,6m"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Testa Braccio Base"},{"code":"en","value":"Head Arm Base"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Testa Idraulica"},{"code":"en","value":"Hydraulic Head"}]}');
INSERT INTO public.accessory(accessory_name) VALUES ('{"labels":[{"code":"it","value":"Jib Articolato"},{"code":"en","value":"Articulated Jib"}]}');

--------------------------------------------------- MACHINE ID: 72-->114 SE INSERT FATTE IN ORDINE-----------------------------------------
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (3,'{"labels":[{"code":"it","value":"MC60S"},{"code":"en","value":"MC60S"}]}',0,0017,9.95,0.0018,5.5497,0.4001,405.57,2,2,2496,844,2355,-15,60,2450,3245,82451390,390,1135,1390,1782,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (5,'{"labels":[{"code":"it","value":"MC90S"},{"code":"en","value":"MC90S"}]}',0.001133,4.667,0.001667,4.833,0.4168,137.62,2,2,3880,1100,2560,-10.5,63.2,2650,3530,7810,1820,470,1208,1449,1815,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (6,'{"labels":[{"code":"it","value":"MC100S su Stabilizzatori"},{"code":"en","value":"MC100S on Stabilizers"}]}',0.0001,0.78,0.0017,9.95,0.5019,0.2556,2,2,4130,1370,3177,-10.5,63.2,3077,3930,9000,2070,104,1585,712,1854,65,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (6,'{"labels":[{"code":"it","value":"MC100S su Gomme"},{"code":"en","value":"MC100S on Tires"}]}',0.0001,0.78,0.0017,9.95,0.5019,0.2556,2,2,4130,1370,2780,-10.5,63.2,2680,3930,9000,2070,500,175,1445,1854,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (7,'{"labels":[{"code":"it","value":"MC110"},{"code":"en","value":"MC110"}]}',0.0011,6.1245,0.0017,9.95,0.4258,205.57,4,2,8980,1620,3230,-9,60,2800,4700,10855,0.001,470,712,0,1920,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (8,'{"labels":[{"code":"it","value":"MC130S su Stabilizzatori"},{"code":"en","value":"MC130S on Stabilizers"}]}',0.0011,6.1245,0.0017,9.95,0.4179,247.15,4,2,7074,1737,3660,-6,65,3295,4135,10435,2265,106,1906,1906,2024,728,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (8,'{"labels":[{"code":"it","value":"MC130S su Gomme"},{"code":"en","value":"MC130S on Tires"}]}',0.0011,6.1245,0.0017,9.95,0.4179,247.15,4,2,7074,1737,3265,-6,65,2900,4135,10435,2265,500,1511,1629,1872,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (9,'{"labels":[{"code":"it","value":"MC160 su Gomme maggiorate"},{"code":"en","value":"MC160 on Oversized Tires"}]}',0.000698,7.3243,0.000698,7.3243,0.4491,126.78,4,2,9075,2215,3550,-12,55,3150,5020,13190,0,470,1532,0,1900,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (9,'{"labels":[{"code":"it","value":"MC160 su Gomme standard"},{"code":"en","value":"MC160 on Standard Tires"}]}',0.000698,7.3243,0.000698,7.3243,0.4491,126.78,4,2,8675,2215,3550,-12,55,3150,5020,13190,0,470,1475,0,1900,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (10,'{"labels":[{"code":"it","value":"MC180S su Gomme"},{"code":"en","value":"MC180S on Tires"}]}',0.00075,7,0.00075,7,0.5083,-45.388,4,2,9015,2400,3650,-5.58,64.69,3250,5030,11530,3200,470,1500,2673,1903.5,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (10,'{"labels":[{"code":"it","value":"MC180S su Gomme Filo Scudo"},{"code":"en","value":"MC180S on Edge Shield Tires"}]}',0.00075,7,0.00075,7,0.5083,-45.388,4,2,9015,2400,3995,-5.58,64.69,3595,5030,11530,3200,125,715,3018,1903.5,380,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (10,'{"labels":[{"code":"it","value":"MC180S su Stabilizzatori 150mm"},{"code":"en","value":"MC180S on Stabilizers 150mm"}]}',0.00075,7,0.00075,7,0.5083,-45.388,4,2,9015,2400,4270,-5.58,64.69,3870,5030,11530,3200,-150,2120,3293,1903.5,380,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (10,'{"labels":[{"code":"it","value":"MC180S su Stabilizzatori 250mm"},{"code":"en","value":"MC180S on Stabilizers 250mm"}]}',0.00075,7,0.00075,7,0.5083,-45.388,4,2,9015,2400,4370,-5.58,64.69,3970,5030,11530,3200,-250,2220,3393,1903.5,380,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (11,'{"labels":[{"code":"it","value":"MC250 su Gomme"},{"code":"en","value":"MC250 on Tires"}]}',0.00075,7.2613,0.00075,7.2613,0.4181,278.94,4,2,18030,2820,3785,-7,60.05,3400,5255,11955,0.001,470,2030,0,2104,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (11,'{"labels":[{"code":"it","value":"MC250 su Stabilizzatori Aperti"},{"code":"en","value":"MC250 on open Stabilizers"}]}',0.00075,7.2613,0.00075,7.2613,0.4181,278.94,4,2,18030,2820,4505,-7,60.05,4120,5255,11955,0.001,-250,2750,0,2104,380,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (11,'{"labels":[{"code":"it","value":"MC250 su Stabilizzatori Dritti"},{"code":"en","value":"MC250 on straight Stabilizers"}]}',0.00075,7.2613,0.00075,7.2613,0.4181,278.94,4,2,18030,2820,4555,-7,60.05,4170,5255,11955,0.001,-300,2800,0,2104,380,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (13,'{"labels":[{"code":"it","value":"MC350 su Gomme"},{"code":"en","value":"MC350 on  Tires"}]}',0.00075,7,0.00075,7,0.4771,157.69,4,4,14150,4200,4280,-12,55,3800,5750,13190,4000,470,1860,2860,2190,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (13,'{"labels":[{"code":"it","value":"MC350 con Stabilizzatori su Gomme"},{"code":"en","value":"MC350 with Stabilizers on Tires"}]}',0.00075,7,0.00075,7,0.4771,157.69,4,4,15350,4200,4280,-12,55,3800,5750,13190,4000,470,2090,2860,2190,490.87,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (13,'{"labels":[{"code":"it","value":"MC350 su Stabilizzatori Aperti"},{"code":"en","value":"MC350 on open Stabilizers"}]}',0.00075,7,0.00075,7,0.4771,157.69,4,4,15350,4200,4950,-12,55,4470,5750,13190,4000,-87,2760,3530,2190,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (13,'{"labels":[{"code":"it","value":"MC350 su Stabilizzatori Dritti"},{"code":"en","value":"MC350 on straight Stabilizers"}]}',0.00075,7,0.00075,7,0.4771,157.69,4,4,15350,4200,5050,-12,55,4570,5750,13190,4000,-300,2860,3630,2190,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 su Stabilizzatori Aperti Gruppo Aperto"},{"code":"en","value":"MC580 on open Stabilizers Open Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,16610,7100,5140,-3,55,5690,5300,13500,0,-140,1666,0,2350,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 su Stabilizzatori Aperti Gruppo Chiuso"},{"code":"en","value":"MC580 on open Stabilizers Open Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,16610,7100,5140,-3,55,4490,5300,13500,0,-140,1666,0,2350,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 su Stabilizzatori Dritti Gruppo Aperto"},{"code":"en","value":"MC580 on straight Stabilizers Close Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,16610,7100,5325,-3,55,5875,5300,13500,0,-325,1851,0,2350,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 su Stabilizzatori Dritti Gruppo Chiuso"},{"code":"en","value":"MC580 on straight Stabilizers Close Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,16610,7100,5325,-3,55,4675,5300,13500,0,-325,1851,0,2350,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 su Gomme Gruppo Aperto"},{"code":"en","value":"MC580 on Tires Open Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,16610,7100,4450,-3,55,5000,5300,13500,0,550,976,0,2350,490.87,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 su Gomme Gruppo Chiuso"},{"code":"en","value":"MC580 on Tires Close Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,16610,7100,4450,-3,55,3800,5300,13500,0,550,976,0,2350,490.87,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 No Stabilizzatoti Gruppo Aperto"},{"code":"en","value":"MC580 no Stabilizers Open Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,14640,7100,4450,-3,55,5000,5300,13500,0,550,1134,0,2350,490.87,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (16,'{"labels":[{"code":"it","value":"MC580 No Stabilizzatori Gruppo Chiuso"},{"code":"en","value":"MC580 no Stabilizers Close Group"}]}',0.000256,8.75,0.00068,7.33,0.4173,541.55,4,4,14640,7100,4450,-3,55,3800,5300,13500,0,550,1134,0,2350,490.87,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (1,'{"labels":[{"code":"it","value":"MC25S-MY2019"},{"code":"en","value":"MC25S-MY2019"}]}',0.0053,4.9098,0.0082,5565,0.3771,258.43,2,2,1319,260,1435,-15,66,1635,2130,4670,0,250,780,0,1250,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (4,'{"labels":[{"code":"it","value":"MC80.06 Gruppo Chiuso"},{"code":"en","value":"MC80.06 Close Group"}]}',0.0017,9.95,0.0017,9.95,0.5532,125.99,4,2,4547,1140,2350,-7,70,2200,2950,6310,2050,390,1089,1035,1850,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (4,'{"labels":[{"code":"it","value":"MC80.06 Gruppo Aperto"},{"code":"en","value":"MC80.06 Open Group"}]}',0.0017,9.95,0.0017,9.95,0.5532,125.99,4,2,4547,1140,2350,-7,70,2800,2950,6310,2050,390,1386,1635,1850,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (12,'{"labels":[{"code":"it","value":"MC300S su Gomme"},{"code":"en","value":"MC300S on Tires"}]}',0.0007,7.3243,0.0007,7.3243,0.5304,73.607,4,4,13610,3270,3785,-4.97,60.39,3400,4755,10495,3230,470,1564,2674,2104,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (12,'{"labels":[{"code":"it","value":"MC300S su Stabilizzatori Filo Scudo"},{"code":"en","value":"MC300S on Edge Shield Stabilizers"}]}',0.0007,7.3243,0.0007,7.3243,0.5304,73.607,4,4,13610,3270,4109,-4.97,60.39,3724,4755,10495,3230,146,1888,2998,2104,491,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (12,'{"labels":[{"code":"it","value":"MC300S su Stabilizzatori 300mm"},{"code":"en","value":"MC300S on Stabilizers 300mm"}]}',0.0007,7.3243,0.0007,7.3243,0.5304,73.607,4,4,13610,3270,4555,-4.97,60.39,4170,4755,10495,3230,-300,2334,3444,2104,491,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (14,'{"labels":[{"code":"it","value":"MC400 con Stabilizzatori su Gomme"},{"code":"en","value":"MC400 with Stabilizers on Tires"}]}',0.0007,7.3243,0.0007,7.3243,0.4776,179.37,4,4,13670,4370,4280,-3,65,3800,5750,13190,4000,470,1814,2860,2193.5,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (14,'{"labels":[{"code":"it","value":"MC400 su Stabilizzatori Aperti"},{"code":"en","value":"MC400 on open Stabilizers"}]}',0.0007,7.3243,0.0007,7.3243,0.4776,179.37,4,4,13670,4370,4950,-3,65,4470,5750,13190,4000,-87,2484,3530,2193.5,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (14,'{"labels":[{"code":"it","value":"MC400 su Stabilizzatori Dritti"},{"code":"en","value":"MC400 on straight Stabilizers"}]}',0.0007,7.3243,0.0007,7.3243,0.4776,179.37,4,4,13670,4370,5050,-3,65,4570,5750,13190,4000,-300,2584,3630,2193.5,490.87,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (15,'{"labels":[{"code":"it","value":"MC450S su Gomma Gruppo Chiuso"},{"code":"en","value":"MC450S on Tires Close Group"}]}',0.0003,9.125,0.0007,7.3243,0.4793,171.01,4,4,17150,4600,4050,-4.6,63.4,3400,5600,12400,4400,550,1355.5,2742,2280,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (15,'{"labels":[{"code":"it","value":"MC450S su Gomma Gruppo Aperto"},{"code":"en","value":"MC450S on Tires Open Group"}]}',0.0003,9.125,0.0007,7.3243,0.4793,171.01,4,4,17150,4600,4050,-4.6,63.4,4400,5600,12400,4400,550,1542.2,3742,2280,0,true);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (15,'{"labels":[{"code":"it","value":"MC450S su Stabilizizzatori 165mm Gruppo Chiuso"},{"code":"en","value":"MC450S on Stabilizers 165mm Close Group"}]}',0.0003,9.125,0.0007,7.3243,0.4793,171.01,4,4,17150,4600,4765,-4.6,63.4,4115,5600,12400,4400,-165,2070.5,2457,2280,486.95,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (15,'{"labels":[{"code":"it","value":"MC450S su Stabilizzatori 165mm Gruppo Aperto"},{"code":"en","value":"MC450S on Stabilizers 165mm Open Group"}]}',0.0003,9.125,0.0007,7.3243,0.4793,171.01,4,4,17150,4600,4765,-4.6,63.4,5115,5600,12400,4400,-165,2257.2,4457,2280,486.95,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (15,'{"labels":[{"code":"it","value":"MC450S su Stabilizzatori 250mm Gruppo Chiuso"},{"code":"en","value":"MC450S on Stabilizers 165mm Close Group"}]}',0.0003,9.125,0.0007,7.3243,0.4793,171.01,4,4,17150,4600,4850,-4.6,63.4,4200,5600,12400,4400,-250,2155.5,3542,2280,486.95,false);
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (15,'{"labels":[{"code":"it","value":"MC450S su Stabilizzatori 250mm Gruppo Aperto"},{"code":"en","value":"MC450S on Stabilizers 165mm Open Group"}]}',0.0003,9.125,0.0007,7.3243,0.4793,171.01,4,4,17150,4600,4850,-4.6,63.4,5200,5600,12400,4400,-250,2342.2,4542,2280,486.95,false);

--------------------------------------------------------- MACHINE_BALLAST -------------------------------------------------------------------------
---------------------------- ATTENZIONE ID MACCHINE PARTONO DA 82 MENTRE ID ZAVORRE PARTONO DA 17 -------------------------------------
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (72,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (73,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (74,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (75,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (76,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (77,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (78,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (79,17,true,3570,9414090);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (80,17,true,3210,8281800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (81,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (82,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (83,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (84,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (85,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (86,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (87,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (88,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (89,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (90,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (91,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (92,17,true,6220,31607800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (93,17,true,6220,24143800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (94,17,true,6220,32758500);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (95,17,true,6220,25294500);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (96,17,true,6220,27316000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (97,17,true,6220,19852000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (98,17,true,6220,27316000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (99,17,true,6220,19852000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (100,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (101,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (102,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (103,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (104,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (105,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (106,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (107,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (108,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (109,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (110,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (111,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (112,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (113,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (114,17,true,0,0);

INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (72,18,false,800,1820000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (73,18,false,1210,5359900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (74,18,false,1700,5349900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (75,18,false,1700,4675000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (76,19,false,3000,8400000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (77,18,false,2000,6804000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (78,18,false,2000,6014000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (79,19,false,7440,21605760);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (80,19,false,6210,17729550);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (81,19,false,4000,13000000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (82,19,false,4000,14380000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (83,19,false,4000,15480000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (84,19,false,4000,15880000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (85,19,false,4600,15640000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (86,19,false,4600,18952000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (87,19,false,4600,19182000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (88,19,false,4070,15466000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (89,19,false,4070,15466000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (90,19,false,4070,18192900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (91,19,false,4070,18599900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (92,19,false,12220,65746200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (93,19,false,12220,51082200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (94,19,false,12220,68006900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (95,19,false,12220,53342900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (96,19,false,12220,57314400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (97,19,false,12220,42650400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (98,19,false,12220,57314400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (99,18,false,12220,42650400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (100,18,false,750,1283000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (101,18,false,2200,5073200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (102,18,false,2200,6393200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (103,19,false,6000,20400000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (104,19,false,6000,22344000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (105,19,false,6000,25020000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (106,19,false,6000,23322000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (107,19,false,6000,27342000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (108,19,false,6000,27942000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (109,19,false,6000,20400000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (110,19,false,6000,26400000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (111,19,false,6000,24690000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (112,19,false,6000,30690000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (113,19,false,6000,25200000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (114,19,false,6000,31200000);

INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (72,19,false,1900,4373100);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (73,19,false,2910,7556720);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (74,19,false,3400,10693000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (75,19,false,3400,9343200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (77,19,false,4000,13600000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (78,19,false,4000,12020000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (79,20,false,8540,25654160);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (80,20,false,7310,21776490);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (81,20,false,6100,20786800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (82,20,false,6100,22891300);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (83,20,false,6100,24568800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (84,20,false,6100,25178800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (85,20,false,6100,21670000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (86,20,false,6100,26062000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (87,20,false,6100,26367000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (88,20,false,5490,21628800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (89,20,false,5490,21628800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (90,20,false,5490,25307100);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (91,20,false,5490,25856100);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (92,20,false,15220,84203200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (93,20,false,15220,65939200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (94,20,false,15220,87018900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (95,20,false,15220,68754900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (96,20,false,15220,73701400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (97,20,false,15220,55437400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (98,20,false,15220,73701400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (99,20,false,15220,55437400);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (101,19,false,4400,10216800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (102,19,false,4400,12856800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (103,20,false,7500,26445000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (104,20,false,7500,28875000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (105,20,false,7500,32220000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (106,20,false,7500,29997000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (107,20,false,7500,35022000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (108,20,false,7500,35772000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (109,20,false,8250,29370750);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (110,20,false,8250,37620750);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (111,20,false,8250,35269500);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (112,20,false,8250,43519500);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (113,20,false,8250,35970750);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (114,20,false,8250,44220750);

INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (74,20,false,4150,13300750);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (75,20,false,4150,11653200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (85,21,false,7300,26494000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (86,21,false,7300,3175000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (87,21,false,7300,32115000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (88,21,false,7300,29484200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (89,21,false,7300,29484200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (90,21,false,7300,34375200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (91,21,false,7300,35105200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (92,21,false,18220,102655000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (93,21,false,18220,80791000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (94,21,false,18220,106025700);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (95,21,false,18220,84161700);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (96,21,false,18220,90083200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (97,21,false,18220,68219200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (98,21,false,18220,90083200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (99,21,false,18220,68219200);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (101,20,false,5100,12080900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (102,20,false,5100,15140900);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (103,21,false,8700,31233000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (104,21,false,8700,34051800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (105,21,false,8700,37932000);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (106,21,false,8700,35311800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (107,21,false,8700,41140800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (108,21,false,8700,42010800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (109,21,false,10600,38615650);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (110,21,false,10600,49215650);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (111,21,false,10600,46194650);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (112,21,false,10600,56794650);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (113,21,false,10600,47095650);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (114,21,false,10600,57695650);

INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (106,23,false,10700,44099800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (107,23,false,10700,51268800);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (108,23,false,10700,52338800);

------------------------------------------------- MACHINE_ACCESSORY --------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------- ACCESSORIO 1 ------------------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (72,24,0,0,0,'1:0,2:0',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (73,24,0,0,0,'1:0,2:0',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (74,24,0,0,0,'1:236,2:342',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (75,24,0,0,0,'1:236,2:342',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (76,24,0,0,0,'1:20,2:370',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (77,24,0,0,0,'1:326,2:455',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (78,24,0,0,0,'1:326,2:455',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (79,24,0,0,0,'1:330,2:420',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (80,24,0,0,0,'1:330,2:420',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (81,24,0,0,0,'1:317,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (82,24,0,0,0,'1:317,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (83,24,0,0,0,'1:317,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (84,24,0,0,0,'1:317,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (85,24,0,0,0,'1:316,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (86,24,0,0,0,'1:316,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (87,24,0,0,0,'1:316,2:439',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (88,24,0,0,0,'1:360,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (89,24,0,0,0,'1:360,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (90,24,0,0,0,'1:360,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (91,24,0,0,0,'1:360,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (92,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (93,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (94,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (95,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (96,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (97,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (98,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (99,24,0,0,0,'1:400,2:564',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (100,69,0,0,0,'1:101,2:138',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (101,24,0,0,0,'1:250,2:359',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (102,24,0,0,0,'1:250,2:359',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (103,70,0,0,0,'1:367,2:489',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (104,70,0,0,0,'1:367,2:489',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (105,70,0,0,0,'1:367,2:489',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (106,24,0,0,0,'1:361,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (107,24,0,0,0,'1:361,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (108,24,0,0,0,'1:361,2:504',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (109,24,0,0,0,'1:386,2:540',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (110,24,0,0,0,'1:386,2:540',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (111,24,0,0,0,'1:386,2:540',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (112,24,0,0,0,'1:386,2:540',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (113,24,0,0,0,'1:386,2:540',true);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, head_offset, predefined)	VALUES (114,24,0,0,0,'1:386,2:540',true);
---------------------------------------------------------------------------------------------------------------------ACCESSORIO 2 ----------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (72,28,76,400,700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (73,25,120,280,800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (74,25,160,693,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (75,25,160,693,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (77,25,296,1025,1500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (78,25,296,1025,1500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (79,34,590,1200,2200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (80,34,590,1200,2200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (81,41,595,1514,2200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (82,41,595,1514,2200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (83,41,595,1514,2200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (84,41,595,1514,2200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (85,25,400,900,1200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (86,25,400,900,1200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (87,25,400,900,1200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (88,34,786,1865,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (89,34,786,1865,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (90,34,786,1865,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (91,34,786,1865,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (92,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (93,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (94,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (95,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (96,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (97,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (98,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (99,25,860,400,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (100,31,20,163,274,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (101,71,155,678,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (102,71,155,678,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,51,670,732,1126,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,51,670,732,1126,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,51,670,732,1126,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (106,30,510,723,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (107,30,510,723,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (108,30,510,723,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (109,25,650,945,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (110,25,650,945,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (111,25,650,945,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (112,25,650,945,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (113,25,650,945,1300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (114,25,650,945,1300,false);
--------------------------------------------------------------------------------------------------------------------------- ACCESSORIO 3 --------------------------------------------------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (72,69,101,760,1200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (73,43,190,600,1800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (74,45,260,1744,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (75,45,260,1744,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (77,51,407,1850,2700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (78,51,407,1850,2700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (79,25,370,410,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (80,25,370,410,1000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (81,42,595,2196,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (82,42,595,2196,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (83,42,595,2196,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (84,42,595,2196,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (85,49,640,2090,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (86,49,640,2090,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (87,49,640,2090,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (88,25,608,1040,1685,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (89,25,608,1040,1685,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (90,25,608,1040,1685,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (91,25,608,1040,1685,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (92,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (93,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (94,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (95,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (96,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (97,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (98,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (99,43,1080,725,2800,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (100,32,20,378,755,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (101,47,106,418,1700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (102,47,106,418,1700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,52,670,1425,2255,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,52,670,1425,2255,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,52,670,1425,2255,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (106,57,840,1780,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (107,57,840,1780,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (108,57,840,1780,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (109,59,880,2085,2795,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (110,59,880,2085,2795,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (111,59,880,2085,2795,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (112,59,880,2085,2795,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (113,59,880,2085,2795,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (114,59,880,2085,2795,false);
------------------------------------------------------------------------------------------------------ ACCESSORIO 4 -----------------------------------------------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (72,29,50,280,500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (74,47,20,1145,1700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (75,47,20,1145,1700,False);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (77,52,458,2400,3500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (78,52,458,2400,3500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (85,50,560,1450,2100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (86,50,560,1450,2100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (87,50,560,1450,2100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (88,65,2950,1470,864,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (89,65,2950,1470,864,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (90,65,2950,1470,864,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (91,65,2950,1470,864,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (100,33,20,455,938,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (101,45,252,1816,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (102,45,252,1816,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,53,670,1450,2273,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,53,670,1450,2273,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,53,670,1450,2273,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (106,58,975,2451,3500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (107,58,975,2451,3500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (108,58,975,2451,3500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (109,38,1090,1497,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (110,38,1090,1497,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (111,38,1090,1497,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (112,38,1090,1497,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (113,38,1090,1497,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (114,38,1090,1497,2300,false);
------------------------------------------------------------------------------------------------ ACCESSORIO 5 ------------------------------------------------------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (72,41,150,650,1100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (74,41,395,1518,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (75,41,395,1518,2300,False);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (77,41,433,1394,2000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (78,41,433,1394,2000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (85,41,660,1348,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (86,41,660,1348,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (87,41,660,1348,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (100,60,31,170,547,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (101,39,420,1298,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (102,39,420,1298,2300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,54,670,1066,1573,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,54,670,1066,1573,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,54,670,1066,1573,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (106,42,790,1863,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (107,42,790,1863,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (108,42,790,1863,3000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (109,65,3500,921,1558,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (110,65,3500,921,1558,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (111,65,3500,921,1558,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (112,65,3500,921,1558,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (113,65,3500,921,1558,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (114,65,3500,921,1558,false);
----------------------------------------------------------------------------- ACCESSORIO 6 ------------------------------------------------------------------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (72,70,98,1300,2000,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (74,42,395,2263,3300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (75,42,395,2263,3300,False);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (77,42,433,1959,2700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (78,42,433,1959,2700,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (85,42,660,2023,3200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (86,42,660,2023,3200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (87,42,660,2023,3200,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (100,61,31,401,1411,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (101,40,420,2066,3300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (102,40,420,2066,3300,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,55,670,2056,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,55,670,2056,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,55,670,2056,3100,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (106,37,720,1514,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (107,37,720,1514,2500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (108,37,720,1514,2500,false);
----------------------------------------------------------------------------------------------- ACCESSORIO 7 ------------------------------------------------------------------
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (72,67,700,652,1123,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (74,66,957,600,1005,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (75,66,957,600,1005,False);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (77,68,1453,663,1178,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (78,68,1453,663,1178,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (85,65,2200,800,1423,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (86,65,2200,800,1423,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (87,65,2200,800,1423,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (100,62,31,487,1738,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (101,65,1445,673,1050,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (102,65,1445,673,1050,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,56,670,2082,3120,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,56,670,2082,3120,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,56,670,2082,3120,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (106,65,3300,1584,886,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (107,65,3300,1584,886,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (108,65,3300,1584,886,false);
--------------------------------------------------------------------------------------------------- ACCESSORIO 8 -------------------------------------------------------------------

INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (103,65,3700,878,1470,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (104,65,3700,878,1470,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (105,65,3700,878,1470,false);

-------------------------------------------------------- MACCHINA DIMENTICATA, INSERIRE PER ULTIMA --------------------------------------------------
INSERT INTO public.machine(family_id, machine_name,multiplier_front_ground_pressure, offset_front_groud_pressure, multiplier_rear_groud_pressure, offset_rear_groud_pressure, multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, front_wheel, rear_wheel, empty_weight, arm_weight, distance_arm_hub_rotation_center, min_swing, max_swing, wheel_base, min_arm_lh, max_arm_lh, battery_weight, distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm, plate_area, on_tyre) VALUES (2,'{"labels":[{"code":"it","value":"MC45S"},{"code":"en","value":"MC45S"}]}',0.0012,5.4351,0.0021,5.704,0.4214,317.3,2,2,3000,550,2075,-15.01,60.12,2100,2605,6630,0.001,320,1028,0,1285,0,true);

INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (115,17,true,0,0);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (115,18,false,500,1047500);
INSERT INTO public.machine_ballast(machine_id, ballast_id,predefined, ballast_weight, kgmm ) VALUES (115,19,false,1350,2739000);

INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length,head_offset, predefined)	VALUES (115,24,0,0,0,'1:0,2:0',true );
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (115,26,65,665,1200,false );
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (115,27,60,355,600,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (115,44,90,1050,1500,false);
INSERT INTO public.machine_accessory(machine_id, accessory_id, accessory_weight, accessory_distance, accessory_length, predefined)	VALUES (115,34,105,1185,1800,false);

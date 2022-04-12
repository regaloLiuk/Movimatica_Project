package com.movimatica.jmg.model;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author luca
 */
public class Machine{
  
	  
	  private int id;		/** Codice che identifica univocamente la macchina, viene usato per costruire le immagini. */  
	  private HashMap<String,String> name;	/** Nome della macchina */
	  private Family family; 
	  private List<Ballast> ballasts;
	  private List<Accessory> accessories;
	  private String image;
	
	  /**Elementi per calcoli*/
	  private double minArmLength;
	  private double maxArmLength;
	  private double minSwing;
	  private double maxSwing;
	  private int frontWheel;	/** Il numero di ruote anteriori. */
	  private int rearWheel;	/** Il numero di ruote posteriori. */
	  private double plateArea;	/** Area del piattello dello stabilizzatore, in cm2. */
	  private double multiplierDistanceHubToArm;
	  private double offsetDistanceHubToArm ;
	  private boolean onTyre;
	  private double wheelBase;
	  private double multiplierFrontGroundPressure;
	  private double multiplierRearGroudPressure;
	  private double offsetFrontGroudPressure;
	  private double offsetRearGroudPressure;
	  private double batteryWeight;
	  private double emptyWeight;
	  private double armWeight;
	  private double df; 		// Distanza fultro braccio centro di rotazione
	  private double ds;		// Distanza scudo centro di rotazione
	  private double dvg;		// Distanza baricentro macchina a vuoto da centro di rotazione
	  private double db;  		// Distanza baricentro batteria centro di rotazione in millimetri
	  private double hf;  		// Distanza fulcro braccio suolo in millimetri
  
  //private List<Accessorio> accessori = new ArrayList<Accessorio>();
	public Machine(String name , Family family){
		this(0, Translator.toMap(name), family);
	}

	public Machine(HashMap<String,String> name , Family family){
		this(0, name, family);
	}

	public Machine(int id, HashMap<String,String> name, Family family){
		this.id = id;
	    this.name = name;
	    this.family = family;
	    this.ballasts= new ArrayList<Ballast>();
	    this.accessories = new ArrayList<Accessory>();
	    this.image="";
	    this.minArmLength = 0D;
	    this.maxArmLength = 0D;
	    this.minSwing = 0D;
	    this.maxSwing = 0D;;
	    this.frontWheel = 2;
	    this.rearWheel = 2;
	    this.plateArea = 0D;
	    this.multiplierDistanceHubToArm = 0D;
	    this.offsetDistanceHubToArm = 0D;
	    this.onTyre = true;
	    this.wheelBase = 0D;
	    this.multiplierFrontGroundPressure = 0D;
	    this.multiplierRearGroudPressure = 0D;
	    this.offsetFrontGroudPressure = 0D;
	    this.offsetRearGroudPressure = 0D;
	    this.batteryWeight = 0D;
	    this.emptyWeight = 0D;
	    this.armWeight = 0D;
	    this.df = 0D;
	    this.ds = 0D;
	    this.dvg = 0D;
	    this.db = 0D;
	    this.hf = 0D;
	}

	public Machine(ResultSet rs) throws SQLException {
	    
		this.id = rs.getInt("machine_id");
	    this.name = Translator.toMap(rs.getString("machine_name"));
	    this.family = new Family(rs);
	    this.ballasts = new ArrayList<Ballast>();
	    this.accessories = new ArrayList<Accessory>();
	    this.image = rs.getString("image");
	    this.minArmLength = rs.getDouble("min_arm_lh");
	    this.maxArmLength = rs.getDouble("max_arm_lh");
	    this.minSwing = rs.getDouble("min_swing");
	    this.maxSwing = rs.getDouble("max_swing");
	    this.frontWheel = rs.getInt("front_wheel");
	    this.rearWheel = rs.getInt("rear_wheel");
	    this.plateArea = rs.getDouble("plate_area");
	    this.multiplierDistanceHubToArm = rs.getDouble("multiplier_distance_hub_to_arm");
	    this.offsetDistanceHubToArm = rs.getDouble("offset_distance_hub_to_arm");
	    this.onTyre = rs.getBoolean("on_tyre");
	    this.wheelBase = rs.getDouble("wheel_base");
	    this.multiplierFrontGroundPressure = rs.getDouble("multiplier_front_ground_pressure");
	    this.multiplierRearGroudPressure = rs.getDouble("multiplier_rear_groud_pressure");
	    this.offsetFrontGroudPressure = rs.getDouble("offset_front_groud_pressure");
	    this.offsetRearGroudPressure = rs.getDouble("offset_rear_groud_pressure");
	    this.batteryWeight = rs.getDouble("battery_weight");
	    this.emptyWeight = rs.getDouble("empty_weight");
	    this.armWeight = rs.getDouble("arm_weight");
	    this.df = rs.getDouble("distance_arm_hub_rotation_center");
	    this.ds = rs.getDouble("distance_sheld_roation_center");
	    this.dvg = rs.getDouble("distance_cog_empty_machine_rotation_center");
	    this.db = rs.getDouble("distance_cog_battery_rotation_center_mm");
	    this.hf = rs.getDouble("distance_arm_hub_ground_mm");
	}

	public int getId() {    return this.id;  }
	public void setId(int id){this.id=id;}
	 
	public HashMap<String, String> getName(){return this.name;}
	public void setName(String name) {this.name = Translator.toMap(name);}
	public void setName(HashMap<String,String> name) {this.name = name;}

	public Family getFamily() {return this.family;}
	public void setFamily(Family family) {this.family = family;}
	
	public List<Ballast> getBallasts() {return this.ballasts;}
	public void setBallasts(List<Ballast> ballasts) {this.ballasts = ballasts;}
	
	public List<Accessory> getAccessories() {return this.accessories;}
	public void setAccessories(List<Accessory> accessories) {this.accessories=accessories; }

	public String getImage(){return this.image;}
	public void setImage(String image){this.image=image;}
	
	public double getMinArmLength() {return this.minArmLength;}
	public void setMinArmLength(final double mm) {this.minArmLength = mm;}
	
	public double getMaxArmLength() {return this.maxArmLength;}
	public void setMaxArmLength(final double mm) {    this.maxArmLength = mm;  }
	
	public double getMinSwing() {    return this.minSwing;  }
	public void setMinSwing(final double degrees) {    this.minSwing = degrees;  }
	
	public double getMaxSwing() {    return this.maxSwing;  }
	public void setMaxSwing(final double degrees) {    this.maxSwing = degrees;  }
	
	public int getFrontWheel() {    return this.frontWheel;  }
	public void setFrontWheel(final int numeroDiRuote) {
		this.frontWheel = Math.max(0, numeroDiRuote); // deve essere almeno 1
	}
	
	public int getRearWheel() {    return this.rearWheel;  }
	public void setRearWheel(final int numeroDiRuote) {
	    this.rearWheel = Math.max(0, numeroDiRuote); // deve essere almeno 1
	}
	
	public double getPlateArea() {    return this.plateArea;  }
	public void setPlateArea(final double area) {    this.plateArea = area;  }
	
	public double getMultiplierDistanceHubToArm() {return this.multiplierDistanceHubToArm;}
	public void setMultiplierDistanceHubToArm(final double multiplier) {this.multiplierDistanceHubToArm = multiplier;}
	
	public double getOffsetDistanceHubToArm() {return this.offsetDistanceHubToArm;}
	public void setOffsetDistanceHubToArm(final double offset) {this.offsetDistanceHubToArm = offset;}
	
	public boolean isOnTyre() {    return this.onTyre;  }
	public void setOnTyre(final boolean isonTyre) {    this.onTyre = isonTyre;  }
	
	public double getWheelBase() {    return this.wheelBase;  }
	public void setWheelBase(final double mm) {    this.wheelBase = mm;  }
	
	public double getMultiplierFrontGroundPressure() {return this.multiplierFrontGroundPressure;}
	public void setMultiplierFrontGroundPressure(final double multiplier) {this.multiplierFrontGroundPressure = multiplier;}
	
	public double getMultiplierRearGroudPressure() {return this.multiplierRearGroudPressure;}
	public void setMultiplierRearGroudPressure(final double multiplier) {this.multiplierRearGroudPressure = multiplier;}
	
	public double getOffsetFrontGroudPressure() {return this.offsetFrontGroudPressure;}
	public void setOffsetFrontGroudPressure(final double offset) {this.offsetFrontGroudPressure = offset;}
	
	public double getOffsetRearGroudPressure() {return this.offsetRearGroudPressure;}
	public void setOffsetRearGroudPressure(final double offset) {this.offsetRearGroudPressure = offset;}
	
	public double getBatteryWeight() {    return this.batteryWeight;  }
	public void setBatteryWeight(final double kg) {    this.batteryWeight = kg;  }
	
	public double getEmptyWeight() {    return this.emptyWeight;  }
	public void setEmptyWeight(final double kg) {    this.emptyWeight = kg;  }
	
	public double getArmWeight() {    return this.armWeight;  }
	public void setArmWeight(final double kg) {    this.armWeight = kg;  }
	
	public double getDf() {    return this.df;  }
	public void setDf(final double mm) {    this.df = mm;  }
	
	public double getDs() {    return this.ds;  }
	public void setDs(final double mm) {    this.ds = mm;  }
	
	public double getDvg() {    return this.dvg;  }
	public void setDvg(final double mm) {    this.dvg = mm;  }
	
	public double getDb() {    return this.db;  }
	public void setDb(final double mm) {    this.db = mm;  }
	
	public double getHf() {    return this.hf;  }
	public void setHf(final double mm) {    this.hf = mm;  }
	 
	public String toString() {
		 return  "id: " + id + ", nome: " + name + "\n"+ 
				 "famglia: " + family.toString() +
				 "lunghezza braccio min-max: " + minArmLength+"-"+maxArmLength + "\n" +
				 "brandeggio min-max " + minSwing + "-" + maxSwing + "\n" +
				 "numero ruote anteriori-posteriori: " + frontWheel + "-" + rearWheel + "\n" +
				 "area Piattello: " + plateArea + "\n" +
				 "distanza fulcro baricentro braccio multipler-offset: " + multiplierDistanceHubToArm + "-" + offsetDistanceHubToArm + "\n" +
				 "su gomma: " + onTyre + "\n" +
				 "wheelBase: " + wheelBase  + "\n" +
				 "pressione Suolo Anteriore Multiplier-offset: " + multiplierFrontGroundPressure + "-" + offsetFrontGroudPressure + "\n" +
				 "pressione Suolo posteriore Multiplier-offset: " + multiplierRearGroudPressure + "-" + offsetRearGroudPressure + "\n" +
				 "peso Batteria: " + batteryWeight  + "\n" +
				 "peso Vuoto: " + emptyWeight  + "\n" +
				 "peso Braccio: " + armWeight + "\n" +
				 "distanza fultro braccio-centro rotazione: " + ds + "\n" +
				 "distanza scudo-centro rotazione: " + df + "\n" +
				 "distanza baricentro macchina a vuoto-centro rotazione: " + dvg + "\n" +
				 "distanza baricentro batteria-centro rotazione in mm: " + db + "\n" +
				 "distanza fulcro braccio-suolo in millimetri: " + hf + "\n" + 
				 "zavorre: " + ballasts.toString() + "\n" +
				 "accessori: " + accessories.toString() + "\n";
	}
  
  
  
}

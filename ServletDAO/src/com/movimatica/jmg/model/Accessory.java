package com.movimatica.jmg.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author luca
 */
public class Accessory {
  
  private int id;
  private HashMap<String,String> name;
  private  String image;
  private double weight;
  private double distance;			/** La distanza dell'asse gancio accessorio baricentro accessorio in mm. */
  private double length;			/** La lunghezza dell'accessorio in mm. */
  private String headOffset;		/**Vale solo per l'accessorio 'Testa rotante'. Un testo con sintassi <code>posizione_testa:lunghezzamm,posizione_testa:lunghezzamm</code> da sommare alla lunghezza del braccio.*/
  private HashMap<Integer,Integer> headPositions =new HashMap<Integer, Integer>(); /** headOffset in formato HashMap per recupero valori*/
  private boolean predefined;

	public Accessory(int id, String name) {
		this(id,Translator.toMap(name),"",0,0,0,"",false);
	}

	public Accessory(int id, HashMap<String,String> name) {
		this(id,name,"",0,0,0,"",false);
	}

	public Accessory(int id, HashMap<String,String> name, String image, double weight, double distance, double length, String headOffset, boolean predefined) {
	  this.id=id;
	  this.name=name;
	  this.image=image;
	  this.weight = weight;
	  this.distance = distance;
	  this.length = length;
	  this.headOffset = headOffset;
	  if(!headOffset.isEmpty()) {
		  this.headPositions=getHashMap(headOffset);
	  }
	  this.predefined = predefined;
  }

  public Accessory(ResultSet rs) throws SQLException{
	  this.id=rs.getInt("accessory_id");
	  this.name=Translator.toMap(rs.getString("accessory_name"));
	  this.image=rs.getString("image");
	  this.weight = rs.getDouble("accessory_weight");
	  this.distance = rs.getDouble("accessory_distance");
	  this.length = rs.getDouble("accessory_length");
	  this.headOffset = rs.getString("head_offset");
	  if(!headOffset.isEmpty()) {
		  this.headPositions=getHashMap(headOffset);
	  }
	  this.predefined = rs.getBoolean("predefined");
  }


  public int getId() {    return this.id;  }
  
  public HashMap<String, String> getName() {return this.name;}
  public void setName(String name) {this.name = Translator.toMap(name);}
  public void setName(HashMap<String,String> name) {this.name = name;}

  public String getImage(){return this.image;}
  public void setImage(String image){this.image=image;}

  public double getWeight() { return this.weight;  }
  public void setWeight(double kg) {this.weight=kg;}
  
  public double getDistance() {return this.distance;}
  public void setDistance (double distance) {this.distance = distance;}
  
  public double getLength() {return this.length;}
  public void setLength (double length) {this.length = length;}
  
  public String getHeadOffset() {return this.headOffset;}
  public void setHeadOffset (String headOffset) {this.headOffset = headOffset;}
  
  public boolean isPredefined() {return this.predefined;  }
  public void setPredefined(boolean predefined) {this.predefined=predefined;}
  
  public HashMap<Integer, Integer> getHeadPositions() {	return headPositions;	}

	public void setHeadPosition(HashMap<Integer, Integer> headPositions) {	this.headPositions = headPositions;	}
  
  public long getOffset(final int headPosition) {
	    if (this.headOffset.isEmpty()) { return 0; }
	    String[] tokens = this.headOffset.split(",");
	    String testa = Integer.toString(headPosition);
	    for (String token : tokens) {
	      // ogni token è nella forma posizione:offset
	      String[] keyVal = token.split(":");
	      if (keyVal.length != 2) { continue; }
	      if (testa.equals(keyVal[0])) { return Long.parseLong(keyVal[1], 10); }
	    }
	    return 0;
	  }
  public static HashMap<Integer,Integer> getHashMap(String headOffsets){
	  HashMap<Integer, Integer> result = new HashMap<Integer, Integer>();
	  if(!headOffsets.isEmpty()){
		  String[] tokens = headOffsets.split(",");
		  for (String token : tokens) {
			  String[] keyVal = token.split(":");
			  result.put(Integer.parseInt(keyVal[0]), Integer.parseInt(keyVal[1]));
		  }
	  }
	  return result;
  }
  public String toString(){
	   return "ID: " + getId() + ", NAME: " + getName() + " WEIGHT: " + getWeight() + " DISTANCE: " + getDistance() + " LENGTH: " + getLength() + " HEAD OFFSET: " + getHeadOffset() +" PREDEFINED: " + isPredefined();
  }

}
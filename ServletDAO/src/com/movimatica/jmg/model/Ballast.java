package com.movimatica.jmg.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author luca
 */
public class Ballast {
  
  private int id;
  private HashMap<String,String> name;
  private String image;
  private double weight;
  private double kgMm;
  private boolean predefined;

    public Ballast() {
    }

    public Ballast(int id, String name) {
        this(id,Translator.toMap(name),"",0,0,false);
    }

    public Ballast(int id, HashMap<String,String> name) {
        this(id,name,"",0,0,false);
    }

    public Ballast(int id, HashMap<String,String> name, String image, double weight, double kgMm, boolean predefined) {
	  this.id=id;
	  this.name=name;
	  this.image=image;
	  this.weight = weight;
	  this.kgMm = kgMm;
	  this.predefined = predefined;
  }
  
  public Ballast(ResultSet rs) throws SQLException{
	  this.id=rs.getInt("ballast_id");
	  this.name=Translator.toMap(rs.getString("ballast_name"));
	  this.image=rs.getString("image");
	  this.weight = rs.getDouble("ballast_weight");
	  this.kgMm = rs.getDouble("kgmm");
	  this.predefined = rs.getBoolean("predefined");
  }
  
  public int getId() {    return this.id;  }
  
  public HashMap<String,String> getName() {return this.name;}
  public void setName(String name) {this.name = Translator.toMap(name);}
  public void setName(HashMap<String,String> name) {this.name = name;}

  public String getImage(){return this.image;}
  public void setImage(String image){this.image=image;}
  
  public double getWeight() { return this.weight;  }
  public void setWeight(double kg) {this.weight=kg;}
  
  public double getKgMm() {return this.kgMm;}
  public void setKgMm (double kgmm) {this.kgMm = kgmm;}
  
  public boolean isPredefined() {return this.predefined;  }
  public void setPredefined(boolean predefined) {this.predefined=predefined;}
  
  public String toString(){
	   return "ID: " + getId() + ", NAME: " + getName() + " WEIGHT: " + getWeight() + " KGMM: " + getKgMm() + " PREDEFINED: " + isPredefined() + "\n";
  }
}


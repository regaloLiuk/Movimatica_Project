package com.movimatica.jmg.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author luca
 * 
 * Rappresenta tutte le famiglie di macchine JMG.
 *   Per ogni famiglia ci saranno N configurazioni differenti (ad esempio 'su gomma', 'su stabilizzatori')
 */
public class Family {

   private final int id;
   private final HashMap<String,String> name;
   private final String image;


   public Family(String jsonName){
       this(0, Translator.toMap(jsonName), "");
   }

   public Family(HashMap<String,String> names){
       this(0, names, "");
   }

   public Family(int id, final String name){
	   this(id,Translator.toMap(name),"");
   }

   public Family(int id, final HashMap<String,String> names){
	   this(id,names,"");
   }

   public Family(int id, HashMap<String,String> name , String image) {
       this.id = id;
	   this.name= name;
	   this.image=image;
   }
   
   public Family(ResultSet rs) throws SQLException{
       this.id = rs.getInt("family_id");
       this.name = Translator.toMap(rs.getString("family_name"));
       this.image=rs.getString("image");
   }
   
   public int getId(){   return this.id; }
   
   public HashMap<String, String> getName(){ return this.name;   }

   public String getImage(){return this.image;}
   
   public String toString(){
	   return "ID: " + getId() + ", NAME: " + getName() + "\n";
   }
   
}


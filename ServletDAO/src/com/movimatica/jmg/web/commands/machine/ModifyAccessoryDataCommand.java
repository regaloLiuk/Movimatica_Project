package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Accessory;
import com.movimatica.jmg.model.Machine;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ModifyAccessoryDataCommand extends FrontCommand {
	
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
    	
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		request.setAttribute("modify", true);
	    		Machine m = DAO.getMachineById(conn,ServletUtils.readInt(request, "machine"));
    			request.setAttribute("machine", m);
    			Accessory a = DAO.getAccessoryOfMachine(conn,m.getId(),ServletUtils.readInt(request, "accessory"));
    			request.setAttribute("accessory", a);
    			request.setAttribute("accessories", DAO.getAccessories(conn));
    			forward("/jmg/machine/page_modify_accessory");
		        return;
	    	}
		   Machine machine = DAO.getMachineById(conn, ServletUtils.readInt(request,"machine"));
		   Accessory accessory = DAO.getAccessoryById(conn, ServletUtils.readInt(request,"accessory"));

		   accessory.setWeight(ServletUtils.readDouble(request,"weight"));
		   accessory.setDistance(ServletUtils.readDouble(request,"distance"));
		   accessory.setLength(ServletUtils.readDouble(request,"length"));
		   accessory.setPredefined(ServletUtils.readBoolean(request,"predefined"));
		   HashMap<Integer, Integer> headPositions = new HashMap<>();
		   for(int i=0; i<=4; i++){
			   if (!ServletUtils.readString(request,"position"+i).isEmpty() && !ServletUtils.readString(request,"offset"+i).isEmpty()){
				   headPositions.put(ServletUtils.readInt(request,"position"+i),ServletUtils.readInt(request,"offset"+i));
			   }
		   }
		   for(int i=0; i<=4; i++){
			   if (!ServletUtils.readString(request,"newPosition"+i).isEmpty() && !ServletUtils.readString(request,"newOffset"+i).isEmpty()){
				   headPositions.put(ServletUtils.readInt(request,"newPosition"+i),ServletUtils.readInt(request,"newOffset"+i));
			   }
		   }
		   accessory.setHeadPosition(headPositions);

		   String headOffset = "";
		   for(Map.Entry<Integer,Integer> entry : headPositions.entrySet()){
		   		headOffset+=entry.getKey() + ":" + entry.getValue() + ",";
		   }
		   accessory.setHeadOffset(headOffset);
		   System.out.println(accessory.toString());

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch(DAO.modifyAccessoryOfMachine(conn,machine,accessory)){
    		case OK: 
     		   	System.out.println("*********** MODIFICA RIUSCITA **************");
    		   	this.redirect("/machine/details?id="+machine.getId());
	    		return;
			   case ERROR:
				   request.setAttribute("modify", false);
				   error.put("en", "madify failed");
				   error.put("it", "modifica fallita");
				   request.setAttribute("message",error);
				   System.out.println("INSERIMENTO NON RIUSCITO");
				   break;
			   case ERRDB:
				   request.setAttribute("modify", false);
				   error.put("en", "internal DB error");
				   error.put("it", "errore interno al DB");
				   request.setAttribute("message", error);
				   System.out.println("INSERIMENTO NON RIUSCITO");
				   break;
			   case NOTOK:
				   request.setAttribute("modify", false);
				   error.put("en", "error");
				   error.put("it", "errore");
				   request.setAttribute("message", error);
				   System.out.println("ERRORE");
				   break;
    	}
		    
    	this.request.setAttribute("machine", machine);
    	this.request.setAttribute("accessory", accessory);
    	this.request.setAttribute("accessories", DAO.getAccessories(conn));
    	forward("/jmg/machine/page_modify_accessory");	
 
    	}catch(SQLException e) {	System.out.println("Errore: " + e.getMessage());	}
    }
}
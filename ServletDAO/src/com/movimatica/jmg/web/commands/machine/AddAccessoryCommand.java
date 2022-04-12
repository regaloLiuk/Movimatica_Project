package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Accessory;
import com.movimatica.jmg.model.Ballast;
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

public class AddAccessoryCommand extends FrontCommand {
	
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		request.setAttribute("insert", true);
	    		request.setAttribute("machine", DAO.getMachineById(conn,ServletUtils.readInt(request, "machine")));
	    		request.setAttribute("accessories", DAO.getAccessories(conn));
	    		forward("/jmg/machine/page_add_accessory");
	    		return;
	    	}

		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   ServletFileUpload sfu = new ServletFileUpload(factory);
		   List<FileItem> formItems = sfu.parseRequest(request);
		   int accessory_id=0;
		   int machine_id=0;
		   String image="";
		   double weight=0;
		   double distance=0;
		   double length=0;
		   String headOffset="";
		   boolean predefined=false;
		   if (formItems != null && formItems.size() > 0) {
			   // iterates over form's fields
			   for (FileItem item : formItems) {
				   // processes only fields that are not form fields
				   if (!item.isFormField()) {
					   // generate base64 string
					   byte[] data = item.get();
					   image = Base64.getEncoder().encodeToString(data);
				   }
				   //processing regular form field
				   if (item.isFormField()) {
					   	switch (item.getFieldName()){
						   case "machine":
							   machine_id = Integer.parseInt(item.getString());
							   break;
						   case "accessory":
							   accessory_id = Integer.parseInt(item.getString());
							   break;
						   case "weight":
							   weight=Double.parseDouble(item.getString());
							   break;
						   case "distance":
							   distance=Double.parseDouble(item.getString());
							   break;
						   case "length":
							   length=Double.parseDouble(item.getString());
							   break;
						   case "position0":
						   	case "position1":
							case "position2":
							case "position3":
								if(!item.getString().isEmpty())
						   			headOffset+=item.getString() + ":";
						   		break;
						   case "offset0":
							case "offset1":
							case "offset2":
							case "offset3":
								if(!item.getString().isEmpty())
									headOffset+=item.getString()+",";
							case "predefined":
							   predefined=Boolean.parseBoolean(item.getString());
							   break;
					   }
				   }
			   }
		   }

		   Machine machine = DAO.getMachineById(conn, machine_id);
		   System.out.println(machine);
		   Accessory accessory = DAO.getAccessoryById(conn, accessory_id);
		   HashMap<Integer, Integer> headPositions = Accessory.getHashMap(headOffset);
		   accessory.setImage(image);
		   accessory.setWeight(weight);
		   accessory.setDistance(distance);
		   accessory.setLength(length);
		   accessory.setHeadOffset(headOffset);
		   accessory.setPredefined(predefined);
		   accessory.setHeadPosition(headPositions);
		   System.out.println(accessory.toString());
		   System.out.println("HASHMAP: " + headPositions);

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch(DAO.addAccessoryToMachine(conn,machine, accessory)){
			   case OK:
				   System.out.println("INSERIMENTO COMPLETATO");
				   this.redirect("/machine/details?id="+machine_id);
				   return;
			   case ERROR:
				   request.setAttribute("insert", false);
				   error.put("en", "insert failed");
				   error.put("it", "inserimento fallito");
				   request.setAttribute("message",error);
				   System.out.println("INSERIMENTO NON RIUSCITO");
				   break;
			   case DUPLICATE:
				   request.setAttribute("insert", false);
				   error.put("en", "the machine alreay have this accessory");
				   error.put("it", "la macchina possiede già questo accessorio");
				   request.setAttribute("message",error);
				   System.out.println("INSERIMENTO NON RIUSCITO");
				   break;
			   case ERRDB:
				   request.setAttribute("insert", false);
				   error.put("en", "internal DB error");
				   error.put("it", "errore interno al DB");
				   request.setAttribute("message", error);
				   System.out.println("INSERIMENTO NON RIUSCITO");
				   break;
			   case NOTOK:
				   request.setAttribute("insert", false);
				   error.put("en", "error");
				   error.put("it", "errore");
				   request.setAttribute("message", error);
				   System.out.println("ERRORE");
				   break;
		   }
		   this.request.setAttribute("machine", machine);
		   this.request.setAttribute("accessories", DAO.getAccessories(conn));
		   forward("/jmg/machine/page_add_accessory");
		   return;
    		
		}catch(SQLException | FileUploadException e) {System.out.println("Errore: " + e.getMessage());}
    }
}

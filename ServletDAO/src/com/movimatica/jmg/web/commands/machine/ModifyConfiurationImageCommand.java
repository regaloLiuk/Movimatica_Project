package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Family;
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

public class ModifyConfiurationImageCommand extends FrontCommand {
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){

		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   ServletFileUpload sfu = new ServletFileUpload(factory);
		   List<FileItem> formItems = sfu.parseRequest(request);
		   String newImage = "";
		   int id = 0;
		   if (formItems!=null && formItems.size()>0) {
			   // iterates over form's fields
			   for (FileItem item : formItems) {
				   // processes only fields that are not form fields
				   if (!item.isFormField()) {
					   // generate base64 string
					   byte[] data = item.get();
					   newImage = Base64.getEncoder().encodeToString(data);
				   }
				   //processing regular form field
				   if (item.isFormField()) {
					   id = Integer.parseInt(item.getString());
				   }
			   }
		   }
		   Machine machine = DAO.getMachineById(conn,id);
		   machine.setImage(newImage);

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch(DAO.updateMachineImage(conn,machine)){
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
		   this.request.setAttribute("families", DAO.getFamilies(conn));
		   forward("/jmg/machine/page_modify_configuration");
    	
    	}catch(SQLException | FileUploadException e) {	System.out.println("Errore: " + e.getMessage());	}
    }
}
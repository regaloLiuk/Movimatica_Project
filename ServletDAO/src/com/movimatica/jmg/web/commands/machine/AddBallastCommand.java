package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Ballast;
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

public class AddBallastCommand extends FrontCommand {
	
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
    	
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		request.setAttribute("insert", true);
	    		request.setAttribute("machine", DAO.getMachineById(conn,ServletUtils.readInt(request, "machine")));
	    		request.setAttribute("ballasts", DAO.getBallasts(conn));
	    		forward("/jmg/machine/page_add_ballast");
	    		return;
	    	}

		   int ballast_id=0;
		   int machine_id=0;
		   String image="";
		   double weight=0;
		   double kgMm=0;
		   boolean predefined=false;

		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   ServletFileUpload sfu = new ServletFileUpload(factory);
		   List<FileItem> formItems = sfu.parseRequest(request);
		   if (formItems != null && formItems.size() > 0) {	// iterates over form's fields
			   for (FileItem item : formItems) {
				   if (!item.isFormField()) {	// processes only fields that are not form fields
					   byte[] data = item.get();
					   image = Base64.getEncoder().encodeToString(data);	// generate base64 string
				   }
				   if (item.isFormField()) {	//processing regular form field
					   switch (item.getFieldName()) {
						   case "machine" -> machine_id = Integer.parseInt(item.getString());
						   case "ballast" -> ballast_id = Integer.parseInt(item.getString());
						   case "weight" -> weight = Double.parseDouble(item.getString());
						   case "kgmm" -> kgMm = Double.parseDouble(item.getString());
						   case "predefined" -> predefined = Boolean.parseBoolean(item.getString());
					   }
				   }
			   }
		   }
		   Machine machine = DAO.getMachineById(conn, machine_id);
		   Ballast ballast = DAO.getBallastById(conn, ballast_id);

		   if (machine!=null && ballast!=null){
			   ballast.setImage(image);
			   ballast.setWeight(weight);
			   ballast.setKgMm(kgMm);
			   ballast.setPredefined(predefined);

			   HashMap<String,String> error =  new HashMap<String,String>();
			   switch (DAO.addBallastToMachine(conn, ballast, machine)) {
				   case OK -> {
					   this.redirect("/machine/details?id=" + machine.getId());
					   return;
				   }case ERROR -> {
					   request.setAttribute("insert", false);
					   error.put("en", "insert failed");
					   error.put("it", "inserimento fallito");
					   request.setAttribute("message", error);
				   }case DUPLICATE -> {
					   request.setAttribute("insert", false);
					   error.put("en", "the machine alreay have this ballast");
					   error.put("it", "la macchina possiede già questa zavorra");
					   request.setAttribute("message", error);
				   }case ERRDB -> {
					   request.setAttribute("insert", false);
					   error.put("en", "internal DB error");
					   error.put("it", "errore interno al DB");
					   request.setAttribute("message", error);
				   }
			   }
		   }
		   this.request.setAttribute("machine", machine);
		   this.request.setAttribute("ballasts", DAO.getBallasts(conn));
		   forward("/jmg/machine/page_add_ballast");

		}catch(SQLException | FileUploadException e) {System.out.println("Errore: " + e.getMessage());}
    }
}

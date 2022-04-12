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

public class ModifyBallastDataCommand extends FrontCommand {
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
    	
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		Machine m = DAO.getMachineById(conn,ServletUtils.readInt(request, "machine"));
	    		request.setAttribute("modify", true);
    			request.setAttribute("machine", m);
    			request.setAttribute("ballast", DAO.getBallastOfMachine(conn,m.getId(),ServletUtils.readInt(request, "ballast")));
    			request.setAttribute("ballasts", DAO.getBallasts(conn));
    			forward("/jmg/machine/page_modify_ballast");
		        return;
	    	}

		   Machine machine = DAO.getMachineById(conn, ServletUtils.readInt(request,"machine"));
		   Ballast ballast = DAO.getBallastOfMachine(conn, ServletUtils.readInt(request,"machine"), ServletUtils.readInt(request,"ballast"));
		   ballast.setWeight(ServletUtils.readDouble(request,"weight"));
		   ballast.setKgMm(ServletUtils.readDouble(request,"kgmm"));
		   ballast.setPredefined(ServletUtils.readBoolean(request,"predefined"));

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch (DAO.modifyBallastOfMachine(conn, ballast, machine)) {
			   case OK:
				   System.out.println("MODIFICA COMPLETATA");
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
		   this.request.setAttribute("ballast", ballast);
		   this.request.setAttribute("ballasts", DAO.getBallasts(conn));
		   forward("/jmg/machine/page_modify_ballast");
 
	   }catch(SQLException e) {	System.out.println("Errore: " + e.getMessage());	}
    }
}
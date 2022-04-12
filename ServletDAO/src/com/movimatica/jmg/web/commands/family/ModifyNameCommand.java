package com.movimatica.jmg.web.commands.family;

import com.movimatica.jmg.model.Family;
import com.movimatica.jmg.model.Translator;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

public class ModifyNameCommand extends FrontCommand {
	
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
			if(request.getMethod().equalsIgnoreCase("get")) {
				request.setAttribute("family", DAO.getFamilyById(conn, ServletUtils.readInt(request, "id")));
				request.setAttribute("modify", true);
				forward("/jmg/family/page_modify");
				return;
			}
			int id = ServletUtils.readInt(request, "id");
		   	HashMap<String,String> map = new HashMap<>();
		   	for(int i=0; i<ServletUtils.readInt(request,"length"); i++){
			   if(!ServletUtils.readString(request,"lang"+i).isEmpty() && !ServletUtils.readString(request,"name"+i).isEmpty())
				   map.put(ServletUtils.readString(request,"lang"+i),ServletUtils.readString(request,"name"+i));
		   	}
			Family family = new Family(ServletUtils.readInt(request, "id"),map);

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch(DAO.updateFamilyName(conn,family)){
				case OK:
					System.out.println("*********** MODIFICA RIUSCITA **************");
					this.redirect("/family/show");
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
			this.request.setAttribute("family", DAO.getFamilyById(conn, ServletUtils.readInt(request, "id")));
			forward("/jmg/family/page_modify");
	   	}catch(SQLException e){
			System.out.println("********************ERRORE IN FAMILY.ModifyNameCommand***************** " + e.getMessage());
	   	}catch (Exception ex) {
		   request.setAttribute("message", "There was an error: " + ex.getMessage());
	   }
    }
	   
}
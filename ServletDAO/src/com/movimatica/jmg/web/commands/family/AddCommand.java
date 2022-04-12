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

public class AddCommand extends FrontCommand {
	
   @Override
   public void process() throws ServletException, IOException {
	   try (Connection conn = Connector.getConnection()) {
		   if (request.getMethod().equalsIgnoreCase("get")) {
		   		request.setAttribute("insert", true);
			   	forward("/jmg/family/page_add");
			   	return;
		   }
		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   ServletFileUpload sfu = new ServletFileUpload(factory);
		   List<FileItem> formItems = sfu.parseRequest(request);

		   HashMap<String,String> map = new HashMap<>();
		   String image = "";
		   String language = "";
		   String name = "";
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
							case "lang0":
							case "lang1":
							case "lang2":
								language=item.getString();
								break;
							case "name0":
							case "name1":
							case "name2":
								name=item.getString();
								break;
						}
						if (!language.isEmpty())
					   		map.put(language,name);
				   }
			   }
		   }
		   Family family = new Family(0, map, image);

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch (DAO.insertFamily(conn, family)) {
			   case OK:
				   System.out.println("INSERIMENTO COMPLETATO");
				   this.redirect("/family/show");
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
				   error.put("en", "this family alreay exixst");
				   error.put("it", "questa famiglia esiste già");
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
		   this.forward("/jmg/family/page_add");
		   return;
	   }catch (SQLException e) {
		   System.out.println("********************ERORE DAO.getFamilies*****************" + e.getMessage());
	   }catch (Exception ex) {
		   request.setAttribute("message", "There was an error: " + ex.getMessage());
	   }
   }
}

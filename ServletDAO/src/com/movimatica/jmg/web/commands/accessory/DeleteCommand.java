package com.movimatica.jmg.web.commands.accessory;

import com.movimatica.jmg.model.Accessory;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author luca
 */
public class DeleteCommand extends FrontCommand {
    @Override
    public void process() throws ServletException, IOException {
    	try(Connection conn = Connector.getConnection()){
			int id = ServletUtils.readInt(request, "id");
		    String msg = "";
		    String stat = "";
	//	    System.out.println(id);
		    
	        if(id>0) {
	        	switch(DAO.deleteAccessory(conn,new Accessory(id, "tmp"))){
	        		case OK: 
	        			stat = "OK";
	         		   	msg = "Rimozione Completata";
	         		   	request.setAttribute("stat", stat);
	         		   	request.setAttribute("msg", msg);
	         		   	System.out.println("*********** RIMOZIONE COMPLETATA **************");
	         		   	break;
	        		case ERROR:
	        			stat = "FAIL";
	         		   	msg = "Rimozione Fallita";
	         		   	request.setAttribute("stat", stat);
	         		   	request.setAttribute("msg", msg);
	         		   	System.out.println("*********** RIMOZIONE NON RIUSCITA **************");
	        			break;
	        		case ERRDB:
	        			stat = "FAIL";
	        		   	msg = "Rimozione Fallita - errore DB";
	        		   	request.setAttribute("stat", stat);
	        		   	request.setAttribute("msg", msg);
	        	    	System.out.println("*********** NO ID FOR DELETE **************");
	        			break;
	        		case NOTOK:
	        			stat = "FAIL";
	        		   	msg = "ERORE";
	        		   	request.setAttribute("stat", stat);
	        		   	request.setAttribute("msg", msg);
	        	    	System.out.println("*********** ERRORE **************");
	        			break;
	        	}
	        }else {
	        	stat = "FAIL";
			   	msg = "Rimozione Fallita - no id";
			   	request.setAttribute("stat", stat);
			   	request.setAttribute("msg", msg);
				System.out.println("*********** RIMOZIONE NON RIUSCITA **************");
	        }
	        
	        this.redirect("/accessory/show");
		    return;
    	}catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}

package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Family;
import com.movimatica.jmg.model.Machine;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author luca
 */
public class DeleteCommand extends FrontCommand {
	   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){		
			int id = ServletUtils.readInt(request, "id");
			int family = DAO.getMachineById(conn, id).getFamily().getId();
	        if(id>0) {
	        	switch(DAO.deleteMachine(conn,new Machine(id, new HashMap<>() , new Family(0,new HashMap<>(), "")))){
	        		case OK: 
	         		    request.setAttribute("error", true);
	         		   	request.setAttribute("msg", "Rimozione Completata");
	         		   	System.out.println("*********** RIMOZIONE COMPLETATA **************");
	         		   	break;
	        		case ERROR:
	        			request.setAttribute("error", true);
	         		   	request.setAttribute("msg", "Rimozione Fallita");
	         		   	System.out.println("*********** RIMOZIONE NON RIUSCITA **************");
	        			break;
	        		case ERRDB:
	        			request.setAttribute("error", true);
	        		   	request.setAttribute("msg", "Rimozione Fallita - errore DB");
	        	    	System.out.println("*********** NO ID FOR DELETE **************");
	        			break;
	        		case NOTOK:
	        			request.setAttribute("error", true);
	        		   	request.setAttribute("msg", "errore");
	        	    	System.out.println("*********** ERRORE**************");
	        			break;
	        	}
	        }else {
			   	request.setAttribute("error", true);
			   	request.setAttribute("msg", "Rimozione Fallita - no id");
				System.out.println("*********** RIMOZIONE NON RIUSCITA **************");
	        }
	        this.redirect("/machine/show?family="+family);
		    return;
	    }catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}

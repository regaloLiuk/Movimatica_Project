package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Ballast;
import com.movimatica.jmg.model.Machine;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class DeleteBallastCommand extends FrontCommand {
	@Override
   public void process() throws ServletException, IOException{
		try(Connection conn = Connector.getConnection()){		
			Machine m = DAO.getMachineById(conn,ServletUtils.readInt(request, "machine"));
			Ballast b = DAO.getBallastOfMachine(conn,m.getId(),ServletUtils.readInt(request, "ballast"));
			
		    String msg = "";
		    String stat = "";
	    
	        if(m.getId()>0 && b.getId()>0) {
	        	switch(DAO.removeBalastFromMachine(conn,m,b)){
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
	        		   	msg = "errore";
	        		   	request.setAttribute("stat", stat);
	        		   	request.setAttribute("msg", msg);
	        	    	System.out.println("*********** ERRORE**************");
	        			break;
	        	}
	        }else {
	        	stat = "FAIL";
			   	msg = "Rimozione Fallita - no id";
			   	request.setAttribute("stat", stat);
			   	request.setAttribute("msg", msg);
				System.out.println("*********** RIMOZIONE NON RIUSCITA **************");
	        }
	        
	        this.redirect("/machine/details?id="+m.getId());
		    return;
	    }catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}

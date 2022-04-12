package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Machine;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class DetailsCommand extends FrontCommand{
	
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
    		Machine m = DAO.getMachineById(conn,ServletUtils.readInt(request, "id"));
    		request.setAttribute("machine", m);
		    forward("/jmg/machine/page_details");
		    return;
    	}catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}

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
import java.util.List;

/**
 *
 * @author luca
 */
public class ShowCommand extends FrontCommand {
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
    		int family = ServletUtils.readInt(request, "family");
		   List<Machine> machines;
		   if(family>0) {
			   machines = DAO.getMachinesByFamily(conn, family);
		   }else {
			   machines = DAO.getMachines(conn);
		   }
		   request.setAttribute("family", family);
		   request.setAttribute("machines", machines);
		   forward("/jmg/machine/page_show");
		    return;
    	}catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}


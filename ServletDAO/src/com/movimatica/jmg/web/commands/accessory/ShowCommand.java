package com.movimatica.jmg.web.commands.accessory;

import com.movimatica.jmg.model.Accessory;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;

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
    public void process() throws ServletException, IOException {
      	try(Connection conn = Connector.getConnection()){
	    	List<Accessory> a = DAO.getAccessories(conn);
	    	request.setAttribute("accessories", a);
	    	System.out.println(a);
		    forward("/jmg/accessory/page_list");
      	}catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}


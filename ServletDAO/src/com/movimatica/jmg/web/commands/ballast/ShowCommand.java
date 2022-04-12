package com.movimatica.jmg.web.commands.ballast;

import com.movimatica.jmg.model.Ballast;
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
	    	List<Ballast> b = DAO.getBallasts(conn);
	    	request.setAttribute("ballast", b);
	    	//System.out.println(b);
		    forward("/jmg/ballast/page_list");
    	}catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}


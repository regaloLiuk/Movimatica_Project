package com.movimatica.jmg.web.commands.calculator;

import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author luca
 */
public class FamilyCommand extends FrontCommand {
	
    @Override
    public void process() throws ServletException, IOException{
    	try(Connection conn = Connector.getConnection()){
    		request.setAttribute("families", DAO.getFamilies(conn));
    	    forward("/jmg/calculator/page_select_family");
    	}catch(SQLException e){
    		System.out.println(e.getMessage());
    	}
    }
}


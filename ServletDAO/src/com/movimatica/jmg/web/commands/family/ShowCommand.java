package com.movimatica.jmg.web.commands.family;

import com.movimatica.jmg.model.Family;
import com.movimatica.jmg.model.Translator;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author luca
 */
public class ShowCommand extends FrontCommand {
	
    @Override
    public void process() throws ServletException, IOException{
    	try(Connection conn = Connector.getConnection()){
    		request.setAttribute("families", DAO.getFamilies(conn));
    	    forward("/jmg/family/page_list");
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getFamilies*****************" + e.getMessage());
    	}
    }
}


package com.movimatica.jmg.web.commands.calculator;

import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class ConfigurationCommand extends FrontCommand{
	public void process() throws ServletException, IOException{
		if(ServletUtils.readInt(request,"family")==0){
			this.redirect("/calculator/Family");
			return;
		}
		try(Connection conn = Connector.getConnection()){
		    	request.setAttribute("machines", DAO.getMachinesByFamily(conn,ServletUtils.readInt(request, "family")));
	    	    forward("/jmg/calculator/page_select_configuration");
			    return;
	    	}catch(SQLException e) {System.out.println(e.getMessage());}
	    }
}

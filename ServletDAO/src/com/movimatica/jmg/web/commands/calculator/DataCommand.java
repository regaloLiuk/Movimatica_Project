package com.movimatica.jmg.web.commands.calculator;

import com.movimatica.jmg.model.Accessory;
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

public class DataCommand extends FrontCommand{
	@Override
	   public void process() throws ServletException, IOException{
		   try(Connection conn = Connector.getConnection()){
			   if(ServletUtils.readInt(request,"machine")==0||ServletUtils.readInt(request,"ballast")==0||ServletUtils.readInt(request,"accessory")==0){
				   this.redirect("/calculator/Family");
				   return;
			   }
		   		Machine machine = DAO.getMachineById(conn,ServletUtils.readInt(request, "machine"));
			   	Accessory accessory = DAO.getAccessoryOfMachine(conn, machine.getId(), ServletUtils.readInt(request, "accessory"));
			   	Ballast ballast = DAO.getBallastOfMachine(conn, machine.getId(), ServletUtils.readInt(request, "ballast"));
			   
			   	if(!accessory.getHeadOffset().isEmpty()) {
			   		request.setAttribute("head_position", ServletUtils.readInt(request, "head_position"));
			   		request.setAttribute("head_positions", accessory.getHeadPositions());
			   		request.setAttribute("floating_head", true);
			   	}
			   	if(ServletUtils.readInt(request, "cargo")!=0 && ServletUtils.readInt(request, "radius")!=0 && ServletUtils.readInt(request, "altitude")!=0) {
			   		request.setAttribute("cargo", ServletUtils.readInt(request, "cargo")/1000);
		    		request.setAttribute("radius", ServletUtils.readInt(request, "radius")/1000);
		    		request.setAttribute("altitude", ServletUtils.readInt(request, "altitude")/1000);
		    		
			   	}
			   	request.setAttribute("machine", machine);
	    		request.setAttribute("accessory", accessory);
	    		request.setAttribute("ballast", ballast);
			    forward("/jmg/calculator/page_select_data");
			    return;
	    	}catch(SQLException e) {System.out.println(e.getMessage());}
	    }
}

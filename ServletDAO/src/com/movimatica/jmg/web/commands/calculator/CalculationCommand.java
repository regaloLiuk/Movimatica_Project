package com.movimatica.jmg.web.commands.calculator;

import com.movimatica.jmg.model.Accessory;
import com.movimatica.jmg.model.Ballast;
import com.movimatica.jmg.model.Calculator;
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

public class CalculationCommand extends FrontCommand{
	@Override
	   public void process() throws ServletException, IOException{
		   try(Connection conn = Connector.getConnection()){
			   if(ServletUtils.readInt(request,"machine")==0||ServletUtils.readInt(request,"ballast")==0||ServletUtils.readInt(request,"accessory")==0){
				   this.redirect("/calculator/Family");
				   return;
			   }
				Machine m = DAO.getMachineById(conn, ServletUtils.readInt(request, "machine"));
				Accessory a = DAO.getAccessoryOfMachine(conn, m.getId(), ServletUtils.readInt(request, "accessory"));
				Ballast b = DAO.getBallastOfMachine(conn, m.getId(), ServletUtils.readInt(request, "ballast"));

				Calculator c = new Calculator(ServletUtils.readDouble(request, "cargo"), ServletUtils.readDouble(request, "radius"), ServletUtils.readDouble(request, "altitude"),
						m, ServletUtils.readInt(request, "head_position"), b, a);
				request.setAttribute("calc", c);

				if(!a.getHeadOffset().isEmpty())
					request.setAttribute("floating_head",true);

			   	HashMap<String,String> error = new HashMap<>();

			   	if (!c.isValidrearAxisLoad()){
					request.setAttribute("show", false);
					error.put("en","the load to lift is to heavy");
					error.put("it","il carico da sollevare è troppo pesante");
					request.setAttribute("error", error);
					forward("/jmg/calculator/page_fine");
			   	}
			   	if (!c.isValidlbr()){
					request.setAttribute("show", false);
					error.put("en","lifting conditions beyond the tipping limit");
					error.put("it","condizioni di sollevamento oltre il limite di ribaltamento");
					request.setAttribute("error", error);
					forward("/jmg/calculator/page_fine");
			   	}

			   	if (!c.isValidSwingAngle()){
					request.setAttribute("show", false);
					error.put("en","the swing angle is incorrect");
					error.put("it","l'angolo di brandeggio non è corretto");
					request.setAttribute("error", error);
					forward("/jmg/calculator/page_fine");
			   	}

				request.setAttribute("show", true);
				request.setAttribute("acft", c.getFrontWheelCrushingArea());
				request.setAttribute("acrt", c.getRearWheelCrushingArea());
				request.setAttribute("gpfw", c.getFrontWheelGroungPressure());
				request.setAttribute("gprw", c.getRearWheelGroungPressure());
				//System.out.println("area schiaciamento gomma ant.: " +c.getFrontWheelCrushingArea() + " area schiaciamento gomma post.: " + c.getRearWheelCrushingArea() + " pressione suolo gomma ant.: " + c.getFrontWheelGroungPressure() + " pressione suolo gomma post.: " + c.getRearWheelGroungPressure());
			   	forward("/jmg/calculator/page_fine");
			    
	    	}catch(SQLException e) {}
	    }
}

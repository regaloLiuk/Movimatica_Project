package com.movimatica.jmg.web.commands.ballast;

import com.movimatica.jmg.model.Ballast;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

public class ModifyCommand extends FrontCommand {
    @Override
    public void process() throws ServletException, IOException {
    	try(Connection conn = Connector.getConnection()){
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		request.setAttribute("modify", true);
		    	request.setAttribute("ballast", DAO.getBallastById(conn, ServletUtils.readInt(request, "id")));
		    	//System.out.println(request.getParameter("oldId") + " " + request.getParameter("oldName"));
		        forward("/jmg/ballast/page_modify");
		        return;
	    	}

			int id = ServletUtils.readInt(request, "id");
			HashMap<String,String> map = new HashMap<>();
			for(int i=0; i<ServletUtils.readInt(request,"length"); i++){
				if(!ServletUtils.readString(request,"lang"+i).isEmpty() && !ServletUtils.readString(request,"name"+i).isEmpty())
					map.put(ServletUtils.readString(request,"lang"+i),ServletUtils.readString(request,"name"+i));
			}

			HashMap<String,String> error =  new HashMap<String,String>();

			switch(DAO.updateBallastName(conn, new Ballast(id, map))){
				case OK:
					System.out.println("*********** MODIFICA RIUSCITA **************");
					this.redirect("/ballast/show");
					return;
				case ERROR:
					request.setAttribute("modify", false);
					error.put("en", "madify failed");
					error.put("it", "modifica fallita");
					request.setAttribute("message",error);
					System.out.println("INSERIMENTO NON RIUSCITO");
					break;
				case ERRDB:
					request.setAttribute("modify", false);
					error.put("en", "internal DB error");
					error.put("it", "errore interno al DB");
					request.setAttribute("message", error);
					System.out.println("INSERIMENTO NON RIUSCITO");
					break;
				case NOTOK:
					request.setAttribute("modify", false);
					error.put("en", "error");
					error.put("it", "errore");
					request.setAttribute("message", error);
					System.out.println("ERRORE");
					break;
			}

		    this.request.setAttribute("ballast", DAO.getBallastById(conn, id));
	    	forward("/jmg/ballast/page_modify");	
    	}catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
    }
}
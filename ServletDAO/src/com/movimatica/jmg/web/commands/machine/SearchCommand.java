package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.web.FrontCommand;

import javax.servlet.ServletException;
import java.io.IOException;

/**
 *
 * @author luca
 */
public class SearchCommand extends FrontCommand {
   @Override
   public void process() throws ServletException, IOException{
	   /*try(Connection conn = Connector.getConnection()){
    		if(request.getMethod().equalsIgnoreCase("get")){
	    		this.request.setAttribute("stat", ServletUtils.readString(request, "stat"));
	    		this.request.setAttribute("msg", ServletUtils.readString(request, "msg"));
	    		request.setAttribute("machines", DAO.getMachines(conn));
				//System.out.println(DAO.getMachines());
			    this.forward("/jmg/machine/page_search");
			    return;
    		}
		    
    		String name = ServletUtils.readString(request, "name");
    		String family = ServletUtils.readString(request, "family");
    		System.out.println(name + " " + family);
    		//Machine m = new Machine();
    		if(!name.isEmpty()) {
    			List<Machine> m = DAO.getMachinesByName(conn,new Machine(name, new Family("tmp")));
    			request.setAttribute("machines", m);
    			//System.out.println(m);
    			this.forward("/jmg/machine/page_search");
    			return;
    		}
    		if(!family.isEmpty()) {
    			List<Machine> m = new ArrayList<Machine>();
    			m = DAO.getMachinesByFamily(conn,new Machine("tmp",new Family(family)));
    			request.setAttribute("machines", m);
    			//System.out.println(m);
    			this.forward("/jmg/machine/page_search");
    			return;
    		}
    		request.setAttribute("stat", "ERROR");
		    request.setAttribute("msg", "inserire nome o famiglia da cercare");
    		this.redirect("/machine/show");
    		return;
		}catch(SQLException e) {	System.out.println("Errore: " + e.getMessage());	}*/
    	
	}
}


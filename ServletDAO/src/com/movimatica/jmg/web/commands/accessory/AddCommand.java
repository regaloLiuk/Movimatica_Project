package com.movimatica.jmg.web.commands.accessory;

import com.movimatica.jmg.model.Accessory;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

public class AddCommand extends FrontCommand {
	
  @Override
  public void process() throws ServletException, IOException{
  	try(Connection conn = Connector.getConnection()){
  		request.setAttribute("add", true);
    	if(request.getMethod().equalsIgnoreCase("get")) {
    		forward("/jmg/accessory/page_add");
    		return;
    	}

		HashMap<String,String> map = new HashMap<>();
		for(int i=0; i<ServletUtils.readInt(request,"length"); i++){
			if(!ServletUtils.readString(request,"lang"+i).isEmpty() && !ServletUtils.readString(request,"name"+i).isEmpty())
				map.put(ServletUtils.readString(request,"lang"+i),ServletUtils.readString(request,"name"+i));
		}

		HashMap<String,String> error =  new HashMap<String,String>();

		switch(DAO.insertAccessory(conn,new Accessory(0,map))){
    		case OK: 
     		   	System.out.println("INSERIMENTO COMPLETATO");
     		   	this.redirect("/accessory/show");
     		   	return;
			case ERROR:
				request.setAttribute("insert", false);
				error.put("en", "insert failed");
				error.put("it", "inserimento fallito");
				request.setAttribute("message",error);
				System.out.println("INSERIMENTO NON RIUSCITO");
				break;
			case DUPLICATE:
				request.setAttribute("insert", false);
				error.put("en", "this accessory alreay exixst");
				error.put("it", "questo accessorio esiste già");
				request.setAttribute("message",error);
				System.out.println("INSERIMENTO NON RIUSCITO");
				break;
			case ERRDB:
				request.setAttribute("insert", false);
				error.put("en", "internal DB error");
				error.put("it", "errore interno al DB");
				request.setAttribute("message", error);
				System.out.println("INSERIMENTO NON RIUSCITO");
				break;
			case NOTOK:
				request.setAttribute("insert", false);
				error.put("en", "error");
				error.put("it", "errore");
				request.setAttribute("message", error);
				System.out.println("ERRORE");
				break;
    	}
        
		forward("/jmg/accessory/page_add");
		return;
    
    }catch(SQLException e) {System.out.println("Errore: " + e.getMessage());}
  }
}

package com.movimatica.jmg.web.commands.machine;

import com.movimatica.jmg.model.Family;
import com.movimatica.jmg.model.Machine;
import com.movimatica.jmg.web.Connector;
import com.movimatica.jmg.web.DAO;
import com.movimatica.jmg.web.FrontCommand;
import com.movimatica.util.ServletUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;

public class ModifyConfiurationDataCommand extends FrontCommand {
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		Machine m = DAO.getMachineById(conn,ServletUtils.readInt(request, "machine"));
	    			request.setAttribute("modify", true);
		    		request.setAttribute("machine", m);
			    	request.setAttribute("families", DAO.getFamilies(conn));
			    	forward("/jmg/machine/page_modify_configuration");
			        return;
	    	}
		   int id = ServletUtils.readInt(request, "id");
		   HashMap<String,String> map = new HashMap<>();
		   for(int i=0; i<ServletUtils.readInt(request,"length"); i++){
			   if(!ServletUtils.readString(request,"lang"+i).isEmpty() && !ServletUtils.readString(request,"name"+i).isEmpty())
				   map.put(ServletUtils.readString(request,"lang"+i),ServletUtils.readString(request,"name"+i));
		   }
		   Family fam = DAO.getFamilyById(conn,ServletUtils.readInt(request,"family"));
		   Machine machine = new Machine(id,map,fam);
		   machine.setMinArmLength(ServletUtils.readDouble(request,"min_arm_lh"));
		   machine.setMaxArmLength(ServletUtils.readDouble(request,"max_arm_lh"));
		   machine.setMinSwing(ServletUtils.readDouble(request,"min_swing"));
		   machine.setMaxSwing(ServletUtils.readDouble(request,"max_swing"));
		   machine.setFrontWheel(ServletUtils.readInt(request,"front_wheel"));
		   machine.setRearWheel(ServletUtils.readInt(request,"rear_wheel"));
		   machine.setPlateArea(ServletUtils.readDouble(request,"plate_area"));
		   machine.setMultiplierDistanceHubToArm(ServletUtils.readDouble(request,"mdha"));
		   machine.setOffsetDistanceHubToArm(ServletUtils.readDouble(request,"odha"));
		   machine.setOnTyre(ServletUtils.readBoolean(request,"tyre"));
		   machine.setWheelBase(ServletUtils.readDouble(request,"wheel_base"));
		   machine.setMultiplierFrontGroundPressure(ServletUtils.readDouble(request,"mfgp"));
		   machine.setOffsetFrontGroudPressure(ServletUtils.readDouble(request,"ofgp"));
		   machine.setMultiplierRearGroudPressure(ServletUtils.readDouble(request,"mrgp"));
		   machine.setOffsetRearGroudPressure(ServletUtils.readDouble(request,"orgp"));
		   machine.setBatteryWeight(ServletUtils.readDouble(request,"battery_weight"));
		   machine.setEmptyWeight(ServletUtils.readDouble(request,"empty_weight"));
		   machine.setArmWeight(ServletUtils.readDouble(request,"arm_weight"));
		   machine.setDf(ServletUtils.readDouble(request,"df"));
		   machine.setDs(ServletUtils.readDouble(request,"ds"));
		   machine.setDvg(ServletUtils.readDouble(request,"dvg"));
		   machine.setDb(ServletUtils.readDouble(request,"db"));
		   machine.setHf(ServletUtils.readDouble(request,"hf"));

		   System.out.println("MACCHINA: " + machine.toString());

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch(DAO.updateMachine(conn,machine)){
	    		case OK: 
	     		   	System.out.println("*********** MODIFICA RIUSCITA **************");
	     		   	this.redirect("/machine/details?id="+machine.getId());
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
			    
		   this.request.setAttribute("machine", machine);
		   this.request.setAttribute("families", DAO.getFamilies(conn));
		   forward("/jmg/machine/page_modify_configuration");
    	
    	}catch(SQLException e) {	System.out.println("Errore: " + e.getMessage());	}
    }
}
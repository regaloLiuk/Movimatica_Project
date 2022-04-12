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

public class AddConfigurationCommand extends FrontCommand {
	
   @Override
   public void process() throws ServletException, IOException{
	   try(Connection conn = Connector.getConnection()){
	    	if(request.getMethod().equalsIgnoreCase("get")) {
	    		if(ServletUtils.readInt(request, "family")!=0) {
	    			System.out.println("+++++++++++++++ "+ServletUtils.readInt(request, "family"));
					request.setAttribute("family", ServletUtils.readInt(request, "family"));
				}
	    		request.setAttribute("insert", true);
	    		request.setAttribute("families", DAO.getFamilies(conn));
	    		forward("/jmg/machine/page_add_configration");
	    		return;
	    	}
		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   ServletFileUpload sfu = new ServletFileUpload(factory);
		   List<FileItem> formItems = sfu.parseRequest(request);
		   Machine machine = new Machine("",new Family(""));
		   HashMap<String,String> map = new HashMap<String,String>();
		   String image = "";
		   String language = "";
		   String name = "";
		   if (formItems != null && formItems.size() > 0) {
			   // iterates over form's fields
			   for (FileItem item : formItems) {
				   // processes only fields that are not form fields
				   if (!item.isFormField()) {
					   // generate base64 string
					   byte[] data = item.get();
					   image = Base64.getEncoder().encodeToString(data);
					   machine.setImage(image);
				   }
				   //processing regular form field
				   if (item.isFormField()) {
					   switch (item.getFieldName()){
						   case "lang0":
						   case "lang1":
						   case "lang2":
							   language=item.getString();
							   break;
						   case "name0":
						   case "name1":
						   case "name2":
							   name=item.getString();
							   break;
						   case "family":
							   	machine.setFamily(DAO.getFamilyById(conn, Integer.parseInt(item.getString())));
							   	break;
						   case "min_arm_lh":
						   		machine.setMinArmLength(Double.parseDouble(item.getString()));
						   		break;
						   case "max_arm_lh":
						   		machine.setMaxArmLength(Double.parseDouble(item.getString()));
						   		break;
						   case "min_swing":
							   	machine.setMinSwing(Double.parseDouble(item.getString()));
						   		break;
						   case "max_swing":
							   	machine.setMaxSwing(Double.parseDouble(item.getString()));
						   		break;
						   case "front_wheel":
							   	machine.setFrontWheel(Integer.parseInt(item.getString()));
						   		break;
						   case "rear_wheel":
							   	machine.setRearWheel(Integer.parseInt(item.getString()));
						   		break;
						   case "plate_area":
							   	machine.setPlateArea(Double.parseDouble(item.getString()));
						   		break;
						   case "mdha":
							   	machine.setMultiplierDistanceHubToArm(Double.parseDouble(item.getString()));
						   		break;
						   case "odha":
							   	machine.setOffsetDistanceHubToArm(Double.parseDouble(item.getString()));
						   		break;
						   case "tyre":
							   	machine.setOnTyre(Boolean.parseBoolean(item.getString()));
						   		break;
						   case "wheel_base":
							   	machine.setWheelBase(Double.parseDouble(item.getString()));
						   		break;
						   case "mfgp":
							   	machine.setMultiplierFrontGroundPressure(Double.parseDouble(item.getString()));
						   		break;
						   case "ofgp":
							   	machine.setOffsetFrontGroudPressure(Double.parseDouble(item.getString()));
						   		break;
						   case "mrgp":
							   	machine.setMultiplierRearGroudPressure(Double.parseDouble(item.getString()));
						   		break;
						   case "orgp":
							   	machine.setOffsetRearGroudPressure(Double.parseDouble(item.getString()));
						   		break;
						   case "battery_weight":
							   	machine.setBatteryWeight(Double.parseDouble(item.getString()));
						   		break;
						   case "empty_weight":
							   	machine.setEmptyWeight(Double.parseDouble(item.getString()));
						   		break;
						   case "arm_weight":
							   	machine.setArmWeight(Double.parseDouble(item.getString()));
						   		break;
						   case "df":
							   machine.setDf(Double.parseDouble(item.getString()));
							   break;
						   case "ds":
							   machine.setDs(Double.parseDouble(item.getString()));
							   break;
						   case "dvg":
							   machine.setDvg(Double.parseDouble(item.getString()));
							   break;
						   case "db":
							   machine.setDb(Double.parseDouble(item.getString()));
							   break;
						   case "hf":
							   machine.setHf(Double.parseDouble(item.getString()));
							   break;
					   }
					   if (!language.isEmpty())
						   map.put(language,name);
				   }
			   }
		   }
		   machine.setName(map);
		   if(image.isEmpty())
			   System.out.println("NO IMAGE");
		   else
		   		System.out.println("IMMAGE");
		   System.out.println("MACCHINA: " + machine.toString());

		   HashMap<String,String> error =  new HashMap<String,String>();

		   switch(DAO.insertMachine(conn,machine)){
				case OK:
					System.out.println("INSERIMENTO COMPLETATO");
					//Machine m = DAO.getMachineByName(conn,machine);
					this.redirect("/machine/show?family="+machine.getFamily().getId());
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
				   error.put("en", "this machine alreay exist");
				   error.put("it", "la macchina possiede già questo accessorio");
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
		   this.request.setAttribute("families", DAO.getFamilies(conn));
		   this.request.setAttribute("ballast", DAO.getBallasts(conn));
		   forward("/jmg/machine/page_add_configuration");
		   return;
    		
		}catch(SQLException | FileUploadException e) {System.out.println("Errore: " + e.getMessage());}
    }
}
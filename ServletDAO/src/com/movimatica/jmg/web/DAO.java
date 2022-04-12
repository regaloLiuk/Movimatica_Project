package com.movimatica.jmg.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.movimatica.jmg.model.*;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author luca
 */
public class DAO {
	
	public enum State{
		OK(0), ERROR(-1), NOTFOUND(-2), ERRDB(-3), DUPLICATE(-4), NOTOK(-99);
		
		private int val;
		
		private State(int val) {	this.val=val;	}	
		
		public int getVal() {	return val;	}
		
	}

    /******************************* FAMILY ******************************************/
    
    public static List<Family> getFamilies(Connection conn){
    	List<Family> families = new ArrayList<Family>();
    	try (java.sql.Statement st=conn.createStatement();
			 ResultSet rs = st.executeQuery("SELECT * FROM family")){
		        while(rs.next()) {
		        	families.add(new Family(rs));
		        }
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getFamilies*****************" + e.getMessage());
    		return null;
    	}
    	return families;
    }
    
    /*public static List<Family> getFamiliesByName(Connection conn, Family family){
    	List<Family> fam = new ArrayList<Family>();
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM FAMILY WHERE family_name LIKE ? ORDER BY family_name ASC");){
	        	ps.setString(1, family.getName()+"%");
	        	ResultSet rs = ps.executeQuery();
	        	while(rs.next()) {
	        		fam.add(new Family(rs));
	        	}
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getFamiliesByName*****************" + e.getMessage());
    		return null;
    	}
    	return fam;
    }*/
    
    public static Family getFamilyById(Connection conn, int id){
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM family WHERE family_id = ? ORDER BY family_name ASC")){
    			ps.setInt(1, id);
		        ResultSet rs = ps.executeQuery();
		        rs.next();
		        return new Family(rs);
    	}catch(SQLException e){System.out.println("********************ERRORE DAO.getFamilyById*****************" + e.getMessage());}
    	return null;
    }
    
    public static State insertFamily(Connection conn, Family family){
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("INSERT INTO family (family_name, image) VALUES (?, ?)")){
		    		ps.setString(1, Translator.toJson(family.getName()).toString());
		    		ps.setString(2, family.getImage());
	        		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.insertFamily*****************" + e.getMessage());
    		result = State.ERRDB; 
    	}
    	return result;
    }
    
    public static State deleteFamily(Connection conn, Family family){
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("DELETE FROM family WHERE family_id = ?")){
	        		ps.setInt(1, family.getId());
	        		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.deleteFamily*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    /*public static boolean deleteFamilyFromName(String name){
    	try {
	    	Connection conn = DriverManager.getConnection(url, user, password);
	    	java.sql.Statement st = conn.createStatement();
	    	st.executeUpdate("DELETE FROM FAMILY WHERE family_name = '" + name + "'");
	        conn.close();
	        st.close();
	        
	        return true;
	        
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.DELETE FAMILIES FROM NAME*****************" + e.getMessage());
    		return false;
    	}
    }*/
    
    public static State updateFamilyName(Connection conn, Family family){
    	State result = State.NOTOK;
    	try(PreparedStatement ps = conn.prepareStatement("UPDATE family SET family_name=? WHERE family_id = ?")) {
		    		ps.setString(1, Translator.toJson(family.getName()).toString());
		    		ps.setInt(2, family.getId());
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.updateFamilyName*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
	public static State updateFamilyImage(Connection conn, Family family){
		State result = State.NOTOK;
		try(PreparedStatement ps = conn.prepareStatement("UPDATE family SET image=? WHERE family_id = ?")) {
			ps.setObject(1, family.getImage());
			ps.setInt(2, family.getId());
			result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		}catch(SQLException e){
			System.out.println("********************ERORE DAO.updateFamilyName*****************" + e.getMessage());
			result = State.ERRDB;
		}
		return result;
	}
    
    /*private static boolean existFamilyName(Connection conn, Family family) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM family WHERE family_name = ?")){
    		ps.setString(1, family.getName());
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    		
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.existFamilyName*****************" + e.getMessage());
    	}
    	return false;
    }*/
    
    /*private static boolean existFamily(Connection conn, int id) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM family WHERE family_id = ?")){
    		ps.setInt(1, id);
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.existFamily*****************" + e.getMessage());
    	}
    	return false;
    }*/

/************************************************************** MACCHINE *******************************************************************************/
    
    public static List<Machine> getMachines(Connection conn) throws SQLException{
    	List<Machine> m = new ArrayList<Machine>();
    	try (java.sql.Statement st = conn.createStatement();){
	        ResultSet rs = st.executeQuery("SELECT * FROM machine JOIN family ON (machine.family_id = family.family_id) ORDER BY machine_name ASC");
	        while(rs.next()) {
	        	Machine machine = new Machine(rs);
		        machine.setAccessories(getAccessoriesByMachine(conn, machine.getId()));
		        machine.setBallasts(getBallastsByMachine(conn, machine.getId()));
	        	m.add(machine);
	        }
	        rs.close();
	        return m;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getMachines*****************" + e.getMessage()); return null;}
    }
    
    /*public static List<Machine> getMachinesByName(Connection conn,Machine machine) throws SQLException{
    	List<Machine> m = new ArrayList<Machine>();
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM machine JOIN FAMILY ON (machine.family_id = family.family_id) WHERE machine_name LIKE ? ORDER BY machine_name ASC")){
	        	ps.setString(1, machine.getName()+"%");
	    		ResultSet rs = ps.executeQuery();
		        while(rs.next()) {
		        	Machine mach = new Machine(rs);
			        mach.setAccessories(getAccessoriesByMachine(conn, mach.getId()));
			        mach.setBallasts(getBallastsByMachine(conn, mach.getId()));
		        	m.add(mach);
		        }
		        return m;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getMachinesByName*****************" + e.getMessage()); return null;}
    }*/
    
   /* public static Machine getMachineByName(Connection conn,Machine machine) throws SQLException{
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM machine JOIN FAMILY ON (machine.family_id = family.family_id) WHERE machine_name = ?")){
	        	ps.setString(1, machine.getName());
	    		ResultSet rs = ps.executeQuery();
	    		if(rs.next()) {
	    			Machine mach = new Machine(rs);
			        mach.setAccessories(getAccessoriesByMachine(conn, mach.getId()));
			        mach.setBallasts(getBallastsByMachine(conn, mach.getId()));
	    			return mach;
	    		}
	    			System.out.println("no machine for name: " + machine.getName());
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getMachineByName*****************" + e.getMessage());}
    	return null;
    }*/
    
    public static Machine getMachineById(Connection conn, int id) throws SQLException{
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM public.machine JOIN family ON (machine.family_id = family.family_id) WHERE machine_id = ?")){
    			ps.setInt(1, id);
	    		ResultSet rs = ps.executeQuery();
	    		rs.next();
	    		Machine machine = new Machine(rs);
		        machine.setAccessories(getAccessoriesByMachine(conn, machine.getId()));
		        machine.setBallasts(getBallastsByMachine(conn, machine.getId()));
    			return machine;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getMachineById*****************" + e.getMessage()); return null;}
    }
    
    /*public static List<Machine> getMachinesByFamily(Connection conn, Machine machine) throws SQLException{
    	List<Machine> m = new ArrayList<Machine>();
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM machine JOIN family ON (machine.family_id = family.family_id) WHERE family_name LIKE ? ORDER BY machine_name ASC")){
    			ps.setString(1, machine.getFamily().getName()+"%");
	    		ResultSet rs = ps.executeQuery();
		        while(rs.next()) {
		        	Machine mach = new Machine(rs);
			        mach.setAccessories(getAccessoriesByMachine(conn, mach.getId()));
			        mach.setBallasts(getBallastsByMachine(conn, mach.getId()));
		        	m.add(mach);
		        }
		        return m;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getMachinesByFamily(Machine machine)*****************" + e.getMessage()); return null;}
    }*/
    
    public static List<Machine> getMachinesByFamily(Connection conn,int family) throws SQLException{
    	List<Machine> m = new ArrayList<Machine>();
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM public.machine JOIN family ON (machine.family_id = family.family_id) WHERE machine.family_id = ? ORDER BY machine_name ASC")){
    			ps.setInt(1, family);
	    		ResultSet rs = ps.executeQuery();
		        while(rs.next()) {
		        	Machine machine = new Machine(rs);
			        machine.setAccessories(getAccessoriesByMachine(conn, machine.getId()));
			        machine.setBallasts(getBallastsByMachine(conn, machine.getId()));
		        	m.add(machine);
		        }
		        return m;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getMachinesByFamily(int family)*****************" + e.getMessage()); return null;}
    }
    
    /*public static int insertEmptyMachine(Machine mach) throws SQLException{
    	int result = -99;
    	try (Connection conn = DriverManager.getConnection(url, user, password);
    		PreparedStatement ps = conn.prepareStatement("INSERT INTO machine (machine_id, machine_name, family) VALUES (?, ?, ?)")){
	        	ps.setInt(1, mach.getId());
	        	ps.setString(2, mach.getName());
	        	ps.setInt(3, mach.getFamily().getId());
	        	result = ps.executeUpdate()==1 ? 0 : -1;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.INSERT MACCHINE()*****************" + e.getMessage());}
    	return result;
    }*/
    
    public static State insertMachine(Connection conn,Machine machine) throws SQLException{
    	State result = State.NOTOK;
    	String query = "INSERT INTO machine (machine_name, family_id, image, min_arm_lh, max_arm_lh, min_swing, max_swing, front_wheel, rear_wheel, plate_area, "
				+ "multiplier_distance_hub_to_arm, offset_distance_hub_to_arm, on_tyre, wheel_base, multiplier_front_ground_pressure, multiplier_rear_groud_pressure, "
				+ "offset_front_groud_pressure, offset_rear_groud_pressure, battery_weight, empty_weight, arm_weight, distance_arm_hub_rotation_center, "
				+ "distance_sheld_roation_center, distance_cog_empty_machine_rotation_center, distance_cog_battery_rotation_center_mm, distance_arm_hub_ground_mm) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    	try (PreparedStatement ps = conn.prepareStatement(query)){
    			ps.setString(1, Translator.toJson(machine.getName()).toString());
    			ps.setInt(2, machine.getFamily().getId());
    			ps.setString(3, machine.getImage());
    			ps.setDouble(4, machine.getMinArmLength());
    			ps.setDouble(5, machine.getMaxArmLength());
    			ps.setDouble(6, machine.getMinSwing());
    			ps.setDouble(7, machine.getMaxSwing());
    			ps.setInt(8, machine.getFrontWheel());
    			ps.setInt(9, machine.getRearWheel());
    			ps.setDouble(10, machine.getPlateArea());
    			ps.setDouble(11, machine.getMultiplierDistanceHubToArm());
    			ps.setDouble(12, machine.getOffsetDistanceHubToArm());
    			ps.setBoolean(13, machine.isOnTyre());
    			ps.setDouble(14, machine.getWheelBase());
    			ps.setDouble(15, machine.getMultiplierFrontGroundPressure());
    			ps.setDouble(16, machine.getMultiplierRearGroudPressure());
    			ps.setDouble(17, machine.getOffsetFrontGroudPressure());
    			ps.setDouble(18, machine.getOffsetRearGroudPressure());
    			ps.setDouble(19, machine.getBatteryWeight());
    			ps.setDouble(20, machine.getEmptyWeight());
    			ps.setDouble(21, machine.getArmWeight());
    			ps.setDouble(22, machine.getDf());
    			ps.setDouble(23, machine.getDs());
    			ps.setDouble(24, machine.getDvg());
    			ps.setDouble(25, machine.getDb());
    			ps.setDouble(26, machine.getHf());
    			result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e) {
    		System.out.println("********************ERORE DAO.insertMachine*****************" + e.getMessage());
    		result = State.ERRDB;
		}
    	return result;
    }
    
    public static State deleteMachine(Connection conn,Machine machine) throws SQLException{
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("DELETE FROM machine WHERE machine_id = ?")){
	    		ps.setInt(1, machine.getId());
	    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e) {
    		System.out.println("********************ERORE DAO.deleteMachine*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    /*public static boolean deleteMachineFromName(String name) throws SQLException{
    	try {
	    	Connection conn = DriverManager.getConnection(url, user, password);
	    	java.sql.Statement st = conn.createStatement();
	        st.executeUpdate("DELETE FROM machine WHERE machine_name = '" + name + "'");
	        conn.close();
	        st.close();
	        return true;
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.deleteMachineFromName*****************" + e.getMessage()); return false;}
    }*/

    public static State updateMachine(Connection conn,Machine machine){
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("UPDATE machine SET machine_name = ?, family_id = ?, min_arm_lh = ?, max_arm_lh = ?, min_swing = ?, max_swing = ?, front_wheel = ?, rear_wheel = ?, "
			+ "plate_area = ?, multiplier_distance_hub_to_arm = ?, offset_distance_hub_to_arm = ?, on_tyre = ?, wheel_base = ?, multiplier_front_ground_pressure  = ?, "
			+ "multiplier_rear_groud_pressure = ?, offset_front_groud_pressure = ?, offset_rear_groud_pressure = ?, battery_weight = ?, empty_weight = ?, arm_weight = ?, "
			+ "distance_arm_hub_rotation_center = ?, distance_sheld_roation_center = ?, distance_cog_empty_machine_rotation_center = ?, "
			+ "distance_cog_battery_rotation_center_mm = ?, distance_arm_hub_ground_mm = ? WHERE machine_id = ?")){
    				ps.setString(1, Translator.toJson(machine.getName()).toString());
    				ps.setInt(2, machine.getFamily().getId());
    				ps.setDouble(3, machine.getMinArmLength());
        			ps.setDouble(4, machine.getMaxArmLength());
        			ps.setDouble(5, machine.getMinSwing());
        			ps.setDouble(6, machine.getMaxSwing());
        			ps.setInt(7, machine.getFrontWheel());
        			ps.setInt(8, machine.getRearWheel());
        			ps.setDouble(9, machine.getPlateArea());
        			ps.setDouble(10, machine.getMultiplierDistanceHubToArm());
        			ps.setDouble(11, machine.getOffsetDistanceHubToArm());
        			ps.setBoolean(12, machine.isOnTyre());
        			ps.setDouble(13, machine.getWheelBase());
        			ps.setDouble(14, machine.getMultiplierFrontGroundPressure());
        			ps.setDouble(15, machine.getMultiplierRearGroudPressure());
        			ps.setDouble(16, machine.getOffsetFrontGroudPressure());
        			ps.setDouble(17, machine.getOffsetRearGroudPressure());
        			ps.setDouble(18, machine.getBatteryWeight());
        			ps.setDouble(19, machine.getEmptyWeight());
        			ps.setDouble(20, machine.getArmWeight());
        			ps.setDouble(21, machine.getDf());
        			ps.setDouble(22, machine.getDs());
        			ps.setDouble(23, machine.getDvg());
        			ps.setDouble(24, machine.getDb());
        			ps.setDouble(25, machine.getHf());
        			ps.setInt(26, machine.getId());
        			result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.updateMachine*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }

	public static State updateMachineImage(Connection conn,Machine machine){
		State result = State.NOTOK;
		try (PreparedStatement ps = conn.prepareStatement("UPDATE machine SET image=? WHERE machine_id = ?")){
			ps.setString(1, machine.getImage());
			ps.setInt(2, machine.getId());
			result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		}catch(SQLException e){
			System.out.println("********************ERORE DAO.updateMachine*****************" + e.getMessage());
			result = State.ERRDB;
		}
		return result;
	}

    /*private static boolean existMachineName(Connection conn, Machine machine) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT * FROM machine WHERE machine_name = ?")){
    		ps.setString(1, machine.getName());
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.existMachineName*****************" + e.getMessage());
    	}
    	return false;
    }*/
    
    /*private static boolean existMachine(Connection conn, int id) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM machine WHERE machine_id = ?")){
    		ps.setInt(1, id);
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.existMachine*****************" + e.getMessage());
    	}
    	return false;
    }*/
    
    /****************************************************** BALLAST ********************************************************/

    public static List<Ballast> getBallasts(Connection conn){
    	List<Ballast> ballast = new ArrayList<Ballast>();
    	try (java.sql.Statement st = conn.createStatement();){
		        ResultSet rs = st.executeQuery("SELECT * FROM public.ballast");
		        while(rs.next()) {
		        	ballast.add(new Ballast(rs.getInt("ballast_id"), rs.getString("ballast_name")));
		        }
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getBallasts*****************" + e.getMessage());
    		return null;
    	}
    	return ballast;
    }
    
    public static Ballast getBallastById(Connection conn,int id){
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM public.ballast WHERE ballast_id = ?");){
    			ps.setInt(1, id);
		        ResultSet rs = ps.executeQuery();
		        rs.next();
		        return new Ballast(rs.getInt("ballast_id"), rs.getString("ballast_name"));
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getBallastById*****************" + e.getMessage());
    		return null;
    	}
    }
    
    public static Ballast getBallastOfMachine(Connection conn, int machine, int ballast){
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM ballast JOIN machine_ballast ON (ballast.ballast_id  = machine_ballast.ballast_id) WHERE machine_ballast.ballast_id=? AND machine_ballast.machine_id=?");){
    			ps.setInt(1, ballast);
    			ps.setInt(2, machine);
		        ResultSet rs = ps.executeQuery();
		        rs.next();
		        return new Ballast(rs);
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getBallastInMachineById*****************" + e.getMessage());
    		return null;
    	}
    }
    
    public static List<Ballast> getBallastsByMachine(Connection conn,int machine) throws SQLException{
    	List<Ballast> ballasts = new ArrayList<Ballast>();
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM ballast JOIN machine_ballast ON (ballast.ballast_id = machine_ballast.ballast_id) WHERE machine_id = ? ORDER BY ballast_name ASC")){
    			ps.setInt(1, machine);
	    		ResultSet rs = ps.executeQuery();
	    		while(rs.next()) {
	    			ballasts.add(new Ballast(rs));
	    		}
	    		return ballasts;
		        
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getBallastsByMachine****************" + e.getMessage());}
    	 return null;
    }
    
    public static State insertBallast(Connection conn,Ballast ballast) {
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("INSERT INTO ballast (ballast_name) VALUES (?)");){
		    		ps.setString(1, Translator.toJson(ballast.getName()).toString());
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.insertBallast*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State deleteBallast(Connection conn,Ballast ballast){
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("DELETE FROM ballast WHERE ballast_id = ?");){
	        		ps.setInt(1, ballast.getId());
	        		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.deleteBallast*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State updateBallastName(Connection conn,Ballast ballast){
    	State result = State.NOTOK;
    	try(PreparedStatement ps = conn.prepareStatement("UPDATE ballast SET ballast_name = ? WHERE ballast_id = ?")) {
		    		ps.setString(1, Translator.toJson(ballast.getName()).toString());
		    		ps.setInt(2, ballast.getId());
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.updateBallastName*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State addBallastToMachine(Connection conn, Ballast ballast, Machine machine) {
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("INSERT INTO machine_ballast (machine_id, ballast_id, image, ballast_weight, kgmm, predefined) VALUES (?,?,?,?,?,?)");
    		PreparedStatement ps1 = conn.prepareStatement("UPDATE machine_ballast SET predefined=false WHERE machine_id=?")){
    				if(ballast.isPredefined()) {
    					ps1.setInt(1, machine.getId());
    					ps1.executeUpdate();
    				}
		    		ps.setInt(1, machine.getId());
		    		ps.setInt(2, ballast.getId());
		    		ps.setString(3, ballast.getImage());
		    		ps.setDouble(4, ballast.getWeight());
		    		ps.setDouble(5, ballast.getKgMm());
		    		ps.setBoolean(6, ballast.isPredefined());
		       		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.addBallastToMachine*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State removeBalastFromMachine(Connection conn,Machine machine, Ballast ballast) throws SQLException{
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("DELETE FROM machine_ballast WHERE machine_id = ? AND ballast_id = ?")){
	    		ps.setInt(1, machine.getId());
	    		ps.setInt(2, ballast.getId());
	    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e) {
    		System.out.println("********************ERORE DAO.removeBalastFromMachine*****************" + e.getMessage());
    		result = State.ERRDB;
		}
    	return result;
    }
    
    
    public static State modifyBallastOfMachine(Connection conn,Ballast ballast, Machine machine) {
    	State result = State.NOTOK;
    	try {
				result = removeBalastFromMachine(conn,machine, ballast)==State.OK && addBallastToMachine(conn,ballast, machine)==State.OK ? State.OK : State.ERROR;
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.changeBallastOfMachine*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    /*private static boolean existBallastName(Connection conn, Ballast ballast) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM ballast WHERE ballast_name = ?")){
    		ps.setString(1, ballast.getName());
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.existBallastName*****************" + e.getMessage());
    	}
    	return false;
    }*/
    
    /*private static boolean machineHaveBallast(Connection conn, Machine machine, Ballast ballast) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM machine_ballast WHERE machine_id = ? AND ballast_id = ?")){
    		ps.setInt(1, machine.getId());
    		ps.setInt(2, ballast.getId());
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.machineHaveBallast*****************" + e.getMessage());
    	}
    	return false;
    }*/

    /******************************************* ACCESSORY **********************************************************************/
    
    public static List<Accessory> getAccessories(Connection conn){
    	List<Accessory> accessories = new ArrayList<Accessory>();
    	try (java.sql.Statement st = conn.createStatement();ResultSet rs = st.executeQuery("SELECT * FROM accessory ORDER BY accessory_name ASC");){
		        while(rs.next()) {	accessories.add(new Accessory(rs.getInt("accessory_id"), rs.getString("accessory_name")));	}
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getAccessories*****************" + e.getMessage());
    		return null;
    	}
    	return accessories;
    }
    
    public static Accessory getAccessoryById(Connection conn,int accessory){
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM accessory WHERE accessory_id = ?");){
    			ps.setInt(1, accessory);
		        ResultSet rs = ps.executeQuery();
		        rs.next();
		        return new Accessory(rs.getInt("accessory_id"), rs.getString("accessory_name"));
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getAccessoryById*****************" + e.getMessage());
    		return null;
    	}
    }
    
    public static Accessory getAccessoryOfMachine(Connection conn, int machine, int accessory){
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM accessory JOIN machine_accessory ON (accessory.accessory_id=machine_accessory.accessory_id) WHERE machine_accessory.accessory_id=? AND machine_accessory.machine_id=?")){
    			ps.setInt(1, accessory);
    			ps.setInt(2, machine);
		        ResultSet rs = ps.executeQuery();
		        rs.next();
		        return new Accessory(rs);
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.getAccessoryOfMachine*****************" + e.getMessage());
    		return null;
    	}
    }
    
    public static List<Accessory> getAccessoriesByMachine(Connection conn,int machine) throws SQLException{
    	List<Accessory> accessories = new ArrayList<Accessory>();
    	try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM accessory JOIN machine_accessory ON (accessory.accessory_id=machine_accessory.accessory_id) WHERE machine_id = ? ORDER BY accessory_name ASC")){
    			ps.setInt(1, machine);
	    		ResultSet rs = ps.executeQuery();
	    		while(rs.next()) {
	    			accessories.add(new Accessory(rs));
	    		}
	    		return accessories;
		        
    	}catch(SQLException e) {System.out.println("********************ERORE DAO.getAccessoryByMachine****************" + e.getMessage());}
    	 return null;
    }
    
    public static State insertAccessory(Connection conn,Accessory accessory) {
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("INSERT INTO accessory (accessory_name) VALUES (?)");){
		    		ps.setString(1, Translator.toJson(accessory.getName()).toString());
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.insertAccessory*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State deleteAccessory(Connection conn,Accessory accessory){
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("DELETE FROM accessory WHERE accessory_id = ?");){
	        		ps.setInt(1, accessory.getId());
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.deleteAccessory*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State updateAccessoryName(Connection conn,Accessory accessory){
    	State result = State.NOTOK;
    	try(PreparedStatement ps = conn.prepareStatement("UPDATE accessory SET accessory_name = ? WHERE accessory_id = ?")) {
		    		ps.setString(1, Translator.toJson(accessory.getName()).toString());
		    		ps.setInt(2, accessory.getId());
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.updateAccessoryName*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    public static State addAccessoryToMachine(Connection conn, Machine machine, Accessory accessory) {
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("INSERT INTO machine_accessory (machine_id, accessory_id, image, accessory_weight, accessory_length, accessory_distance, head_offset, predefined) VALUES (?,?,?,?,?,?,?,?)");
    		PreparedStatement ps1 = conn.prepareStatement("UPDATE machine_accessory SET predefined=false WHERE machine_id=? AND predefined=true")){
    			//if(!machineHaveAccessory(conn, machine, accessory)) {
    				if(accessory.isPredefined()) {
		    			ps1.setInt(1, machine.getId());
		    			ps1.executeUpdate();
    				}
		    		ps.setInt(1, machine.getId());
		    		ps.setInt(2, accessory.getId());
		    		ps.setString(3, accessory.getImage());
		    		ps.setDouble(4, accessory.getWeight());
		    		ps.setDouble(5, accessory.getLength());
		    		ps.setDouble(6, accessory.getDistance());
		    		ps.setString(7, accessory.getHeadOffset());
	    			ps.setBoolean(8, accessory.isPredefined());					// deve essere uno solo!!!
		    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
		    	/*}else {
			    	System.out.println("MACHINE: " + machine.getName() + " ALREDY HAVE BALLAST: " + accessory.getName());
			    	result = State.DUPLICATE;
		    	}*/
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.addAccessoryToMachine*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    
    public static State removeAccessoryFromMachine(Connection conn,Machine machine, Accessory accessory) throws SQLException{
    	State result = State.NOTOK;
    	try (PreparedStatement ps = conn.prepareStatement("DELETE FROM machine_accessory WHERE machine_id = ? AND accessory_id = ?")){
	    		ps.setInt(1, machine.getId());
	    		ps.setInt(2, accessory.getId());
	    		result = ps.executeUpdate()==1 ? State.OK : State.ERROR;
    	}catch(SQLException e) {
    		System.out.println("********************ERORE DAO.removeAccessoryFromMachine*****************" + e.getMessage());
    		result = State.ERRDB;
		}
    	return result;
    }
    
    /**modifica parametri di un accessorio */
    public static State modifyAccessoryOfMachine(Connection conn, Machine machine, Accessory accessory) {
    	State result = State.NOTOK;
    	try {
			//if(machineHaveAccessory(conn, machine, accessory)) {
				result = removeAccessoryFromMachine(conn,machine, accessory)==State.OK && addAccessoryToMachine(conn,machine,accessory)==State.OK ? State.OK : State.ERROR;
	    	/*}else {
		    	System.out.println("MACHINE: " + machine.getName() + " DON'T HAVE ACCESSORY: " + accessory.getName());
		    	result = State.NOTFOUND;
	    	}*/
		}catch(SQLException e){
    		System.out.println("********************ERORE DAO.changeAccessoryOfMachine*****************" + e.getMessage());
    		result = State.ERRDB;
    	}
    	return result;
    }
    
    /*private static boolean machineHaveAccessory(Connection conn, Machine machine, Accessory accessory) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM machine_accessory WHERE machine_id = ? AND accessory_id = ?")){
    		ps.setInt(1, machine.getId());
    		ps.setInt(2, accessory.getId());
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.machineHaveAccessory*****************" + e.getMessage());
    	}
    	return false;
    }*/
    
    /*private static boolean existAccessoryName(Connection conn, Accessory accessory) {
    	try(PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM accessory WHERE accessory_name = ?")){
    		ps.setString(1, accessory.getName());
    		ResultSet rs = ps.executeQuery();
    		if(rs.next())
    			return rs.getInt(1)>0;
    		
    	}catch(SQLException e){
    		System.out.println("********************ERORE DAO.existAccessoryName*****************" + e.getMessage());
    	}
    	return false;
    }*/
}


	





package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Asiakas;

public class Dao {
	private Connection connection = null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep = null;
	private String sql;
	private String db = "Myynti.sqlite";
	
	private Connection yhdista() {
		Connection connection = null;
		String path = System.getProperty("catalina.base");
		path += "/webapps/";
		String url = "jdbc:sqlite:" + path + db;
		try {
			Class.forName("org.sqlite.JDBC");
			connection = DriverManager.getConnection(url);
			System.out.println("Yhteys avattu.");
		} catch (Exception e) {
			System.out.println("Yhteyden avaaminen epäonnistui.");
			e.printStackTrace();
		}
		return connection;
	}
	
	public ArrayList<Asiakas> listaaKaikki() {
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat";
		try {
			connection = yhdista();
			if (connection != null) {
				stmtPrep = connection.prepareStatement(sql);
				rs = stmtPrep.executeQuery();
				if (rs != null) {
					while(rs.next()) {
						Asiakas asiakas = new Asiakas();
						asiakas.setId(rs.getInt(1));
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));
						asiakas.setSposti(rs.getString(5));
						asiakkaat.add(asiakas);
					}
				}
			}
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	
	public ArrayList<Asiakas> listaaKaikki(String haku) {
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat WHERE etunimi LIKE ? OR sukunimi LIKE ? OR puhelin LIKE ? or sposti LIKE ?";
		try {
			connection = yhdista();
			if (connection != null) {
				stmtPrep = connection.prepareStatement(sql);
				stmtPrep.setString(1, "%" + haku +"%");
				stmtPrep.setString(2, "%" + haku +"%");
				stmtPrep.setString(3, "%" + haku +"%");
				stmtPrep.setString(4, "%" + haku +"%");
				rs = stmtPrep.executeQuery();
				if (rs != null) {
					while(rs.next()) {
						Asiakas asiakas = new Asiakas();
						asiakas.setId(rs.getInt(1));
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));
						asiakas.setSposti(rs.getString(5));
						asiakkaat.add(asiakas);
					}
				}
			}
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	
	public boolean lisaaAsiakas(Asiakas asiakas) {
		boolean paluuArvo = true;
		sql = "INSERT INTO asiakkaat(etunimi,sukunimi,puhelin,sposti) VALUES(?,?,?,?)";
		try {
			connection = yhdista();
			stmtPrep = connection.prepareStatement(sql);
			stmtPrep.setString(1, asiakas.getEtunimi());
			stmtPrep.setString(2, asiakas.getSukunimi());
			stmtPrep.setString(3, asiakas.getPuhelin());
			stmtPrep.setString(4, asiakas.getSposti());
			stmtPrep.executeUpdate();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
			paluuArvo = false;
		}
		return paluuArvo;
	}
	
	public boolean poistaAsiakas(int id) {
		boolean paluuArvo = true;
		sql = "DELETE FROM asiakkaat WHERE asiakas_id=?";
		try {
			connection = yhdista();
			stmtPrep = connection.prepareStatement(sql);
			stmtPrep.setInt(1, id);
			stmtPrep.executeUpdate();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
			paluuArvo = false;
		}
		return paluuArvo;
	}
}


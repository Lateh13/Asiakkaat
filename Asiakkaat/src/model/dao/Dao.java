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
			System.out.println("Yhteyden avaaminen ep�onnistui.");
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
}

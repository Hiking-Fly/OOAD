package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.javaBean.Article;
import com.javaBean.Author;

public class DB {

	public static String root = "root";
	public static String url = "jdbc:mysql://localhost:3306/ooad?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
	public static String password = "Ab@1";
	public static String Driver = "com.mysql.jdbc.Driver";
	public static Connection con;
    
	public static Connection getConnection() throws SQLException {
		try {
			Class.forName(Driver);

			con = DriverManager.getConnection(url, root, password);

		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return con;
	}

	public void close() throws SQLException {
		con.close();
	}

	public void updateArticle(Article a) throws SQLException {
		con=getConnection();
		String sql = "update article set title=?, highlight=?, abstracts=?, time=? where title=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, a.getTitle());
		ps.setString(2, a.getHighlights());
		ps.setString(3, a.getAbstracts());
		ps.setTimestamp(4, a.getTime());
		ps.setString(5, a.getOldtitle());
		ps.executeUpdate();

		close();
	}

	public void deleteArticle(String title) throws SQLException {
		con=getConnection();

		String sql = "delete from article where title=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, title);
		ps.executeUpdate();

		close();

	}

	public void deleteComment(String comment) throws SQLException {
		con=getConnection();

		String sql = "delete from comments where comment=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, comment);
		ps.executeUpdate();

		close();

	}

	public void addAuthor(Author a) throws SQLException {
		con=getConnection();

		String sql = "insert into author(email,password) values(?,?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, a.getEmail());
		ps.setString(2, a.getPassword());
		ps.executeUpdate();

		close();

	}

	public boolean checkAuthor(Author a) throws SQLException {
		con=getConnection();

		boolean result = false;
		int i = 0;

		String sql = "select * from author where email=? and password=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, a.getEmail());
		ps.setString(2, a.getPassword());

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			i = 1;
			result = true;
		}

		close();

		return result;
	}

	public boolean checkblockauthor(String email) throws SQLException {
		con=getConnection();

		boolean result = false;
		int i = 0;

		String sql = "select * from block_author where email=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, email);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			i = 1;
			result = true;
		}

		close();

		return result;
	}

	public void blockAuthor(String author) throws SQLException {
		con=getConnection();

		String sql = "insert into block_author(email) values(?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, author);
		ps.executeUpdate();

		close();

	}

	public void releaseAuthor(String author) throws SQLException {
		con=getConnection();

		String sql = "delete from block_author where email=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, author);
		ps.executeUpdate();

		close();

	}

	public boolean checktitle(String title) throws SQLException {
		con=getConnection();

		boolean result = false;
		int i = 0;

		String sql = "select * from article where title=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, title);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			i = 1;
			result = true;
		}

		close();

		return result;
	}

	public boolean check_popular(String ip, String title, int a) throws SQLException {
		con=getConnection();

		boolean result = false;
		int i = 0;

		String sql = "insert into user_ip(ip, title, prefer) values(?, ?, ?)";
		String sql2 = "select * from user_ip where ip=? and title=?";
		String sql3 = "update user_ip set prefer=? where ip=? and title=?";

		PreparedStatement ps2 = con.prepareStatement(sql2);
		ps2.setString(1, ip);
		ps2.setString(2, title);

		ResultSet rs = ps2.executeQuery();

		while (rs.next()) {
			i = 1;
		}

		if (i == 1) {
			PreparedStatement ps3 = con.prepareStatement(sql3);
			ps3.setInt(1, a);
			ps3.setString(2, ip);
			ps3.setString(3, title);
			ps3.executeUpdate();
			result = true;
		}

		else if (i == 0) {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, ip);
			ps.setString(2, title);
			ps.setInt(3, a);
			ps.executeUpdate();
			result = true;
		}

		close();

		return result;
	}

	/*
	 * 
	 * This function checks whether the user with the specific 'ip', has
	 * liked/disliked the comment with the specific 'id'. 'a' is a flag to determine
	 * whether the required operation is like or dislike, where a = 0, if the
	 * required operation is dislike, and a = 1 if it's like.
	 * 
	 */
	public boolean check_comments_popular(String ip, int id, int a) throws SQLException {
		con=getConnection();

		boolean result = false;
		int i = 0;

		String sql = "insert into comments_ip(ip, id, prefer) values(?, ?, ?)";
		String sql2 = "select * from comments_ip where ip=? and id=?";
		String sql3 = "update comments_ip set prefer=? where ip=? and id=?";

		PreparedStatement ps2 = con.prepareStatement(sql2);
		ps2.setString(1, ip);
		ps2.setInt(2, id);

		ResultSet rs = ps2.executeQuery();

		while (rs.next()) {
			i = 1;
		}

		if (i == 1) {
			PreparedStatement ps3 = con.prepareStatement(sql3);
			ps3.setInt(1, a);
			ps3.setString(2, ip);
			ps3.setInt(3, id);
			ps3.executeUpdate();
			result = true;
		}

		else if (i == 0) {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, ip);
			ps.setInt(2, id);
			ps.setInt(3, a);
			ps.executeUpdate();
			result = true;
		}

		close();

		return result;
	}

}

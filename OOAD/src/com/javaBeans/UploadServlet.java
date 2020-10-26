package com.javaBeans;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.swing.JOptionPane;

import org.apache.catalina.core.ApplicationPart;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.database.DB;

@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 1000)
public class UploadServlet extends HttpServlet {

	PrintWriter out = null;
	Connection con = null;
	PreparedStatement ps = null;
	HttpSession session = null;

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		String author = request.getParameter("author");
		String subject = request.getParameter("subject");
		String title = request.getParameter("title");
		String highlights = request.getParameter("highlights");
		String abstracts = request.getParameter("abstracts");

		DB db = new DB();
		boolean checkstatus = false;

		try {
			checkstatus = db.checktitle(title);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (checkstatus) {
			JOptionPane.showMessageDialog(null, "The article title already exists.\nPlease use another one. ", "Info",
					JOptionPane.INFORMATION_MESSAGE);
			request.setAttribute("author", author);
			request.setAttribute("subject", subject);
			request.setAttribute("title", title);
			request.setAttribute("highlights", highlights);
			request.setAttribute("abstracts", abstracts);
			try {
				request.getRequestDispatcher("PostArticle.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			response.setContentType("text/plain;charset=UTF=8");
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (isMultipart) {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				// �����ļ���С 10M
				upload.setFileSizeMax(1024 * 1024 * 10);
				// parseRequest ����form�е����������ֶΣ������浽items��
				try {
					List<FileItem> items = upload.parseRequest(request);
					// foreach ������˳��ȷ��������name��ֵȥ�ж�����һ��
					Iterator<FileItem> iter = items.iterator();
					while (iter.hasNext()) {
						FileItem item = iter.next();
						String name = item.getFieldName();
						// �ж��Ƿ�Ϊ���ֶΣ������ļ��ֶ�
						if (item.isFormField()) {
							System.out.println("form items");
						} else {// �ļ�����
							String allFilePath = item.getName();
							String fileName = null;
							int index = allFilePath.lastIndexOf(File.separator);
							if (index != -1) {
								fileName = allFilePath.substring(index + 1);
							} else {
								fileName = allFilePath;
							}
							if (fileName.toLowerCase().endsWith(".pdf")) {
								String path = "D:\\upload";
								
								File file = new File(path, fileName);
								if (!file.exists()) {
									file.mkdirs();
								}
								item.write(file);
								System.out.println("�ϴ��ɹ� ��");
								Class.forName("com.mysql.jdbc.Driver");
								// �������ݿ���Ϣ
								Connection con = DB.getConnection();

								String sql = "insert into article(subject, title, highlight, abstracts, author, time, filename, path) values (?,?,?,?,?,?,?,?)";
								Timestamp time = new Timestamp(System.currentTimeMillis());
								ps = con.prepareStatement(sql);
								ps.setString(1, subject);
								ps.setString(2, title);
								ps.setString(3, highlights);
								ps.setString(4, abstracts);
								ps.setString(5, author);
								ps.setTimestamp(6, time);
								ps.setString(7, fileName);
								ps.setString(8, path);

								int status = ps.executeUpdate();

								if (status > 0) {
									session.setAttribute("fileName", fileName);
									String msg = "" + fileName + " upload successfully";
									request.setAttribute("msg", msg);
									request.setAttribute("subject", subject);
									request.getRequestDispatcher("NewFile.jsp").forward(request, response);

								}
							} else {
								// if the uploaded file type is not PDF, show an alert message
								JOptionPane.showMessageDialog(null,
										"Unsupported file format!.\nOnly PDF files are supported. ", "Info",
										JOptionPane.INFORMATION_MESSAGE);
								request.setAttribute("author", author);
								request.setAttribute("subject", subject);
								request.setAttribute("title", title);
								request.setAttribute("highlights", highlights);
								request.setAttribute("abstracts", abstracts);
								request.getRequestDispatcher("PostArticle.jsp").forward(request, response);

							} //pdf
						} // file
					}//while
				}//try
				catch (FileUploadBase.SizeLimitExceededException e) {
					JOptionPane.showMessageDialog(null,
							"FileSizeExceeded!.\nThe FileSize should be within in 10M. ", "Info",
							JOptionPane.INFORMATION_MESSAGE);
					e.printStackTrace();
				}catch (Exception e) {
					e.printStackTrace();
				}
			}//Multipart
		}//exits
	}//doPost
}
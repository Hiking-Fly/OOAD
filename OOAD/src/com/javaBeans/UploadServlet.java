package com.javaBeans;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
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
import javax.swing.JOptionPane;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.database.DB;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		String code = (String) request.getSession().getAttribute("verifyCodeValue");
		String textCode = request.getParameter("verifyCode");
		if (!code.equals(textCode)) {
			JOptionPane.showMessageDialog(null,
					"验证码输入错误！", "Info",
					JOptionPane.INFORMATION_MESSAGE);
			try {
				request.getRequestDispatcher("PostArticle.jsp").forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		String author = "", subject = "", title = "", highlights = "", abstracts = "";
		response.setContentType("text/plain;charset=UTF=8");
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if (isMultipart) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 限制文件大小 10M
			upload.setFileSizeMax(1024 * 1024 * 10);
			// parseRequest 解析form中的所有请求字段，并保存到items中
			try {
				List<FileItem> items = upload.parseRequest(request);
				// foreach 遍历，顺序不确定，根据name的值去判断是哪一个
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
					// 判断是否为表单字段，还是文件字段
					String name = item.getFieldName();
					if (item.isFormField()) {
						if (name.equals("author")) {
							author = item.getString();
						} else if (name.equals("subject")) {
							subject = item.getString();
						} else if (name.equals("title")) {
							title = item.getString();
						} else if (name.equals("highlights")) {
							highlights = item.getString();
						} else if (name.equals("abstracts")) {
							abstracts = item.getString();
						}
					} else {// 文件处理
						boolean checkstatus = false;
						try {// 检查title是否重复
							checkstatus = DB.checktitle(title);
						} catch (SQLException e) {
							e.printStackTrace();
						}
						if (checkstatus) {
							JOptionPane.showMessageDialog(null,
									"The article title already exists.\nPlease use another one. ", "Info",
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
						}

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
							File file = new File(path);
							if (!file.exists()) {
								file.mkdirs();
							}
							file = new File(file, fileName);
							item.write(file);
							System.out.println("上传成功 ！");
							// 更新数据库信息
							Connection con = DB.getConnection();
							String sql = "insert into article(subject, title, highlight, abstracts, author, time, filename, path) values (?,?,?,?,?,?,?,?)";
							Timestamp time = new Timestamp(System.currentTimeMillis());
							PreparedStatement ps = con.prepareStatement(sql);
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
								con.close();
								ps.close();
								request.getSession().setAttribute("fileName", fileName);
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

						} // pdf
					} // file

				} // while
			} catch (FileUploadBase.SizeLimitExceededException e) {
				JOptionPane.showMessageDialog(null, "FileSizeExceeded!.\nThe FileSize should be within in 10M. ",
						"Info", JOptionPane.INFORMATION_MESSAGE);
				e.printStackTrace();
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // Multipart
		else {
			System.out.println("没有multiPart字段");
		}

	}// doPost
}
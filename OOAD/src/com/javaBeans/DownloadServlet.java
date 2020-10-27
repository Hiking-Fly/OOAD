package com.javaBeans;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.codec.binary.Base64;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		response.addHeader("content-Type", "application/octet-stream");// 二进制，任意文件类型
		String agent = request.getHeader("User-Agent");
		String fileName = request.getParameter("fileName");
		System.out.println(fileName);
		String filepath = "D:\\upload\\";
		if (agent.toLowerCase().indexOf("firefox") != -1) {// 解決firefox乱码
			response.addHeader("content-Disposition", "attachment;filename==?UTF-8?B?"
					+ new String(Base64.encodeBase64(fileName.getBytes("UTF-8"))) + "?=");
		} else {
			response.addHeader("content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "utf-8"));
		}
		ServletOutputStream servletOutputStream = response.getOutputStream();
		FileInputStream fileInputStream = new FileInputStream(filepath + fileName);
		byte[] buffer = new byte[1024];
		int lenth = 0;
		while ((lenth = fileInputStream.read(buffer)) != -1) {
			servletOutputStream.write(buffer, 0, lenth);
		}
		fileInputStream.close();
		servletOutputStream.close();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

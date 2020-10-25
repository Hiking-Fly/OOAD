<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header1.jsp"%>


	<form action="/OOAD/AdminController" method="post" class="form1">
		<table>
			<tr>
				<td><h1>Admin Login</h1></td>
			</tr>
			<tr>
				<td><input type="hidden" name="page" value="admin"></td>
			</tr>
			<tr>
				<td><label for="email">email:</label><input type="email" name="email" id="email" required></td>
			</tr>
			<tr>
				<td><label for="password">password:</label><input type="password" name="password" id="password" required></td>
			</tr>
			<tr>
				<td><button>login</button></td>
			</tr>
			<tr>
				<td><a href="AdminController?page=register">register</a></td>
			</tr>
			<tr>
				<td style="color: red"><c:out value="${ msg}"></c:out></td>
			</tr>
		</table>
	</form>


<%@include file="/common/foot.jsp"%>

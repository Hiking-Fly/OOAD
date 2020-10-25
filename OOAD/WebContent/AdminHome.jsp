<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>

<header>
	<h1>Welcome Admin</h1>
	<nav>
		<ul>
			<li><a href="AdminController?page=home">Home</a></li>
			<li><a href="AdminController?page=articles">articles</a></li>
			<li><a href="AdminController?page=logout">logout</a></li>
		</ul>
		
	</nav>
</header>

<sql:query var="result" dataSource="${ db}">
select * from article where author="${ email}"
</sql:query>

<div>
	<table class="table2">
		<tr>
			<th>Subject</th>
			<th>Title</th>
			<th>Highlight</th>
			<th>Option</th>
		</tr>
		<c:forEach items="${result.rows}" var="row">
			<tr>
				<td><c:out value="${ row.subject}"></c:out></td>
				<td><c:out value="${ row.title}"></c:out></td>
				<td><c:out value="${ row.highlight}"></c:out></td>
				<td><a href="AdminController?page=edit&title=${ row.title}">edit</a>
					|| <a href="AdminController?page=delete&title=${ row.title}">delete</a></td>
			</tr>
		</c:forEach>
	</table>
</div>

<%@include file="/common/foot.jsp"%>
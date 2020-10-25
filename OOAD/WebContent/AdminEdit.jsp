<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>

<header>
	<h1>Welcome Admin</h1>
	<nav>
		<ul>
			<li><a href="AdminController?page=home">Home</a></li>
			<li><a href="AdminController?page=master-articles">Articles</a></li>
			<li><a href="AdminController?page=logout">logout</a></li>
		</ul>
	</nav>
</header>

<sql:query var="result" dataSource="${ db}">
	select * from article where title='<%=request.getAttribute("title")%>'
</sql:query>

<c:forEach items="${ result.rows}" var="row">


	<form class="form1" action="/OOAD/AdminController" method="post">
		<input type="hidden" name="page" value="edit-form"> <input
			type="hidden" name="old-title"
			value="<%=request.getAttribute("title")%>">
		<table>

			<tr>
				<td>Current Subject</td>
			</tr>

			<tr>
				<td><input type="text" name="subject"
					value="<c:out value="${ row.subject}"></c:out>" readonly
					style="background: lightgray"></td>
			</tr>

			<tr>
				<td>Title</td>
			</tr>

			<tr>
				<td><input type="text" name="title"
					value="<c:out value="${ row.title}"></c:out>"
					placeholder="Enter title" required></td>
			</tr>

			<tr>
				<td>Highlights</td>
			</tr>

			<tr>
				<td><input type="text" name="highlights"
					value="<c:out value="${ row.highlight}"></c:out>"
					placeholder="Enter highlights" required></td>
			</tr>

			<tr>
				<td>Abstract</td>
			</tr>

			<tr>
				<td><input type="text" name="abstracts"
					value="<c:out value="${ row.abstracts}"></c:out>"
					placeholder="Enter abstract" required></td>
			</tr>


			<tr>
				<td><button>update</button></td>
			</tr>

		</table>
	</form>

</c:forEach>

<%@include file="/common/foot.jsp"%>
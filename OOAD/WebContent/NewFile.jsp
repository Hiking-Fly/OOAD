<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header1.jsp"%>

<form action="/OOAD/Controller" method="post" class="form1">
	<input type="hidden" name="page" value="post-article"> <input
		type="hidden" name="subject" value="${ subject}">
	<table class="table1">
		<tr>
			<td><h1>
					You are in
					<c:out value="${ subject}"></c:out>
				</h1></td>
		</tr>
		<tr>
			<td><label for="email">email:</label><input type="email"
				name="email" id="email" placeholder="enter email to post" required></td>
		</tr>
		<tr>
			<td><button>Post Article</button></td>
		</tr>
	</table>
</form>

<sql:query var="result" dataSource="${ db}">
select * from article where subject='<%=request.getAttribute("subject")%>'
</sql:query>

<div>
	<table class="table2">
		<tr>
			<th>Title</th>
			<th>Author</th>
			<th>Time</th>
			<th>Popularity</th>
		</tr>
		<c:forEach items="${result.rows}" var="row">
			<tr>
				<td><a href="Controller?page=view-article&title=${ row.title}">
						<c:out value="${ row.title}"></c:out>
				</a></td>
				<td><c:set var="string" value="${ fn:length(row.author)}" /> <c:out
						value="${ fn:substring(row.author, 0, 3)}***${ fn:substring(row.author, string-8, string)}"></c:out></td>
				<td><c:out value="${ row.time}"></c:out></td>
				<td><c:out value=""></c:out></td>

			</tr>
		</c:forEach>
	</table>
</div>

<%@include file="/common/foot.jsp"%>
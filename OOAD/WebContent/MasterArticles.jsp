<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>

<%@include file="/common/header2.jsp"%>

<sql:query var="result" dataSource="${ db}">
select * from article
</sql:query>

<div>
	<table class="table2">
		<tr>
			<th>Title</th>
			<th>Author</th>
			<th>Time</th>
			<th>Option</th>
		</tr>
		<c:forEach items="${result.rows}" var="row">
			<tr>
				<td><a
					href="AdminController?page=master-view-article&title=${ row.title}">
						<c:out value="${ row.title}"></c:out>
				</a></td>
				<td><c:out value="${ row.author}"></c:out></td>
				<td><c:out value="${ row.time}"></c:out></td>
				<td><a
					href="AdminController?page=master-delete&title=${ row.title}">delete</a></td>
			</tr>
		</c:forEach>
	</table>
</div>

<%@include file="/common/foot.jsp"%>
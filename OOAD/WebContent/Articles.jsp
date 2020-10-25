<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>

<%@include file="/common/header1.jsp"%>

<sql:query var="result" dataSource="${ db}">
select * from article
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
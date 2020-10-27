<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header3.jsp"%>

<sql:query var="result" dataSource="${db}">
select * from article where title like '%<%=request.getAttribute("search2")%>%' or abstracts like '%<%=request.getAttribute("search2")%>%' or highlight like '%<%=request.getAttribute("search2")%>%' order by time desc
</sql:query>

<div>
	<table class="table2">
		<tr>
			<th>Subject</th>
			<th>Title</th>
			<th>Author</th>
			<th>Time</th>
			<th>Popularity</th>
		</tr>
		<c:forEach items="${result.rows}" var="row">
			<c:set value="${search2}" var="search2"></c:set>
			<tr>
				<td><c:out value="${row.subject}"></c:out></td>
				<td><a href="Controller?page=view-article&title=${row.title}">
						<c:out value="${row.title}"></c:out>
				</a></td>
				<td><c:set var="string" value="${fn:length(row.author)}" /> <c:out
						value="${fn:substring(row.author, 0, 3)}***${fn:substring(row.author, string-8, string)}"></c:out></td>
				<td><c:out value="${row.time}"></c:out></td>
				<td><c:out value=""></c:out></td>
			</tr>
		</c:forEach>
	</table>
</div>

<br>
<br>

<sql:query var="result2" dataSource="${db}">
select * from comments where comment like '%<%=request.getAttribute("search2")%>%' order by time desc
</sql:query>

<!-- A table is created that shows the results fetched from the search query as follows. -->
<div>
	<table class="table2">
		<tr>
			<th>Article Title</th>
			<th>Comment</th>
			<th>Time</th>
			<th>Author</th>
		</tr>
		<!-- forEach loop to list all the records related to the search keyword. -->
		<c:forEach items="${result2.rows}" var="row2">
			<c:set value="${search2}" var="search2"></c:set>
			<tr>
				<td><a href="Controller?page=view-article&title=${row2.title}">
						<c:out value="${row2.title}"></c:out>
				</a></td>
				<td><c:out value="${row2.comment}"></c:out></td>
				<td><c:out value="${row2.time}"></c:out></td>
				<td><c:set var="string" value="${fn:length(row2.user)}" /> <c:out
						value="${fn:substring(row2.user, 0, 3)}***${fn:substring(row2.user, string-8, string)}"></c:out></td>
			</tr>
		</c:forEach>
		<tr>
		</tr>
	</table>
</div>


<%@include file="/common/foot.jsp"%>
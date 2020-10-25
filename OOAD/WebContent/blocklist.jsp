<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>>

<%@include file="/common/header2.jsp"%>

<sql:query var="result" dataSource="${ db}">
select email from block_author; 
</sql:query>

<div>
	<table class="table2">
		<tr>
			<th>Author</th>
			<th>Option</th>
		</tr>

		<c:forEach items="${result.rows}" var="row">
			<tr>
				<td><c:out value="${ row.email}"></c:out></td>
				<td><a
					href="AdminController?page=master-release-author&author=${ row.email}">release</a></td>
			</tr>
		</c:forEach>
	</table>
</div>

<%@include file="/common/foot.jsp"%>
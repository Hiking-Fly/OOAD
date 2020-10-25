<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>

<%@include file="/common/header2.jsp"%>

<sql:query var="result" dataSource="${ db}">
select author from article where author not in (select email from block_author)
</sql:query>

<div>
	<table class="table2">
		<tr>
			<th>Author</th>
			<th>Option</th>
		</tr>

		<c:forEach items="${result.rows}" var="row">
			<tr>
				<td><c:out value="${ row.author}"></c:out></td>
				<td><a
					href="AdminController?page=master-block-author&author=${ row.author}">block</a></td>
			</tr>
		</c:forEach>
	</table>
</div>

<%@include file="/common/foot.jsp"%>
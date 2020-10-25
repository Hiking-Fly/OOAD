<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>

<%@include file="/common/header2.jsp"%>

<sql:query var="result" dataSource="${ db}">
 	select * from article where title="${ title}";
	</sql:query>

<div class="div1">
	<table>

		<tr>
			<td><h1>
					<c:out value="${ title}">
					</c:out>
				</h1></td>
		</tr>

		<c:forEach items="${ result.rows}" var="row">

			<tr>
				<td class="td1">Abstract</td>
			</tr>
			<tr>
				<td class="td2"><c:out value="${ row.abstracts}"></c:out></td>
			</tr>

			<tr>
				<td class="td1">Highlight</td>
			</tr>
			<tr>
				<td class="td2"><c:out value="${ row.highlight}"></c:out></td>
			</tr>

			<tr>
				<td class="td1">Publication Date</td>
			</tr>
			<tr>
				<td class="td2"><c:out value="${ row.time}"></c:out></td>
			</tr>

		</c:forEach>

	</table>
</div>

<%@include file="/common/foot.jsp"%>
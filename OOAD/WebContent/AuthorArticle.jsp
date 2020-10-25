<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header1.jsp"%>

	<sql:query var="result" dataSource="${ db}">
select * from article where author = '${ author}'
</sql:query>

	<div>
		<table class="table2">
			<tr>
				<th>Author</th>
				<th>Subject</th>
				<th>Title</th>
				<th>Time</th>
				<th>Popularity</th>
			</tr>
			<c:forEach items="${result.rows}" var="row">
				<tr>
					<td class="td2"><a
						href="Controller?page=authorarticle&author=${ row.author}"
						style="color: dodgerblue"> <c:set var="string"
								value="${ fn:length(row.author)}"></c:set> <c:out
								value="${ fn:substring(row.author, 0, 3)} *** ${ fn:substring(row.author, string-9, string)}"></c:out>
					</a></td>
					<td><a
						href="Controller?page=view-article&title=${ row.subject}"> <c:out
								value="${ row.title}"></c:out>
					</a></td>
					<td><c:out value="${ row.title}"></c:out></td>
					<td><c:out value="${ row.time}"></c:out></td>
					<td><c:out value="${ row.subject}"></c:out></td>
					<td><a href="DownloadServlet?fileName=${ row.filename}">Download</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>


<%@include file="/common/foot.jsp"%>
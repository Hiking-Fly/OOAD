<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header1.jsp"%>

<form class="form1" action="/OOAD/UploadServlet" method="post"
	enctype="multipart/form-data">
	<table>

		<tr>
			<td><label for="author">Author:</label><input type="text"
				name="author" value="<c:out value="${ author}"></c:out>" id="author"
				readonly style="background: lightgray">
		</tr>
		<tr>
			<td><label for="subject">Current Subject:</label><input
				type="text" name="subject"
				value="<c:out value="${ subject}"></c:out>" readonly
				style="background: lightgray" id="subject"></td>
		</tr>

		<tr>
			<td><label for="title">Title:</label><input type="text"
				name="title" placeholder="Enter title" required id="title">
			</td>
		</tr>

		<tr>

			<td><label for="highlights">Title:</label><input type="text"
				name="highlights" placeholder="Enter highlights" id="highlights"
				required></td>
		</tr>

		<tr>
			<td><label for="abstract">Abstract:</label><input type="text"
				name="abstracts" placeholder="Enter abstract" id="abstract" required></td>
		</tr>

		<tr>
			<td><input type="file" name="file" required></td>
		</tr>


		<tr>
			<td><button>Post</button></td>
		</tr>

	</table>
</form>

<%@include file="/common/foot.jsp"%>
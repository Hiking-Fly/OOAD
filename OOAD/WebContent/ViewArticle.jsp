<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header1.jsp"%>



<sql:query var="result" dataSource="${ db}">
select * from article where title="${ title}";
</sql:query>

<%---------------------------------------------------------------------- --%>

<sql:query var="result3" dataSource="${ db}">
select * from user_ip where prefer=1 and title="${ title}";
</sql:query>

<c:set var="x" value="0"></c:set>
<c:forEach items="${ result3.rows}" var="row">

	<c:set var="x" value="${ x+1}"></c:set>
</c:forEach>

<%---------------------------------------------------------------------- --%>

<sql:query var="result4" dataSource="${ db}">
select * from user_ip where prefer=0 and title="${ title}";
</sql:query>

<c:set var="y" value="0"></c:set>
<c:forEach items="${ result4.rows}" var="row">

	<c:set var="y" value="${ y+1}"></c:set>
</c:forEach>

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

			<tr>
				<td class="td1">Author</td>
			</tr>
			<tr>
				<td class="td2"><a
					href="Controller?page=authorarticle&author=${ row.author}"
					style="color: dodgerblue"> <c:set var="string"
							value="${ fn:length(row.author)}"></c:set> <c:out
							value="${ fn:substring(row.author, 0, 3)} *** ${ fn:substring(row.author, string-9, string)}"></c:out>
				</a></td>
			</tr>

			<tr>
				<td class="downloadtd">
					<form action="/OOAD/Controller" method="post" class="popularity">
						<input type="hidden" name="page" value="like"> <input
							type="hidden" name="title" value="${ title}">
						<button class="like">
							<i class="fa fa-thumbs-o-up"></i>
						</button>
						<c:out value="${ x}"></c:out>
					</form>
					<form action="/OOAD/Controller" method="post" class="popularity">
						<input type="hidden" name="page" value="dislike"> <input
							type="hidden" name="title" value="${ title}">
						<button class="dislike">
							<i class="fa fa-thumbs-o-down"></i>
						</button>
						<c:out value="${y}"></c:out>
					</form> <a class="download"
					href="DownloadServlet?fileName=${ row.filename}">Download</a>
				<td>
			</tr>

		</c:forEach>

	</table>
</div>

<div class="div2">

	<form action="/OOAD/Controller" method="post">
		<input type="hidden" name="page" value="comment-post"> <input
			type="hidden" name="title" value="${ title}">
		<table>
			<tr>
				<td><input type="email" name="email" required
					placeholder="enter your email"></td>
			</tr>
			<tr>
				<td><input class="input2" type="text" name="comment" required
					placeholder="write something here"></td>
			</tr>
			<tr>
				<td style="width: 200%; border: 1px solid white;">
					<button>Post</button>
				</td>
			</tr>
			<tr>
				<td style="color: red"><c:out value="${ msg}"></c:out></td>
			</tr>
		</table>
	</form>

</div>

<sql:query var="result2" dataSource="${ db}">
select * from comments where title="${ title}"
</sql:query>

<%---------------------------------------------------------------------- --%>
<%-- This block is the comment box, where the comment, user, and time are 
	 going to be displayed. 
 --%>

<c:forEach items="${ result2.rows}" var="row">
	<div class="div3">
		<table>
			<tr>
				<td><a> <c:out value="${ row.user}"></c:out>
				</a></td>
			</tr>
			<tr>
				<td><c:out value="${ row.comment}"></c:out></td>
			</tr>
			<tr>
				<td><p class="time">
						<c:out value="${ row.time}"></c:out>
					</p></td>
			</tr>
			<tr>
				<td>
					<!-- ............................................................... -->
					<!-- This block create like button and functionality to each comment-->

					<sql:query var="result5" dataSource="${ db}">
select * from comments_ip where prefer=1 and id="${ row.id}";
</sql:query> <c:set var="q" value="0"></c:set> <c:forEach items="${ result5.rows}"
						var="row1">

						<c:set var="q" value="${ q+1}"></c:set>
					</c:forEach>

					<form action="/OOAD/Controller" method="post" class="popularity">
						<input type="hidden" name="page" value="comments_like"> <input
							type="hidden" name="id" value="${ row.id}"> <input
							type="hidden" name="title" value="${ title}">
						<button class="like">
							<i class="fa fa-thumbs-o-up"></i>
						</button>
						<c:out value="${ q}"></c:out>
					</form> <!-- ............................................................... -->
					<!-- This block create dislike button and functionality to each comment-->

					<sql:query var="result6" dataSource="${ db}">
select * from comments_ip where prefer=0 and id="${ row.id}";
</sql:query> <c:set var="r" value="0"></c:set> <c:forEach items="${ result6.rows}"
						var="row2">

						<c:set var="r" value="${ r+1}"></c:set>
					</c:forEach>


					<form action="/OOAD/Controller" method="post" class="popularity">
						<input type="hidden" name="page" value="comments_dislike">
						<input type="hidden" name="id" value="${ row.id}"> <input
							type="hidden" name="title" value="${ title}">
						<button class="dislike">
							<i class="fa fa-thumbs-o-down"></i>
						</button>
						<c:out value="${ r}"></c:out>
					</form>

				</td>
			</tr>
		</table>
	</div>

	<br>
	<br>

</c:forEach>

<%@include file="/common/foot.jsp"%>
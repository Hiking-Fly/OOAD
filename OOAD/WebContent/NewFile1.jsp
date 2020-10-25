<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/head.jsp"%>
<%@include file="/common/header1.jsp"%>

<sql:query var="physical" dataSource="${ db}">
select * from article where subject="Physical Science";
</sql:query>

<sql:query var="computer" dataSource="${ db}">
select * from article where subject="Computer Science";
</sql:query>

<sql:query var="medical" dataSource="${ db}">
select * from article where subject="Medical Science";
</sql:query>

<sql:query var="social" dataSource="${ db}">
select * from article where subject="Social Science";
</sql:query>

<sql:query var="biological" dataSource="${ db}">
select * from article where subject="Biological Science";
</sql:query>

<sql:query var="math" dataSource="${ db}">
select * from article where subject="Mathematics";
</sql:query>


<div class="container">
	<div class="row">
		<div class="col-md-5">
			<div class="list-group">
				<a class="list-group-item"
					href="Controller?page=subject&id=Physical Science">Physical
					Science</a>
				<c:forEach items="${ physical.rows}" var="row">
					<a class="subitem"
						href="Controller?page=view-article&title=${ row.title}"><c:out
							value="${ row.title}"></c:out></a>
					<br>
				</c:forEach>

				<a class="list-group-item"
					href="Controller?page=subject&id=Computer Science">Computer
					Science</a>
				<c:forEach items="${ computer.rows}" var="row">
					<a class="subitem"
						href="Controller?page=view-article&title=${ row.title}"><c:out
							value="${ row.title}"></c:out></a>
					<br>
				</c:forEach>

				<a class="list-group-item"
					href="Controller?page=subject&id=Medical Science">Medical
					Science</a>
				<c:forEach items="${ medical.rows}" var="row">
					<a class="subitem"
						href="Controller?page=view-article&title=${ row.title}"><c:out
							value="${ row.title}"></c:out></a>
					<br>
				</c:forEach>


				<a class="list-group-item"
					href="Controller?page=subject&id=Social Science">Social Science</a>
				<c:forEach items="${ social.rows}" var="row">
					<a class="subitem"
						href="Controller?page=view-article&title=${ row.title}"><c:out
							value="${ row.title}"></c:out></a>
					<br>
				</c:forEach>

				<a class="list-group-item"
					href="Controller?page=subject&id=Biological Science">Biological
					Science</a>
				<c:forEach items="${ biological.rows}" var="row">
					<a class="subitem"
						href="Controller?page=view-article&title=${ row.title}"><c:out
							value="${ row.title}"></c:out></a>
					<br>
				</c:forEach>

				<a class="list-group-item"
					href="Controller?page=subject&id=Mathematics">Mathematics</a>
				<c:forEach items="${ math.rows}" var="row">
					<a class="subitem"
						href="Controller?page=view-article&title=${ row.title}"><c:out
							value="${ row.title}"></c:out></a>
					<br>
				</c:forEach>

			</div>
		</div>
	</div>
</div>

<%@include file="/common/foot.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FreePost</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/style.css" />
</head>
<body>
<sql:setDataSource user="root" password="Ab@1"
		url="jdbc:mysql://localhost:3306/ooad?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC"
		driver="com.mysql.jdbc.Driver" var="db" />
	
	
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<c:set var="lang" value="${pageContext.request.locale.language}"/>
<fmt:setLocale value="${lang}"/>
<fmt:setBundle basename="main.messages"/>
<html lang="${lang}">
    <head>
        <title>Start Page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
	</head>
    <body>
		<div class="container-fluid">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item active" aria-current="page">Home</li>
				</ol>
			</nav>
			<nav class="nav nav-pills flex-column flex-sm-row">
				<a type="button" class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/family/show"/>"><fmt:message key="label.showFamily"/></a>
			</nav>
			</br>
			<nav class="nav nav-pills flex-column flex-sm-row">
				<a type="button" class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/machine/show"/>"><fmt:message key="label.showMachine"/></a>
			</nav>
			</br>
			<nav class="nav nav-pills flex-column flex-sm-row">
				<a type="button" class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/ballast/show"/>"><fmt:message key="label.showBallast"/></a>
			</nav>
			</br>
			<nav class="nav nav-pills flex-column flex-sm-row">
				<a type="button" class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/accessory/show"/>"><fmt:message key="label.showAccessory"/></a>
			</nav>
			</br>
			<nav class="nav nav-pills flex-column flex-sm-row">
				<a type="button" class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/calculator/family"/>"><fmt:message key="label.calculate"/></a>
			</nav>
			<br>
			<div class="text-center">
				<img src="<c:url value="/media/logo_movimatica-color.png"/>" alt="..." class="img-fluid">
			</div>
		</div>
    </body>
</html>
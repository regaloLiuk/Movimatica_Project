<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<c:set var="lang" value="${pageContext.request.locale.language}"/>
<fmt:setLocale value="${lang}"/>
<fmt:setBundle basename="main.messages"/>
<html lang="${lang}">
<head>
        <title>Add Ballast Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
		<div class="container-fluid">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/"/>">Home</a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value = "/web/ballast/show"/>"><fmt:message key="label.ballast"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.insert"/></li>
				</ol>
			</nav>
			<h2 class="font-weight-light"><fmt:message key="label.addBallast"/></h2>
			<form action= "<c:url value = "/web/ballast/add"/>" method="post">
				<c:set var="languages" value="${['en','fr','it']}"/>
				<input type="hidden" value="${languages.size()}" name="length">
				<c:set var="i" value="${0}"/>
				<c:forEach items="${languages}" var="language">
					<div class="row justify-content-md-center">
						<div class="col-1">
							<label for="staticEmail2" class="font-weight-bold"><fmt:message key="label.lang"/></label>
							<input type="text" readonly class="form-control-plaintext" id="staticEmail2" name="lang${i}" value="${language}">
						</div>
						<div class="col-9">
							<label for="validationDefault03" class="font-weight-bold"><fmt:message key="label.insertName"/></label>
							<input type="text" class="form-control" id="validationDefault03" name="name${i}" placeholder="Name" <c:if test="${language eq 'en'}"> required </c:if>>
						</div>
					</div>
					<c:set var="i" value="${i+1}"/>
				</c:forEach>
				<br>
				<div class="row justify-content-md-center">
					<div class="col-10">
						<button type="submit" class="btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
					</div>
				</div>
			</form>
			<c:if test = "${!requestScope.insert}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${requestScope.error.get(lang.toString())}"/>
				</div>
			</c:if>
		</div>
</body>
</html>
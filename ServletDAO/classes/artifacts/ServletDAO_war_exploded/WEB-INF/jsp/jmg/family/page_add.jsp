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
        <title>AddFamily Page</title>
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
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value = "/web/family/show"/>"><fmt:message key="label.family"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.insert"/></li>
				</ol>
			</nav>
			<h1 class="font-weight-light"><fmt:message key="label.addFamily"/></h1>
			<br>
			<form class="needs-validation" action="<c:url value="/web/family/add"/>" method="post" enctype="multipart/form-data">
				<c:set var="languages" value="${['en','fr','it']}"/>
				<c:set var="i" value="${0}"/>
				<c:forEach items="${languages}" var="language">
					<div class="row justify-content-md-center">
						<div class="col-2">
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
				<br/>
				<div class="row justify-content-center">
					<div class="col-11">
						<div class="custom-file">
							<input type="file"  name="uploadFile" class="custom-file-input" id="validatedInputGroupCustomFile">
							<label class="custom-file-label" for="validatedInputGroupCustomFile"><fmt:message key="label.selectImage"/></label>
						</div>
					</div>
				</div>
				<br>
				<div class="row justify-content-center">
					<div class="col-11">
						<button type="submit" class="btn btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
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
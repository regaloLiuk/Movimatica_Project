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
        <title>Modify Family Page</title>
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
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.modify"/></li>
				</ol>
			</nav>			
			<h2 class="font-weight-light"><fmt:message key="label.modifyFamily"/></h2>
			<div class="container-fluid px-lg-5">
				<div class="row mx-lg-n5 justify-content-start">
					<div class="col py-3 px-lg-5">
						<h4 class="font-weight-light"><fmt:message key="label.modifyName"/></h4>
						<form action="<c:url value="/web/family/modifyName"/>" method="post">
							<input name="id" type="hidden" value="${requestScope.family.id}">
							<c:set var="languages" value="${['en','fr','it']}"/>
							<input type="hidden" value="${languages.size()}" name="length">
							<c:set var="i" value="${0}"/>
							<c:forEach items="${languages}" var="language">
								<div class="row justify-content-md-center">
									<div class="col-2">
										<label for="staticEmail2" class="font-weight-bold"><fmt:message key="label.lang"/></label>
										<input type="text" readonly class="form-control-plaintext" id="staticEmail2" name="lang${i}" value="${language}">
									</div>
									<div class="col">
										<label for="validationDefault03" class="font-weight-bold"><fmt:message key="label.insertName"/></label>
										<input type="text" class="form-control" id="validationDefault03" name="name${i}" value="${requestScope.family.name.get(language)}" placeholder="Name">
									</div>
								</div>
								<c:set var="i" value="${i+1}"/>
							</c:forEach>
							<br>
							<div class="row justify-content-md-center">
								<div class="col">
									<button type="submit" class="btn btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
								</div>
							</div>
						</form>
					</div>
					<div class="col py-3 px-lg-5">
						<div class="row no-gutters">
							<div class="col-md-4">
								<img class="rounded float-right" src="data:image/png;base64,${family.image}" alt="..." width="200" height="200">
							</div>
							<div class="col-md-8">
								<div class="card-body">
									<h4 class="card-title font-weight-light"><fmt:message key="label.modifyImage"/></h4>
									<form action= "<c:url value="/web/family/modifyImage"/>" method="post" enctype="multipart/form-data">
										<input name="id" type="hidden" value="${requestScope.family.id}">
										<div class="form-group">
											<label for="exampleFormControlFile1"><fmt:message key="label.selectImage"/></label>
											<input type="file" name="uploadFile" class="form-control-file" id="exampleFormControlFile1" required>
										</div>
										<button type="submit" class="btn btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<c:if test = "${!requestScope.modify}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${requestScope.error.get(lang.toString())}"/>
				</div>
			</c:if>
		</div>
	</body>
</html>

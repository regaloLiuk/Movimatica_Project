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
       <title>Modify Machine Ballast Page</title>
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
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/machine/show"><c:param name="family" value="${requestScope.machine.family.id}"/></c:url>"><fmt:message key="label.machine"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/machine/details"><c:param name="id" value="${requestScope.machine.id}"/></c:url>"><fmt:message key="label.details"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.updateBallast"/></li>
				</ol>
			</nav>
			<h2 class="font-weight-light"><fmt:message key="label.machine"/>: <c:out value="${requestScope.machine.name.get(lang.toString())}"/>, <fmt:message key="label.ballast"/>: <c:out value="${requestScope.ballast.name.get(lang.toString())}"/></h2>
			<c:if test = "${!requestScope.modify}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${requestScope.message.get(lang.toString())}"/>
				</div>
			</c:if>
			<div class="container-fluid px-4">
				<div class="row mx-lg-n5 justify-content-start">
					<div class="col py-3 px-lg-5">
						<form action="<c:url value="/web/machine/ModifyBallastData"/>" method="post">
							<input name="machine" type="hidden" value="${requestScope.machine.id}">
							<input name="ballast" type="hidden" value="${requestScope.ballast.id}">
							<div class="row">
								<div class="col">
									<label class="font-weight-bold" for="inputWeight"><fmt:message key="label.weight"/></label>
									<input id="inputWeight" type="number" step="any" value="${requestScope.ballast.weight}" name="weight" class="form-control">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col">
									<label class="font-weight-bold" for="inputKgMm"><fmt:message key="label.kgMm"/></label>
									<input id="inputKgMm" type="number" step="any" value="${requestScope.ballast.kgMm}" name="kgmm" class="form-control">
								</div>
							</div>
							<br>
							<div class="row">
								<div class="col">
									<p class="font-weight-bold" for="setPredefined"><fmt:message key="label.predefined"/></p>
									<div id="setPredefined" class="custom-control custom-radio custom-control-inline">
										<input type="radio" id="customRadioInline1" name="predefined" value="true" class="custom-control-input" <c:if test="${requestScope.ballast.predefined}">checked</c:if>>
										<label class="custom-control-label" for="customRadioInline1"><fmt:message key="label.true"/></label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
										<input type="radio" id="customRadioInline2" name="predefined" value="false" class="custom-control-input" <c:if test="${!requestScope.ballast.predefined}">checked</c:if>>
										<label class="custom-control-label" for="customRadioInline2"><fmt:message key="label.false"/></label>
									</div>
								</div>
							</div>
							<br>
							<button type="submit" class="btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
						</form>
					</div>
					<div class="col py-3 px-lg-5">
						<form action="<c:url value="/web/machine/ModifyBallastImage"/>" method="post" enctype="multipart/form-data">
							<input name="machine" type="hidden" value="${requestScope.machine.id}">
							<input name="ballast" type="hidden" value="${requestScope.ballast.id}">
							<c:choose>
								<c:when test="${empty requestScope.ballast.image}">
									<img src="<c:url value="/media/Image.png"/>" alt="..." width="200" height="200">
								</c:when>
								<c:otherwise>
									<img src="data:image/png;base64,${requestScope.ballast.image}" alt="..." width="200" height="200">
								</c:otherwise>
							</c:choose>
							<div class="custom-file">
								<input type="file" name="uploadFile" class="custom-file-input" id="validatedInputGroupCustomFile" placeholder="Image">
								<label class="custom-file-label" for="validatedInputGroupCustomFile"><fmt:message key="label.selectImage"/></label>
							</div>
							<br>
							<br>
							<button type="submit" class="btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>

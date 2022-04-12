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
        <title>Summary</title>
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
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/family"/>"><fmt:message key="label.selectFamily"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/configuration"><c:param name="family" value="${requestScope.machine.family.id}"/></c:url>"><fmt:message key="label.selectMachine"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/ballast"><c:param name="machine" value="${requestScope.machine.id}"/></c:url>"><fmt:message key="label.selectBallast"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/accessory"><c:param name="machine" value="${requestScope.machine.id}"/><c:param name="ballast" value="${requestScope.ballast.id}"/></c:url>"><fmt:message key="label.selectAccessory"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.loadData"/></li>
				</ol>
			</nav>
		</div>
		<div class="container-fluid">
			<h2 class="font-weight-light"><fmt:message key="label.summary"/></h2>
			<div class="row row-cols-md-6 justify-content-md-center">
				<div class="col mb-3">
					<div class="card h-100 border-success">
						<div class="card-body">
							<c:choose>
								<c:when test="${empty requestScope.machine.image}">
									<img src="<c:url value="/media/Image.png"/>" class="card-img"
										 alt="<c:out value="${requestScope.machine.name.get(lang.toString())}"/>" width="300">
								</c:when>
								<c:otherwise>
									<img src="<c:url value="data:image/png;base64,${requestScope.machine.image}"/>" class="card-img"
										 alt="<c:out value="${requestScope.machine.name.get(lang.toString())}"/>" width="300">
								</c:otherwise>
							</c:choose>
							<h5 class="card-title text-center"><fmt:message key="label.configuration"/></h5>
							<p class="text-center font-weight-bold">
								<c:choose>
									<c:when test="${empty requestScope.machine.name.get(lang.toString())}">
										<c:out value="${requestScope.machine.name.get('en')}"/>
									</c:when>
									<c:otherwise>
										<c:out value="${requestScope.machine.name.get(lang.toString())}"/>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
				<div class="col mb-3">
					<div class="card h-100 border-success">
						<div class="card-body">
							<c:choose>
								<c:when test="${empty requestScope.ballast.image}">
									<img src="<c:url value="/media/Image.png"/>" class="card-img"
										 alt="<c:out value="${requestScope.ballast.name.get(lang.toString())}"/>" width="300">
								</c:when>
								<c:otherwise>
									<img src="<c:url value="data:image/png;base64,${requestScope.ballast.image}"/>" class="card-img"
										 alt="<c:out value="${requestScope.ballast.name.get(lang.toString())}"/>" width="300">
								</c:otherwise>
							</c:choose>
							<h5 class="card-title text-center"><fmt:message key="label.ballast"/></h5>
							<p class="text-center font-weight-bold">
								<c:choose>
									<c:when test="${empty requestScope.ballast.name.get(lang.toString())}">
										<c:out value="${requestScope.ballast.name.get('en')}"/>
									</c:when>
									<c:otherwise>
										<c:out value="${requestScope.ballast.name.get(lang.toString())}"/>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
				<div class="col mb-3">
					<div class="card h-100 border-success">
						<div class="card-body">
							<c:choose>
								<c:when test="${empty requestScope.accessory.image}">
									<img src="<c:url value="/media/Image.png"/>" class="card-img" alt="<c:out value="${requestScope.accessory.name.get(lang.toString())}"/>" width="300">
								</c:when>
								<c:otherwise>
									<img src="<c:url value="data:image/png;base64,${requestScope.accessory.image}"/>" class="card-img" alt="<c:out value="${requestScope.accessory.name.get(lang.toString())}"/>" width="300">
								</c:otherwise>
							</c:choose>
							<h5 class="card-title text-center"><fmt:message key="label.accessory"/></h5>
							<p class="text-center font-weight-bold">
								<c:choose>
									<c:when test="${empty requestScope.accessory.name.get(lang.toString())}">
										<c:out value="${requestScope.accessory.name.get('en')}"/>
									</c:when>
									<c:otherwise>
										<c:out value="${requestScope.accessory.name.get(lang.toString())}"/>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
			</div>
			<br>
			<h2 class="font-weight-light"><fmt:message key="label.insertLoad"/></h2>
			<div class="container-fluid">
				<form action="<c:url value = "/web/calculator/calculation"/>" method="post">
					<input type="hidden" name="machine" value="${requestScope.machine.id}">
					<input type="hidden" name="ballast" value="${requestScope.ballast.id}">
					<input type="hidden" name="accessory" value="${requestScope.accessory.id}">
					<div class="row">
						<c:if test="${requestScope.floating_head}">
							<div class="col">
								<div class="form-group mx-sm-3 mb-2">
									<label for="radioSelecet" class="font-weight-bold"><fmt:message key="label.headPosition"/></label>
									<c:forEach var="head_position" items="${requestScope.head_positions}">
										<div id="radioSelecet" class="custom-control custom-radio">
											<input type="radio" class="custom-control-input" id="customControlValidation${head_position}" name="head_position" value="${head_position.key}" <c:if test="${head_position.key==requestScope.head_position}">checked</c:if> required>
											<label class="custom-control-label" for="customControlValidation${head_position}">
												<span class="align-middle"><fmt:message key="label.position"/> <c:out value="${head_position.key}"/> (<c:out value="${head_position.value}"/>)</span>
											</label>
										</div>
									</c:forEach>
								</div>
							</div>
						</c:if>
						<div class="col">
							<label for="inputCargo" class="font-weight-bold"><fmt:message key="label.load"/> (t)</label>
							<input id="inputCargo" type="number" min="1" max="100" name = "cargo" class="form-control" value="${requestScope.cargo}" required>
						</div>
						<div class="col">
							<label for="inputRange" class="font-weight-bold"><fmt:message key="label.radius"/> (mt.)</label>
							<input id="inputRange" type="number" min="1" max="100" name = "radius" class="form-control" value="${requestScope.radius}" required>
						</div>
						<div class="col">
							<label for="inputAltitude" class="font-weight-bold"><fmt:message key="label.altitude"/> (mt.)</label>
							<input id="inputAltitude" type="number" min="1" max="100" name = "altitude" class="form-control" value="${requestScope.altitude}" required>
						</div>
					</div>
					<br>
					<button type="submit" class="btn btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
				</form>
			</div>		
		</div>
	</body>
</html>
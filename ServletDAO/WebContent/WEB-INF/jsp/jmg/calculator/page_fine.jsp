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
<meta charset="UTF-8">
<head>
	<title>Machine Details</title>
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
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/configuration">
						<c:param name="family" value="${requestScope.calc.machine.family.id}"/>
					</c:url>"><fmt:message key="label.selectMachine"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/ballast">
						<c:param name="machine" value="${requestScope.calc.machine.id}"/>
					</c:url>"><fmt:message key="label.selectBallast"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/accessory">
						<c:param name="machine" value="${requestScope.calc.machine.id}"/>
						<c:param name="ballast" value="${requestScope.calc.ballast.id}"/>
					</c:url>"><fmt:message key="label.selectAccessory"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value = "/web/calculator/data">
		       			<c:param name="machine" value="${requestScope.calc.machine.id}"/><c:param name="ballast" value="${requestScope.calc.ballast.id}"/><c:param name="accessory" value="${requestScope.calc.accessory.id}"/>
			       		<c:param name="cargo" value="${requestScope.calc.cargo}"/><c:param name="altitude" value="${requestScope.calc.altitude}"/><c:param name="radius" value="${requestScope.calc.radius}"/><c:param name="head_position" value="${requestScope.calc.rotatingHeadPosition}"/>
		       		</c:url>"><fmt:message key="label.loadData"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.result"/></li>
				</ol>
			</nav>
			<c:choose>
				<c:when test="${requestScope.show}">
					<h2 class="font-weight-light"><fmt:message key="label.result"/></h2>	
					<div class="row justify-content-md-center">
						<div class="col mb-4">
							<div class="card text-center border-success">
							  <div class="card-body">
							  	<div class="row">
									  	<c:if test="${requestScope.floating_head}">
											<div class="col">
												<h5 class="text-center"><strong><fmt:message key="label.headPosition"/></strong></h5>
												<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.rotatingHeadPosition}"/></h3>
											</div>
										</c:if>
										<div class="col">
											<h5 class="text-center"><strong><fmt:message key="label.load"/></strong></h5>
											<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.cargo/1000}"/>&nbsp;t</h3>
										</div>
										<div class="col">
											<h5 class="text-center"><strong><fmt:message key="label.altitude"/></strong></h5>
											<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.altitude/1000}"/>&nbsp;mt.</h3>
									  	</div>
										<div class="col">
											<h5 class="text-center"><strong><fmt:message key="label.radius"/></strong></h5>
											<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.radius/1000}"/>&nbsp;mt.</h3>
										</div>
							  		</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row justify-content-md-center">
						<div class="col mb-4">
							<div class="card text-center border-success">
							  <div class="card-body">
							    <h5 class="text-center"><fmt:message key="label.frontLoad"/></h5>
							    <h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.frontAxisLoad}"/>&nbsp;kg</h3>
							   	<h5 class="text-center"><fmt:message key="label.frontArea"/></h5>
								<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.acft}"/>&nbsp;cm<sup>3</sup></h3>
							 	<h5 class="text-center"><fmt:message key="label.frontPressure"/></h5>
								<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.gpfw}"/>&nbsp;kg/cm<sup>2</sup></h3>
							  </div>
							</div>
						</div>
						<div class="col mb-4">
							<div class="card text-center border-success">
							  <div class="card-body">
								<h5 class="text-center"><fmt:message key="label.rearLoad"/></h5>
								<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.rearAxisLoad}"/>&nbsp;kg</h3>
								<h5 class="text-center"><fmt:message key="label.rearArea"/></h5>
								<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.acrt}"/>&nbsp;cm<sup>3</sup></h3>
								<h5 class="text-center"><fmt:message key="label.rearPressure"/></h5>
								<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.gprw}"/>&nbsp;kg/cm<sup>2</sup></h3>
							  </div>
							</div>
						</div>
					</div>
					<c:if test="${!requestScope.calc.machine.onTyre}">
						<div class="row justify-content-md-center">
						<div class="col mb-4">
							<div class="card text-center border-success">
							  <div class="card-body">
								<h5 class="text-center"><strong><fmt:message key="label.stabilizerLoad"/></strong></h5>
								<h3 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.calc.stabilizersLoad/100}"/>&nbsp;kg/cm<sup>2</sup></h3>
							  </div>
							</div>
						</div>
						</div>
					</c:if>	
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger" role="alert">
						<h2 class="text-center"><c:out value="${requestScope.error.get(lang.toString())}"/></h2>
					</div>
					<h2>
						<a class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/calculator/data">
							<c:param name="machine" value="${requestScope.calc.machine.id}"/><c:param name="ballast" value="${requestScope.calc.ballast.id}"/>
							<c:param name="accessory" value="${requestScope.calc.accessory.id}"/><c:param name="head_position" value="${requestScope.calc.rotatingHeadPosition}"/></c:url>">
							<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-counterclockwise" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z"/>
								<path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z"/>
							</svg>
							<fmt:message key="label.newData"/>
						</a>
					</h2>
				</c:otherwise>
			</c:choose>
			<h2 class="font-weight-light"><fmt:message key="label.summary"/></h2>
			<div class="row row-cols-md-6 justify-content-md-center">
			<div class="col">
				<div class="card h-100 border-success">
					<div class="card-body">
						<c:choose>
							<c:when test="${empty requestScope.calc.machine.image}">
								<img src="<c:url value="/media/Image.png"/>" class="card-img" alt="<c:out value="${requestScope.calc.machine.name.get(lang.toString())}"/>" height="300" width="300">
							</c:when>
							<c:otherwise>
								<img src="<c:url value="data:image/png;base64,${requestScope.calc.machine.image}"/>" class="card-img" alt="<c:out value="${requestScope.calc.machine.name.get(lang.toString())}"/>" height="300" width="300">
							</c:otherwise>
						</c:choose>
						<h5 class="card-title text-center"><fmt:message key="label.configuration"/></h5>
						<p class="text-center font-weight-bold">
							<c:choose>
								<c:when test="${empty requestScope.calc.machine.name.get(lang.toString())}">
									<c:out value="${requestScope.calc.machine.name.get('en')}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${requestScope.calc.machine.name.get(lang.toString())}"/>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card h-100 border-success">
					<div class="card-body">
						<c:choose>
							<c:when test="${empty requestScope.calc.ballast.image}">
								<img src="<c:url value="/media/Image.png"/>" class="card-img"
									 alt="<c:out value="${requestScope.calc.ballast.name.get(lang.toString())}"/>" height="300" width="300">
							</c:when>
							<c:otherwise>
								<img class="card-img" src="<c:url value="data:image/png;base64,${requestScope.calc.ballast.image}"/>"
									 alt="<c:out value="${requestScope.calc.ballast.name.get(lang.toString())}"/>" height="300" width="300">
							</c:otherwise>
						</c:choose>
						<h5 class="card-title text-center"><fmt:message key="label.ballast"/></h5>
						<p class="text-center font-weight-bold">
							<c:choose>
								<c:when test="${empty requestScope.calc.ballast.name.get(lang.toString())}">
									<c:out value="${requestScope.calc.ballast.name.get('en')}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${requestScope.calc.ballast.name.get(lang.toString())}"/>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card h-100 border-success">
					<div class="card-body">
						<c:choose>
							<c:when test="${empty requestScope.calc.accessory.image}">
								<img src="<c:url value="/media/Image.png"/>" class="card-img"
									 alt="<c:out value="${requestScope.calc.accessory.name.get(lang.toString())}"/>" height="300" width="300">
							</c:when>
							<c:otherwise>
								<img class="card-img" src="<c:url value="data:image/png;base64,${requestScope.calc.accessory.image}"/>"
									 alt="<c:out value="${requestScope.calc.accessory.name.get(lang.toString())}"/>" height="300" width="300">
							</c:otherwise>
						</c:choose>
						<h5 class="card-title text-center"><fmt:message key="label.accessory"/></h5>
						<p class="text-center font-weight-bold">
							<c:choose>
								<c:when test="${empty requestScope.calc.accessory.name.get(lang.toString())}">
									<c:out value="${requestScope.calc.accessory.name.get('en')}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${requestScope.calc.accessory.name.get(lang.toString())}"/>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>
			</div>
		</div>			
	</div>
</body>
</html>
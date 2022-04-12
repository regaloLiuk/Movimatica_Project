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
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/calculator/configuration"><c:param name="family" value="${requestScope.machine.family.id}"/></c:url>"><fmt:message key="label.selectMachine"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value = "/web/calculator/ballast"><c:param name = "machine" value = "${requestScope.machine.id}"/></c:url>"><fmt:message key="label.selectBallast"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.selectAccessory"/></li>
				</ol>
			</nav>
		</div>
       	<c:choose>
	        <c:when test = "${requestScope.machine.ballasts.isEmpty()}">
	        	<div class="alert alert-danger" role="alert">
					<fmt:message key="label.noAccessory"/>
				</div>
	        </c:when>
	        <c:otherwise>
				<div class="container-fluid">
					<h2 class="font-weight-light"><fmt:message key="label.chooseAccessory"/></h2>
					<div class="row row-cols-md-5 justify-content-md-center">
						<c:forEach items="${requestScope.machine.accessories}" var="accessory">
							<div class="col mb-4">
								<div class="card h-100 border-success">
									<div class="card-body">
										<a class="text-success" href="<c:url value="/web/calculator/data"><c:param name="accessory" value="${accessory.id}"/>
											<c:param name="ballast" value="${requestScope.ballast}"/>
											<c:param name="machine" value="${requestScope.machine.id}"/></c:url>">
											<c:choose>
												<c:when test="${empty accessory.image}">
													<img src="<c:url value="/media/Image.png"/>" class="card-img"
														 alt="<c:out value="${accessory.name.get(lang.toString())}"/>"
														 height="300" width="300">
												</c:when>
												<c:otherwise>
													<img src="<c:url value="data:image/png;base64,${accessory.image}"/>"
														 class="card-img"
														 alt="<c:out value="${accessory.name.get(lang.toString())}"/>"
														 height="300" width="300">
												</c:otherwise>
											</c:choose>
											<h3 class="text-center text-break">
												<c:choose>
													<c:when test="${empty accessory.name.get(lang.toString())}">
														<c:out value="${accessory.name.get('en')}"/>
													</c:when>
													<c:otherwise>
															<c:out value="${accessory.name.get(lang.toString())}"/>
													</c:otherwise>
												</c:choose>
											</h3>
										</a>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
	  		</c:otherwise>
	  	</c:choose>
	</body>
</html>
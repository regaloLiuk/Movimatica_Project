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
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value = "/web/family/show"/>"><fmt:message key="label.family"/></a></li>
					<li class="breadcrumb-item"><a class="text-success" href="<c:url value="/web/machine/show"><c:param name="family" value="${requestScope.machine.family.id}"/></c:url>"><fmt:message key="label.machine"/></a></li>
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.details"/></li>
				</ol>
			</nav>
			<h2 class="font-weight-light"><fmt:message key="label.configuration"/>: <c:out value="${requestScope.machine.name.get(lang.toString())}"/></h2>
			<div class="card mb-3 border-success">
				<div class="row no-gutters">
					<div class="col">
						<c:choose>
							<c:when test="${empty requestScope.machine.image}">
								<img src="<c:url value="/media/Image.png"/>" class="rounded float-left align-middle" alt="${requestScope.machine.name.get(lang.toString())}">
							</c:when>
							<c:otherwise>
								<img src="data:image/png;base64,${machine.image}" class="rounded float-left align-middle" alt="${requestScope.machine.name.get(lang.toString())}" height="200" width="200">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-md-10">
						<div class="card-body">
							<div class="row">
    							<div class="col"> 	
    								<div class="card text-white bg-success mb-3">
									  	<div class="card-body">
										    <h5 class="text-center"><fmt:message key="label.ArmLength"/> Min - Max</h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.minArmLength}"/> - <fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.maxArmLength}"/></h4> 
										</div>
									</div>
								</div>
								<div class="col">
	 								<div class="card text-white bg-success mb-3">
									  	<div class="card-body">
										    <h5 class="text-center "><fmt:message key="label.Swing"/> Min - Max</h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.minSwing}"/> - <fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.maxSwing}"/></h4> 
										</div>
									</div>
								</div>
								<div class="col">
									<div class="card text-white bg-success mb-3">
									  	<div class="card-body">
										    <h5 class="text-center "><fmt:message key="label.plateArea"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.plateArea}"/></h4> 
										</div>
									</div>
								</div>
							</div>
							<div class="row">
    							<div class="col">
									<div class="card text-white bg-success mb-3">
									  	<div class="card-body">
										    <h5 class="text-center"><fmt:message key="label.Wheel"/>
												<fmt:message key="label.front"/> - <fmt:message key="label.rear"/>
											</h5>
											<h4 class="text-center font-weight-bold">
												<fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.frontWheel}"/> - <fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.rearWheel}"/>
											</h4>
										</div>
									</div>
								</div>
    							<div class="col">
	 								<div class="card text-white bg-success mb-3">
									  	<div class="card-body">
										    <h5 class="text-center ">
												<fmt:message key="label.wheelBase"/>
											</h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.wheelBase}"/></h4> 
										</div>
									</div>
								</div>
    							<div class="col">
	 								<div class="card text-white bg-success mb-3">
									  	<div class="card-body">
										    <h5 class="text-center "><fmt:message key="label.onTyre"/></h5>
											<h4 class="text-center font-weight-bold">
												<c:choose>
													<c:when test="${requestScope.machine.onTyre}">
														<fmt:message key="label.true"/>
													</c:when>
													<c:otherwise>
														<fmt:message key="label.false"/>
													</c:otherwise>
												</c:choose>
											</h4> 
										</div>
									</div>
								</div>
							</div>
							<div class="row">
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									   	 	<h5 class="text-center "><fmt:message key="label.emptyWeight"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.emptyWeight}"/></h4> 
										</div>
									</div>
    							</div>
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	   <h5 class="text-center "><fmt:message key="label.batteryWeight"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.batteryWeight}"/></h4> 
										</div>
									</div>
    							</div>
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
										    <h5 class="text-center "><fmt:message key="label.armWeight"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.armWeight}"/></h4> 
										</div>
									</div>
    							</div>
   							</div>
   							<div class="row">
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	   	<h5 class="text-center"><fmt:message key="label.fgp"/> Multiplier - Offset</h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.multiplierFrontGroundPressure}"/> - <fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.offsetFrontGroudPressure}"/></h4> 
										</div>
									</div>
    							</div>
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	  	<h5 class="text-center "><fmt:message key="label.rgp"/> Multiplier - Offset</h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.multiplierRearGroudPressure}"/> - <fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.offsetRearGroudPressure}"/></h4> 
										</div>
									</div>
    							</div>
								<div class="col">
									<div class="card text-white bg-success mb-3">
										<div class="card-body">
											<h5 class="text-center "><fmt:message key="label.df"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.df}"/></h4>
										</div>
									</div>
								</div>
    						</div>
 							<div class="row">
								<div class="col">
									<div class="card text-white bg-success mb-3">
										<div class="card-body">
											<h5 class="text-center "><fmt:message key="label.dha"/> Multiplier - Offset</h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.multiplierDistanceHubToArm}"/> - <fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.offsetDistanceHubToArm}"/></h4>
										</div>
									</div>
								</div>
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	  	<h5 class="text-center "><fmt:message key="label.hf"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.hf}"/></h4> 
										</div>
									</div>
    							</div>
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	  	<h5 class="text-center "><fmt:message key="label.ds"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.ds}"/></h4> 
										</div>
									</div>
    							</div>
    						</div>
    						<div class="row">
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	  	<h5 class="text-center "><fmt:message key="label.db"/></h5>
											<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.dvg}"/></h4> 
										</div>
									</div>
    							</div>
    							<div class="col">
    								<div class="card text-white bg-success mb-3">
								  		<div class="card-body">
									 	  	<h5 class="text-center "><fmt:message key="label.dvg"/></h5>
										<h4 class="text-center font-weight-bold"><fmt:formatNumber type="number" groupingUsed="false" value="${requestScope.machine.db}"/></h4>
										</div>
									</div>
    							</div>
    						</div>
							<br>
							<a class="btn btn-outline-success btn-lg btn-block" href="<c:url value = "/web/machine/ModifyConfiurationData">
								<c:param name = "machine" value = "${requestScope.machine.id}"/>
								<c:param name = "modify" value = "configuration"/></c:url>">
								<fmt:message key="label.modifyConfiguration"/>
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
								</svg>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-auto">
					<h3 class="font-weight-light"><fmt:message key="label.ballasts"/></h3>
					<c:choose>
						<c:when test = "${requestScope.machine.ballasts.size() gt 0}">
							<table class="table table-sm">
								<caption>
									<a class="btn btn-outline-success" href="<c:url value="/web/machine/AddBallast"><c:param name="machine" value="${requestScope.machine.id}"/></c:url>">
										<fmt:message key="label.addBallast"/>
										<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
											<path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
										</svg>
									</a>
								</caption>
								<thead>
								<tr>
									<th></th>
									<th class="text-center" scope="col"><fmt:message key="label.name"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.weight"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.kgMm"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.isPredefined"/></th>
									<th scope="col" colspan="1"></th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${requestScope.machine.ballasts}" var="ballast">
									<tr>
										<td>
											<a class="text-success" href="<c:url value = "/web/machine/ModifyBallastData">
												<c:param name = "machine" value = "${requestScope.machine.id}"/>
												<c:param name = "ballast" value = "${ballast.id}"/></c:url>">
												<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
													<path fill-rule="evenodd" d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
												</svg>
											</a>
											&emsp;
											<a class="text-success" href="<c:url value = "/web/machine/DeleteBallast">
												<c:param name = "machine" value = "${requestScope.machine.id}"/>
												<c:param name = "ballast" value = "${ballast.id}"/></c:url>">
												<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
													<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
													<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h5a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
												</svg>
											</a>
										</td>
										<th class="text-center" scope="row"><c:out value="${ballast.name.get(lang.toString())}"/></th>
										<td class="text-center"><fmt:formatNumber type="number" groupingUsed="false" value="${ballast.weight}"/></td>
										<td class="text-center"><fmt:formatNumber type="number" groupingUsed="false" value="${ballast.kgMm}"/></td>
										<td class="text-center"><c:out value="${ballast.predefined}"/></td>
										<td>
											<c:choose>
												<c:when test="${not empty ballast.image}">
													<img src="data:image/png;base64,${ballast.image}" alt="..." width="50" height="50">
												</c:when>
												<c:otherwise>
													<img src="<c:url value="/media/Image.png"/>" class="rounded float-left align-middle" alt="${requestScope.machine.name.get(lang.toString())}" width="50" height="50">
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</c:when>
						<c:otherwise>
							<div class="alert alert-danger" role="alert">
								<p class="text-center"><fmt:message key="label.noBallast"/></p>
							</div>
							<a class="btn btn-outline-success btn-lg btn-block" href="<c:url value="/web/machine/AddBallast"><c:param name="machine" value="${requestScope.machine.id}"/></c:url>">
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									<path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
								</svg>
								<fmt:message key="label.addBallast"/>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col">
					<h3 class="font-weight-light"><fmt:message key="label.accessories"/></h3>
					<c:choose>
						<c:when test = "${requestScope.machine.accessories.size() gt 0}">
							<table class="table table-sm">
								<caption>
									<a class="btn btn-outline-success" href="<c:url value="/web/machine/AddAccessory"><c:param name="machine" value="${requestScope.machine.id}"/></c:url>">
										<fmt:message key="label.addAccessory"/>
										<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
											<path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
										</svg>
									</a>
								</caption>
								<thead>
								<tr>
									<th></th>
									<th class="text-center" scope="col"><fmt:message key="label.name"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.weight"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.length"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.distance"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.headOffset"/></th>
									<th class="text-center" scope="col"><fmt:message key="label.isPredefined"/></th>
									<th scope="col" colspan="1"></th>
								</tr>
								</thead>
								<tbody>
								<c:forEach items="${requestScope.machine.accessories}" var="accessory">
									<tr>
										<td>
											<a class="text-success" href="<c:url value = "/web/machine/ModifyAccessoryData">
												<c:param name = "machine" value = "${requestScope.machine.id}"/>
												<c:param name = "accessory" value = "${accessory.id}"/></c:url>">
												<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-pencil" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
													<path fill-rule="evenodd" d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
												</svg>
											</a>
											&emsp;
											<a class="text-success" href="<c:url value = "/web/machine/DeleteAccessory">
												<c:param name = "machine" value = "${requestScope.machine.id}"/>
												<c:param name = "accessory" value = "${accessory.id}"/></c:url>">
												<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
													<path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
													<path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h5a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
												</svg>
											</a>
										</td>
										<th class="text-center" scope="row"><c:out value="${accessory.name.get(lang.toString())}"/></th>
										<td class="text-center"><fmt:formatNumber type="number" groupingUsed="false" value="${accessory.weight}"/></td>
										<td class="text-center"><fmt:formatNumber type="number" groupingUsed="false" value="${accessory.length}"/></td>
										<td class="text-center"><fmt:formatNumber type="number" groupingUsed="false" value="${accessory.distance}"/></td>
										<td class="text-center"><c:out value="${accessory.headOffset}"/></td>
										<td class="text-center"><c:out value="${accessory.predefined}"/></td>
										<td>
											<c:choose>
												<c:when test="${not empty accessory.image}">
													<img src="data:image/png;base64,${accessory.image}" alt="..." width="50" height="50">
												</c:when>
												<c:otherwise>
													<img src="<c:url value="/media/Image.png"/>" class="rounded float-left align-middle" alt="${requestScope.machine.name.get(lang.toString())}" width="50" height="50">
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</c:when>
						<c:otherwise>
							<div class="alert alert-danger" role="alert">
								<p class="text-center"><fmt:message key="label.noAccessory"/></p>
							</div>
							<a class="btn btn-outline-primary btn-lg btn-block" href="<c:url value="/web/machine/AddAccessory"><c:param name="machine" value="${requestScope.machine.id}"/></c:url>">
								<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-plus-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									<path fill-rule="evenodd" d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
								</svg>
								<fmt:message key="label.addAccessory"/>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</body>
</html>
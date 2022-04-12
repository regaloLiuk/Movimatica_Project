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
       <title>Modify Machine Page</title>
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
					<li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.modifyConfiguration"/></li>
				</ol>
			</nav>
			<c:if test = "${!requestScope.modify}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${requestScope.error.get(lang.toString())}"/>
				</div>
			</c:if>
			<h3 class="font-weight-light"><fmt:message key="label.modifyData"/></h3>
			<form action="<c:url value = "/web/machine/ModifyConfiurationData"/>" method="post">
				<input name="id" type="hidden" value="${requestScope.machine.id}">
				<c:set var="languages" value="${['en','fr','it']}"/>
				<input type="hidden" value="${languages.size()}" name="length">
				<c:set var="i" value="${0}"/>
				<div class="container-fluid">
					<h4 class="font-weight-light"><fmt:message key="label.registry"/></h4>
					<div class="row">
						<c:forEach items="${languages}" var="language">
							<div class="col-1">
								<label for="staticEmail2" class="font-weight-bold"><fmt:message key="label.lang"/></label>
								<input type="text" readonly class="form-control-plaintext" id="staticEmail2" name="lang${i}" value="${language}">
							</div>
							<div class="col">
								<label for="validationDefault03" class="font-weight-bold"><fmt:message key="label.insertName"/></label>
								<input type="text" class="form-control" id="validationDefault03" name="name${i}" value="${requestScope.machine.name.get(language)}" placeholder="Name">
							</div>
							<c:set var="i" value="${i+1}"/>
						</c:forEach>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="FamilySelect"><fmt:message key="label.family"/></label>
							<select id="FamilySelect" class="custom-select mr-sm-2" name="family" required>
								<option selected value="${requestScope.machine.family.id}"><c:out value="${requestScope.machine.family.name.get(lang.toString())}"/></option>
								<c:forEach items="${requestScope.families}" var="fam">
									<option value="${fam.id}"><c:out value="${fam.name.get(lang.toString())}"/></option>
								</c:forEach>
							</select>
						</div>
						<div class="col">
							<p class="font-weight-bold"><label for="inputTyre"><fmt:message key="label.onTyre"/></label></p>
							<div id="inputTyre" class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="customRadioInline1" name="tyre" value="true" class="custom-control-input" <c:if test="${requestScope.machine.onTyre}">checked</c:if>>
								<label class="custom-control-label" for="customRadioInline1"><fmt:message key="label.true"/></label>
							</div>
							<div class="custom-control custom-radio custom-control-inline">
								<input type="radio" id="customRadioInline2" name="tyre" value="false" class="custom-control-input" <c:if test="${!requestScope.machine.onTyre}">checked</c:if>>
								<label class="custom-control-label" for="customRadioInline2"><fmt:message key="label.false"/></label>
							</div>
						</div>
					</div>
					<br>
					<h4 class="font-weight-light"><fmt:message key="label.numerical"/></h4>
					<div class="row ">
						<div class="col">
							<label class="font-weight-bold" for="inputMinArmLh"><fmt:message key="label.minArmLength"/></label>
							<input id="inputMinArmLh" type="number" step="any" value="${requestScope.machine.minArmLength}" name="min_arm_lh" class="form-control" placeholder="min Arm Length">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputMaxArmLh"><fmt:message key="label.maxArmLength"/></label>
							<input id="inputMaxArmLh" type="number" step="any" value="${requestScope.machine.maxArmLength}" name="max_arm_lh" class="form-control" placeholder="Max Arm Length">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputMinSwing"><fmt:message key="label.minSwing"/></label>
							<input id="inputMinSwing" type="number" step="any" value="${requestScope.machine.minSwing}" name="min_swing" class="form-control" placeholder="min Swing">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputMaxSwing"><fmt:message key="label.maxSwing"/></label>
							<input id="inputMaxSwing" type="number" step="any" value="${requestScope.machine.maxSwing}" name="max_swing" class="form-control" placeholder="Max Swing">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="inputFrontWheel"><fmt:message key="label.frontWheel"/></label>
							<input id="inputFrontWheel" type="number" step="any" value="${requestScope.machine.frontWheel}" name="front_wheel" class="form-control" placeholder="Front Wheel">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputRearWheel"><fmt:message key="label.rearWheel"/></label>
							<input id="inputRearWheel" type="number" step="any" value="${requestScope.machine.rearWheel}" name="rear_wheel" class="form-control" placeholder="Rear Wheel">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputPlateArea"><fmt:message key="label.plateArea"/></label>
							<input id="inputPlateArea" type="number" step="any" value="${requestScope.machine.plateArea}" name="plate_area" class="form-control" placeholder="Plate Area">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputWheelBase"><fmt:message key="label.wheelBase"/></label>
							<input id="inputWheelBase" type="number" step="any" value="${requestScope.machine.wheelBase}" name="wheel_base" class="form-control" placeholder="Wheel Base">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="inputmfgp"><fmt:message key="label.mfgp"/></label>
							<input id="inputmfgp" type="number" step="any" value="${requestScope.machine.multiplierFrontGroundPressure}" name="mfgp" class="form-control" placeholder="Multiplier Front Groud Pressure">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputofgp"><fmt:message key="label.ofgp"/></label>
							<input id="inputofgp" type="number" step="any" value="${requestScope.machine.offsetFrontGroudPressure}" name="ofgp" class="form-control" placeholder="Offset Front Groud Pressure">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputmrgp"><fmt:message key="label.mrgp"/></label>
							<input id="inputmrgp" type="number" step="any" value="${requestScope.machine.multiplierRearGroudPressure}" name="mrgp" class="form-control" placeholder="Multiplier Rear Groud Pressure">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputorgp"><fmt:message key="label.orgp"/></label>
							<input id="inputorgp" type="number" step="any" value="${requestScope.machine.offsetRearGroudPressure}" name="orgp" class="form-control" placeholder="Offset Rear Groud Pressure">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="inputmdha"><fmt:message key="label.mdha"/></label>
							<input id="inputmdha" type="number" step="any" value="${requestScope.machine.multiplierDistanceHubToArm}" name="mdha" class="form-control" placeholder="Multiplier Distance between Hub and Arm">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputodha"><fmt:message key="label.odha"/></label>
							<input id="inputodha" type="number" step="any" value="${requestScope.machine.offsetDistanceHubToArm}" name="odha" class="form-control" placeholder="Offset Distance between Hub and Arm">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="inputBatteryWeight"><fmt:message key="label.batteryWeight"/></label>
							<input id="inputBatteryWeight" type="number" step="any" value="${requestScope.machine.batteryWeight}" name="battery_weight" class="form-control" placeholder="Battery Weight">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputEmptyMachineWeight"><fmt:message key="label.emptyWeight"/></label>
							<input id="inputEmptyMachineWeight" type="number" step="any" value="${requestScope.machine.emptyWeight}" name="empty_weight" class="form-control" placeholder="Empty Machine Weight">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputMachineArmWeight"><fmt:message key="label.armWeight"/></label>
							<input id="inputMachineArmWeight" type="number" step="any" value="${requestScope.machine.armWeight}" name="arm_weight" class="form-control" placeholder="Machine Arm Weight">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="inputdf"><fmt:message key="label.df"/></label>
							<input id="inputdf" type="number" step="any" value="${requestScope.machine.df}" name="df" class="form-control" placeholder="Distance between Arm Hub and Rotation Center">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputds"><fmt:message key="label.ds"/></label>
							<input id="inputds" type="number" step="any" value="${requestScope.machine.ds}" name="ds" class="form-control" placeholder="Distance between Sheld and Rotation Center">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputhf"><fmt:message key="label.hf"/></label>
							<input id="inputhf" type="number" step="any" value="${requestScope.machine.hf}" name="hf" class="form-control" placeholder="Distance between Arm Hub and Ground mm">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<label class="font-weight-bold" for="inputdvg"><fmt:message key="label.dvg"/></label>
							<input id="inputdvg" type="number" step="any" value="${requestScope.machine.dvg}" name="dvg" class="form-control" placeholder="Distance between Center of Gravity Empty Machine and Rotation Center">
						</div>
						<div class="col">
							<label class="font-weight-bold" for="inputdb"><fmt:message key="label.db"/></label>
							<input id="inputdb" type="number" step="any" value="${requestScope.machine.db}" name="db" class="form-control" placeholder="Distance between Center of Gravity Battery and Rotation Center">
						</div>
					</div>
					<br>
					<button type="submit" class="btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
				</div>
			</form>
			<br>
			<h3 class="font-weight-light"><fmt:message key="label.modifyImage"/></h3>
			<form action="<c:url value = "/web/machine/ModifyConfiurationImage"/>" method="post" enctype="multipart/form-data">
				<input name="id" type="hidden" value="${requestScope.machine.id}">
				<div class="container-fluid">
					<div class="row justify-content-center">
						<div class="col-md-6 mb-3">
							<div class="card mb-3 border-success" style="max-width: 540px;">
								<div class="row no-gutters">
									<div class="col-md-4">
										<c:choose>
											<c:when test="${not empty machine.image}">
												<img src="data:image/png;base64,${machine.image}" class="card-img" alt="...">
											</c:when>
											<c:otherwise>
												<img src="<c:url value="/media/Image.png"/>" class="card-img" alt="...">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="col">
										<div class="card-title"></div>
										<div class="card-body">
											<div class="col">
												<label class="font-weight-bold" for="exampleFormControlFile1"><fmt:message key="label.selectImage"/></label>
												<input type="file" name="uploadFile" class="form-control-file" id="exampleFormControlFile1">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<button type="submit" class="btn btn-outline-success btn-lg btn-block"><fmt:message key="label.enter"/></button>
				</div>
			</form>
		</div>
	</body>
</html>

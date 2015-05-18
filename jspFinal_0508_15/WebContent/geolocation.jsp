<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>HTML5 Geolocation</title>
<style type="text/css">
html {
	height: 100%
}

body {
	font-family: sans-serif;
	background-color: #f5f5f5
}

#map-canvas {
	height: 250px
}
</style>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
	var map = null;
	function showlocation() {
		navigator.geolocation.getCurrentPosition(callback); // ���� ������
	}
	function callback(position) {
		var lat = position.coords.latitude;
		var lon = position.coords.longitude;
		document.getElementById('latitude').innerHTML = lat; // ����
		document.getElementById('longitude').innerHTML = lon; // �浵
		var latLong = new google.maps.LatLng(lat, lon); // ��ġ ���
		var marker = new google.maps.Marker({
			position : latLong
		}); // ��Ŀ ��ü�� ������ �浵�� ���缭 ����
		marker.setMap(map); // ��Ŀ�� �ʿ� ����
		map.setZoom(15); // Ȯ��(Ŭ���� �������)
		map.setCenter(marker.getPosition()); // ��Ŀ�� �߾ӿ� ��ġ
	}
	google.maps.event.addDomListener(window, 'load', initMap);
	function initMap() {
		var mapOptions = {
			center : new google.maps.LatLng(37.402062, 127.107234),
			zoom : 15,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map-canvas"),
				mapOptions);
	}
</script>
</head>
<body>
	<center>
		<input type="button" value="Show my location on Map"
			onclick="javascript:showlocation()" /> <br />
	</center>

	Latitude:
	<span id="latitude"></span>
	<br /> Longitude:
	<span id="longitude"></span>
	<br />
	<br />
	<div id="map-canvas" />
</body>
</html>
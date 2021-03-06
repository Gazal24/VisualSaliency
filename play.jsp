<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<%@ include file="check_session.jsp" %>

<%
Integer strategy = new Integer(1);
strategy = Integer.parseInt(request.getParameter("type"));
session.setAttribute("theStrategy", strategy);
String tname = (String) session.getAttribute("theTaskName");
String task_id = (String) session.getAttribute("theTask_ID");
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="helper_script.js"></script>
    <%@ include file ="head.html"%>
    <%
       response.setHeader("Pragma","no-cache"); // HTTP 1.0
       response.setHeader("Cache-Control","no-store"); // HTTP 1.1
       response.setDateHeader("Expires", 0);
       %>
    <script>
    // Code to initialize the game with method[0] and method[1] image.
    //      window.onload = loadXMLDoc(0);
    window.onload = initPlay();

    function initPlay() {
        loadXMLDoc(0);
    }

      function loadXMLDoc(a)
      {
	  var xmldoc = new XMLHttpRequest();
          if (window.XMLHttpRequest)
	      {// code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
	      }
          else
	      {// code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }
	  xmldoc.open("GET", "game1.jsp?choice="+a+"&random="+Math.random(), true);
	  xmldoc.send();
	  xmldoc.onreadystatechange=function() {
	      if (xmldoc.readyState==4 && xmldoc.status==200) {
		  resptxt = xmldoc.responseText;
		  var responseJSON = eval('(' + resptxt + ')');

		  if(a==0) { //Show/Hide divs while Initialization/Restarting
		      document.getElementById("ground").style.display = "inline";	
		      document.getElementById("result").style.display = "none";
		  }

		  if(responseJSON.left == "gameOver") {
		      document.getElementById("ground").style.display = "none";
		      document.getElementById("result").style.display = "inline";
		      document.getElementById("result").innerHTML = "Click to view scores";
		  } else {
		      document.getElementById("original").src = responseJSON.orig;
		      //document.getElementById("img1_txt").innerHTML = responseJSON.left_method;
		      document.getElementById("img1").src = responseJSON.left
		      //document.getElementById("img2_txt").innerHTML = responseJSON.right_method;
		      document.getElementById("img2").src = responseJSON.right;
		      document.getElementById("result").innerHTML = "";
		  }
	      }
	  }
      }

    function toggle() {
	if(document.getElementById("original_div").style.display == "none") {
	    document.getElementById("original_div").style.display = "inline";
	    document.getElementById("showOriginal").innerHTML = "Hide Original";
	}
	else {
	    document.getElementById("original_div").style.display = "none";
	    document.getElementById("showOriginal").innerHTML = "Show Original";
	}
	
    }

    </script>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="container">
      <%@ include file = "errormsg.jsp" %>
    </div>
    <div class="wrap">
      <div class="container">
	<ul class="breadcrumb">
	  <li><a href=<% out.println("method.jsp?taskid="+task_id); %>><%= tname %></a><span class="divider">/</span></li>
	  <li class="active">
	  <%
	     if(strategy==0)
	     out.println("Knockout ");
	     else if(strategy==1)
	     out.println("Challenging ");
	     else if(strategy==2)
	     out.println("Round-robin ");
	     %>
	  Tournament 
	  </li>
	</ul>
	<p onclick="loadXMLDoc(0)" class="medium button black" align="right">Restart</p>
	<div><a class="large button black" href="multiQuery.jsp?type=saveScore" id="result" align="center"> </a> </div>
	
	<div id="ground">
	  <div align="center">
	    <p id="showOriginal" onclick="toggle()" class="medium button black" align="center">Show Original</p>
	  </div>
	  <div id="original_div" style="display:none" align="center">
	    <table class="image_panel fixed">
	      <th>
		Original
	      </th>
	
	      <tr><td align="center">
		  <img id="original" src="" class="mainimage"></img>
	    </td></tr></table>
	  </div>
	  <br>
	  <div>
	    <div align="center">
      <table align="center" class="image_panel fixed" style="border-collapse: collapse">
	<col class="players"/>
	<col class="players"/>
	<tr align="center">
	  <th>
	      <p id="img1_txt"></p>
	  </th>
	  <th>
	      <p id="img2_txt"></p>
	  </th>
	</tr>
	<tr>
	  <td align="center">
	    <img id="img1" onclick="loadXMLDoc(1)" class="mainimage"></img>
	  </td>
	  <td align="center">
	    <img id="img2" onclick="loadXMLDoc(2)" class="mainimage"></img>
	  </td>
	</tr>
      </table>
    </div>
    </div>

      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>

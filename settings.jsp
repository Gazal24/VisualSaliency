<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp" %>

<!DOCTYPE html>
<html>
  <head>
    <script src="helper_script.js"></script>
    <%@ include file ="head.html"%>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="wrap">
      <div class="container">
	<%@ include file = "errormsg.jsp" %>
      </div> <!-- /container -->
      <div class="container">
	<div class="container-fluid">
	  <div class="row-fluid">
	    <div class="span4">
	      <ul>
		<li><a href="#" onclick="change_content('name')">Edit Name</a></li>
		<li><a href="#" onclick="change_content('passwd')">Change Password</a></li>
	      </ul>
	    </div>
	    <div class="span5">
	      <div id="Tab_content">
	      </div>
	    </div>
	  </div>
	</div>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>

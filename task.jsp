<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp" %>
<%@ include file="check_session.jsp" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
    <script src="helper_script.js"></script>
  </head>
  <body align="center">

    <div width="800" align="center">
      Hello! <%= session.getAttribute("theName") %> [<%= session.getAttribute("theUname") %>] <br />
      <%@ include file = "errormsg.jsp" %>
      <%  String referrer = request.getHeader("referer"); %>
    </div>
	<div align="right"><a class="small button black" href="logout.jsp"> Logout </a> <p>
      <a float="right" class="large button black" href="settings.jsp">Account Setting</a>      
	</div>
	    

    <div class="img_thumb">
      <table align="center" width="600">
	<% String uname = (String) session.getAttribute("theUname"); %>


       <%
         paramList.clear();
         paramList.add(uname);
         // query = "SELECT * from task WHERE uname = '" + uname +"'";
         crs = execQuery(30, paramList);

	 int counter = 0;
	 String img_path;
 	 out.println("<tr>");
         while(crs.next()) {
           String tname = crs.getString("name"); 
           String task_id = crs.getString("id");
	   img_path = "uploads/" + uname + "/" + tname + "/" + "original" + ".jpg";
  	   if(counter%3 == 0) { out.println("</tr><tr>"); counter = 0;}
      %> 
	<td class="buttons" width="500" align="center"><br>
	 <!-- <img src= <% out.print(img_path);%> alt= <% out.print(tname);%> height=100px width= 150px /> <br/> -->
	  <a class="regular" href=<% out.print("method.jsp?taskid="+task_id); %> ><h1> <% out.print(tname); %> </td>
        <%
	 counter++;
         }
         con.close();
	%>
	</tr>
      </table>
    </div>
    <div align="center">
    <table>
      <tr><td align="center"><br> <br>
	  
      <form method=post action="savetask.jsp">
      	New Task :
	<div class="field"> <input type="text" name="name" size="20" placeholder="Task Name"> </div>
	<div class="field"> <input type="text" name="count" size="50" placeholder="2"> </div>
	<br>
	<div class="buttons"> 

	  <button type="create" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
	    Create
	  </button>

	  <button type="button" class="regular" onclick="this.form.reset()" value="Reset">
            <img src="images/textfield_key.png" alt=""/>
            Reset
	</div>
      </form>
      </td></tr></table>
      </div>
  </body>
</html>

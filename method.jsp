<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp"%>
<%@ include file="check_session.jsp"%>

<html>
  <head>
    <script src="helper_script.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  <%
     String task_id = request.getParameter("taskid");
     String uname = (String) session.getAttribute("theUname");
     int login_type = (Integer) session.getAttribute("theLoginType");
     session.setAttribute("theTask_ID", task_id);
  %>
    <div align="center" width="800">
      Hello! <%= session.getAttribute("theName") %> [<%= session.getAttribute("theUname") %>] <br />
      <%@ include file = "errormsg.jsp" %>
    </div>

    <% if(login_type == 1) {  %>
      <div align="right">
	<a class="large button black" href="creategame.jsp"> Create Game </a>
      </div>
    <% } %>

    <% if(login_type == 1) {  %>
      <div align="left">
	<a class="large button black" href="upload.jsp">New Image Set </a>
      </div>
    <% } %>

    <% if(login_type == 1) {  %>
      <div align="right">
	<a class="large button black" href="result.jsp">View Overall Scoring </a>
      </div>
    <% } %>

    <% if(login_type == 2) {  %>
      <div align="right">
	<a class="large button black" href="result.jsp">View Volunteer Scoring </a>
      </div>
    <% } %>

      <%
         paramList.clear();
         paramList.add(task_id);
         crs = execQuery(40, paramList);
         // rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);

         crs.next();
	 String tname = crs.getString("name");
         session.setAttribute("theTaskName", tname);

	 int counter = 0;
	 
         paramList.clear();
         paramList.add(task_id);
         crs = execQuery(41, paramList);
         // rs = stmt.executeQuery("SELECT * from `method` WHERE task_id=" + task_id );

	 //TODO: mname array: figure out its size properly while declaring the variable.
         String mname[] = new String[100];
         int mcount=0;
         while(crs.next()) {
	     mname[mcount] = crs.getString("name");
	     mcount++;

	 }
         session.setAttribute("theMethodCount", mcount);

         paramList.clear();
         paramList.add(task_id);
         crs = execQuery(42, paramList);
         // rs = stmt.executeQuery("SELECT * from `set` WHERE task_id=" + task_id );
	 String img_path;

         int i;
         while(crs.next()) {
         String sname = crs.getString("id");
	 img_path = "uploads/" + uname + "/" + tname + "/" + sname + "/" + "original" + ".jpg";

	 %>
      <br>
      <br>
    <div class="img_thumb">
      <table align="center" width="500">
      <tr>
	<td class="buttons" align="center"><br>
	  <img src= <%= img_path.replaceAll(" ", "%20")%> alt= <%= "Original Image" %> height= 150px /> <br/>
	  <a class="regular"> <% out.print("Original Image"); %> </a>
       </td>
	<%
	 for(i=0; i<mcount; i++) {
	     img_path = "uploads/" + uname + "/" + tname + "/" + sname + "/" + mname[i] + ".jpg";
//	 if(counter%3 == 0) { out.println("</tr><tr>"); counter = 0;}
      %> 
       <td class="buttons" width="500" align="center"><br>
	<img src= <%= img_path.replaceAll(" ", "%20") %> alt= <%= mname[i]%> height= 150px /> <br/>
	 <a class="regular"> <% out.print(mname[i]); %> </a>
      </td>
      <%
							   //	 counter++;
	 }
	 %>
	     </tr><tr>
      </tr>
      </table>
    </div>

<%
	 }
      con.close();
      %>
    <br / > <br/>	<br / > <br/>


<div>
  <table align="center" border="0"> 
    <tr>
      <td id="light"><a class="super button pink" href="play.jsp?type=0">Knockout</a></td>
      <!-- <td id="light"><a class="super button pink">Knockout</a></td> -->
      <td id="light"><a class="super button green"  href="play.jsp?type=1">Challenging</a></td>
      <td id="light"><a class="super button blue"  href="play.jsp?type=2">Round-robin</a></td>
      
<!-- <div id="light" align="center"> -->
<!--        <ul style="list-style: none;"> -->
<!--         <li><a class="super button pink">Pink Button</a> -->
<!--         <a class="large button green">Green Button</a></li> -->
<!--        <li> <a class="large button blue">Blue Button</a> -->
<!--         <a class="large button red">Red Button</a></li> -->
<!--         <li><a class="large button orange">Orange Button</a> -->
<!--         <a class="large button yellow">Yellow Button</a></li> -->
<!--         </ul> -->
<!--  </div> -->
        
<!--  <div id="dark"> -->
<!--         <ul> -->
<!--         <li><a class="super button pink">Pink Button</a> -->
<!--         <a class="large button green">Green Button</a></li> -->
<!--        <li> <a class="medium button blue">Blue Button</a> -->
<!--         <a class="large button red">Red Button</a></li> -->
<!--        <li> <a class="small button orange">Orange Button</a> -->
<!--         <a class="medium button yellow">Yellow Button</a></li> -->
<!--         </ul> -->
<!-- </div> -->

</td> </tr>
</table>
</div>
</body>
</html>

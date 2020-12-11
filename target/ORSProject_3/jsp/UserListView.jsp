<%@page import="in.co.sunrays.proj3.util.HTMLUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="in.co.sunrays.proj3.controller.UserListCtl"%>
<%@page import="in.co.sunrays.proj3.util.ServletUtility"%>
<%@page import="in.co.sunrays.project3.dto.UserDTO"%>
<%@page import="in.co.sunrays.proj3.model.ModelFactory"%>
<%@page import="in.co.sunrays.proj3.model.RoleModelInt"%>
<%@page import="in.co.sunrays.proj3.model.UserModelInt"%>
<%@page import="in.co.sunrays.proj3.util.DataUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

	<jsp:useBean id="dto" class="in.co.sunrays.project3.dto.UserDTO" scope="request"></jsp:useBean>
	<jsp:useBean id="model" class="in.co.sunrays.proj3.model.UserModelHibImp" scope="request"></jsp:useBean>
	

<html>
<head>
<title>User List</title>
<!--    favicon-->
    <link rel="shortcut icon" href="/ORSProject3/theam_wel/image/fav-icon.png" type="image/x-i">

<style type="text/css">
body {
	background-image: url("/ORSProject_3/img/a.jpg");
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-position: center;
}
	.table-hover tbody tr:hover td
    {
        background-color: #0064ff36;
    } 
       
</style>



</head>

<body>

    <%@include file="Header.jsp"%>
	
	<form action="<%=ORSView.USER_LIST_CTL%>" method="post">
    
    <br>
        <div class="container">
        <div class="row">
      	<div class="panel" style="background-color:8FBC8F; margin-bottom: 150px;" >
        <div class="panel-body">
        <div align="center">
         
         <H2>  <span class="glyphicon glyphicon-list"></span><b> User List</b> </H2>
         <hr style="height:2px; color:#000000;">
       </div>
       
        <div class="text-center" >
            
              
               <%if(!ServletUtility.getSuccessMessage(request).equals("")){ %>
			<div class="alert alert-success alert-dismissible ">
                          <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                          <strong> <%=ServletUtility.getSuccessMessage(request)%></strong>
                          </div>
	      <%} if(!ServletUtility.getErrorMessage(request).equals("")){%>
			<div class="alert alert-danger alert-dismissible ">
                          <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                          <strong> <%=ServletUtility.getErrorMessage(request)%></strong>
                          </div>
				<%} %>
                 </div>
	
	<br><br><br>
	<%List listSize=ServletUtility.getList(request); %>
	    <div class="container-fluid text-center">
           <div class="form-inline" >
           <%if(listSize.size()>0 && listSize!=null) {%>
				<label class="control-label"  for="firstName">First Name :</label>
				<div class="form-group  text-center">
					
					 
					<input type="text"  class="form-control" name="firstName" size=15
					placeholder="Enter First Name" value="<%=ServletUtility.getParameter("firstName", request)%>">
				
				</div>&emsp;&emsp;
				
				<div class="form-group  text-center">
					<label class="control-label"  for="lastName">LoginID :</label>
					<input type="text"  class="form-control" name="loginId" size=15
					placeholder="Enter LoginId" value="<%=ServletUtility.getParameter("loginId", request)%>">
				</div>&emsp;&emsp;
				
				<% List roleList=(List)request.getAttribute("rolList");%>
				<div class="form-group text-center">
					<label class="control-label" for="email">Role :</label>
					<%=HTMLUtility.getList("roleId", String.valueOf(request.getParameter("roleId")), roleList)%>
					<!-- <input type="text" name=login class="form-control" 
					placeholder="Enter Login Id" size=15 value=""> -->
				</div>
			<!-- ServletUtility.getParameter("loginId", request) -->
			&emsp;&emsp;
			
				<div class="form-group">
				<button type="submit" name="operation" class=" form-control btn btn-primary" 
				 value="<%=UserListCtl.OP_SEARCH%>">
                <span class="glyphicon glyphicon-search"></span> Search </button>
       
			     <button type="submit" name="operation" class=" form-control btn btn-warning" 
			     value="<%=UserListCtl.OP_RESET%>" >
                 <span class="	glyphicon glyphicon-refresh"></span> Reset </button>
        
        </div>
        </div><hr>
        
        <% if (userdto.getRoleId() == RoleDTO.ADMIN || userdto.getRoleId() == RoleDTO.FACULTY) { %>
        			<div style="float:right">
				 <div class="col-sm-3" style="margin-left: 4%;">
      <button type="submit" name="operation" value="<%=UserListCtl.OP_DELETE%>"
	  class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> 
	  <%=UserListCtl.OP_DELETE%> </button></div>
			</div>
			<div style="float:left">
				<div class="col-sm-3" >
    <button type="submit" name="operation" value="<%=UserListCtl.OP_NEW%>"
	class="btn btn-primary"> <span class="glyphicon glyphicon-plus"></span> 
	<%=UserListCtl.OP_NEW%> </button></div>
			</div>
			
        </div>			
	<%}%>		
				<br>
				
				            		
				
			
			
			
			<div class="box-body table-responsive">
					
            <table  class="table  table-bordered table-striped table-hover">
              <thead>
                   <tr>
					 <th align="left">
					 <input type="checkbox" id="mainbox"
						onchange="selectAll(this)"> Select All</th>
                     <th style="text-align: center;">S.No.</th>
                     <th style="text-align: center;">First Name</th>
                     <th style="text-align: center;">Last Name</th>
                   	 <th style="text-align: center;">Login Id</th>
					 <th style="text-align: center;">Gender</th>
					 <th style="text-align: center;">DOB</th>
					 <th style="text-align: center;">Mobile No.</th>
					  <th style="text-align: center;">Role</th> 
                     <th style="text-align: center;">Edit</th>
                              
                   </tr>
                   </thead>
			        
                

                <%
                UserModelInt s = ModelFactory.getInstance().getUserModel();
				List l = s.list();
				int count = l.size();
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize);

                List     list = ServletUtility.getList(request);
                    Iterator<UserDTO> it = list.iterator();
                    while (it.hasNext()) {
                        dto = it.next();
                       
                 %>
                
                <tbody>
                <tr>
					<td align="left">
					
					 <input type="checkbox" name="ids" onchange="selectone(this)"
					 value="<%=dto.getId()%>">
					 
					 </td>
					
					<td align="center"><%=++index%></td>
					<td align="center"><%=dto.getFirstName()%></td>
					<td align="center"><%=dto.getLastName()%></td>
					<td align="center"><%=dto.getLoginId()%></td>
					<td align="center"><%=dto.getGender()%></td>
					<td align="center"><%=DataUtility.getDateString(dto.getDob())%></td>
					<td align="center"><%=dto.getMobileNo()%></td>
					 <td align="center"><%=dto.getRoleName()%></td> 
					
					<td style="size: 20%; text-align: center;"><%
						if (userdto.getId() == 2||userdto.getId() == 4) {
					%>
					---
					<%
						} if(userdto.getId()==RoleDTO.ADMIN) {
							if(dto.getRoleId()!=RoleDTO.ADMIN){
					%><a href="UserCtl?id=<%=dto.getId()%>" >
					<span class="glyphicon glyphicon-edit"></span></a>
					<%
						}else{
					%><a >
					<span class="glyphicon glyphicon-ban-circle"></span></a>
					<%}} %>
					</td>
					
	
										
					
					
			<input type="hidden" name="pageNo" value="<%=pageNo%>"> 
			<input type="hidden" name="pageSize" value="<%=pageSize%>">
				
				</tr>
				</tbody>
				<%
                    }
                %>
            	
			
			</table>
			</div>
		
		<div>
			
		<div style="float:right">
				
        <div class="col-sm-4"">
        <button type="submit" name="operation" value="<%=UserListCtl.OP_NEXT%>"<%=(index == count || dto.getId()==0 || list.size() < pageSize) ? "disabled" : ""%>  class="btn btn-primary" 
        ><%=UserListCtl.OP_NEXT%> <span class="glyphicon glyphicon-chevron-right"></span> 
        </button></div>

			</div>
			
			<div style="float:left">
				 
  <div class="col-sm-4"">
  <button type="submit" name="operation"
	value="<%=UserListCtl.OP_PREVIOUS%>"<%=(pageNo == 1) ? "disabled" : ""%>   class="btn btn-primary">
	<span class="glyphicon glyphicon-chevron-left"></span> <%=UserListCtl.OP_PREVIOUS%> </button> 
	 </div>

			</div>
		</div><hr>	
			
			<%}else{ %>
			 <table align="center">
				<tr>
					<td>
					 
					  <button type="submit" name="operation" class=" form-control btn btn-warning" 
			     value="<%=UserListCtl.OP_BACK%>" style=" width: 150px; height: 47px; font-size: 16px; background-color: gray;">
                 <span style="margin-right: 7px;" class="	glyphicon glyphicon-folder-open"></span>  Back </button>
                 
					</td>
			
				</tr>
			</table>
			 
			 <%} %>    
                
             </form>
    
    <br>
    <%@include file="Footer.jsp"%>
</body>
</html>

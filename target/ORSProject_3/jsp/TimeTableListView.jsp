<%@page import="in.co.sunrays.proj3.controller.TimeTableCtl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="in.co.sunrays.proj3.controller.TimeTableListCtl"%>
<%@page import="in.co.sunrays.proj3.util.ServletUtility"%>
<%@page import="in.co.sunrays.project3.dto.TimetableDTO"%>
<%@page import="in.co.sunrays.proj3.model.ModelFactory"%>
<%@page import="in.co.sunrays.proj3.model.TimeTableModelInt"%>
<%@page import="in.co.sunrays.proj3.util.HTMLUtility"%>
<%@page import="in.co.sunrays.proj3.util.DataUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>

<jsp:useBean id="dto" class="in.co.sunrays.project3.dto.TimetableDTO"
	scope="request"></jsp:useBean>
<jsp:useBean id="model"
	class="in.co.sunrays.proj3.model.TimeTableHibImp" scope="request"></jsp:useBean>


<head>
<title>Time Table List</title>
<!--    favicon-->
<link rel="shortcut icon"
	href="/ORSProject3/theam_wel/image/fav-icon.png" type="image/x-i">

<style type="text/css">
body {
	background-image: url("/ORSProject_3/img/a.jpg");
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-position: center;
}

.table-hover tbody tr:hover td {
	background-color: #0064ff36;
}
</style>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
 
 function noSunday(date){ 
    return [date.getDay() != 0, false];
 };

	  $(function() {
		
		$("#datepickerExam").datepicker({
			dateFormat : 'mm/dd/yy',
            changeMonth : true,
			changeYear : true,
			beforeShowDay: noSunday,
			yearRange:"0:+1"
		 
		});
	}); 
</script>

</head>

<body>

	<%@include file="Header.jsp"%>

	<form action="<%=ORSView.TIME_TABLE_LIST_CTL%>" method="post">

		<br>
		<div class="container">
			<div class="row">
				<div class="panel"
					style="background-color: 8FBC8F; margin-bottom: 150px;">
					<div class="panel-body">
						<div align="center">

							<H2>
								<span class="glyphicon glyphicon-list"></span><b> TimeTable
									List</b>
							</H2>
							<hr style="height: 2px; color: #000000;">
						</div>

						<div class="text-center">


							<%if(!ServletUtility.getSuccessMessage(request).equals("")){ %>
							<div class="alert alert-success alert-dismissible ">
								<a href="#" class="close" data-dismiss="alert"
									aria-label="close">&times;</a> <strong> <%=ServletUtility.getSuccessMessage(request)%></strong>
							</div>
							<%} if(!ServletUtility.getErrorMessage(request).equals("")){%>
							<div class="alert alert-danger alert-dismissible ">
								<a href="#" class="close" data-dismiss="alert"
									aria-label="close">&times;</a> <strong> <%=ServletUtility.getErrorMessage(request)%></strong>
							</div>
							<%} %>
						</div>

						<%List courseList=(List)request.getAttribute("cLIst");  %>

						<br>
						<br>
						<br>
						<%List listSize=ServletUtility.getList(request); %>
						<div class="container-fluid text-center">
							<div class="form-inline">
								<%if(listSize.size()>0 && listSize!=null) {%>
								<div class="form-group  text-center ">
									<div class="center">
										<label class="control-label">Course Name :</label>
										<%=HTMLUtility.getList("courseId", String.valueOf(dto.getCourseId()), courseList)%>
									</div>
								</div>
								&emsp;

								<div class="form-group  text-center ">
									<%
												HashMap map = new HashMap();
												map.put("I", "I");
												map.put("II", "II");
												map.put("III", "III");
												map.put("IV", "IV");
												map.put("V", "V");
												map.put("VI", "VI");
												map.put("VII", "VII");
												map.put("VIII", "VIII");
												
											%>
									<div class="center">
										<label class="control-label">Semester :</label>
										<%=HTMLUtility.getList("semester", String.valueOf(dto.getSemester()), map)%>
									</div>
								</div>
								&emsp;

								<div class="form-group  text-center">
									<label class="control-label" for="lastName">Exam Date:</label>
									<input type="text" style="text-align: center;"
										id="datepickerExam" class="form-control" name="examDate"
										size=15 placeholder="Click Here" readonly="readonly">
								</div>

								&emsp;&emsp;


								<div class="form-group">
									<button type="submit" name="operation"
										class=" form-control btn btn-primary"
										value="<%=TimeTableListCtl.OP_SEARCH%>">
										<span class="glyphicon glyphicon-search"></span> Search
									</button>

									<button type="submit" name="operation"
										class=" form-control btn btn-warning"
										value="<%=TimeTableListCtl.OP_RESET%>">
										<span class="	glyphicon glyphicon-refresh"></span> Reset
									</button>

								</div>
							</div>
							<hr>

							<% if (userdto.getRoleId() == RoleDTO.ADMIN || userdto.getRoleId() == RoleDTO.FACULTY) { %>
							<div style="float: right">
								<div class="col-sm-3" style="margin-left: 4%;">
									<button type="submit" name="operation"
										value="<%=TimeTableListCtl.OP_DELETE%>" class="btn btn-danger">
										<span class="glyphicon glyphicon-trash"></span>
										<%=TimeTableListCtl.OP_DELETE%>
									</button>
								</div>
							</div>
							<div style="float: left">
								<div class="col-sm-3">
									<button type="submit" name="operation"
										value="<%=TimeTableListCtl.OP_NEW%>" class="btn btn-primary">
										<span class="glyphicon glyphicon-plus"></span>
										<%=TimeTableListCtl.OP_NEW%>
									</button>
								</div>
							</div>

						</div>
						<%}%>
						<br>






						<div class="box-body table-responsive">

							<table class="table  table-bordered table-striped table-hover">
								<thead>
									<tr>
										<th align="left"><input type="checkbox" id="mainbox"
											onchange="selectAll(this)"> Select All</th>
										<th style="text-align: center;">S.No.</th>
										<th style="text-align: center;">Course Name</th>
										<th style="text-align: center;">Semester</th>
										<th style="text-align: center;">Subject Name</th>
										<th style="text-align: center;">Exam Date</th>
										<th style="text-align: center;">Exam Time</th>
										<th style="text-align: center;">Edit</th>

									</tr>
								</thead>



								<%
                TimeTableModelInt s = ModelFactory.getInstance().getTimeTableModel();
				     List l = s.list();
				     int count = l.size();
				
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    System.out.println("pageNo....."+pageNo+"pageSize......"+pageSize);
                    int index = ((pageNo - 1) * pageSize)+1;

                List     list = ServletUtility.getList(request);
                    Iterator<TimetableDTO> it = list.iterator();
                    while (it.hasNext()) {
                        dto = it.next();
                       
                 %>

								<tbody>
									<tr>
										<td align="left">
											
											<input type="checkbox" name="ids" onchange="selectone(this)"
											value="<%=dto.getId()%>">
										</td>

										<td align="center"><%=index++%></td>
										<td align="center"><%=dto.getCourseName()%></td>
										<td align="center"><%=dto.getSemester()%></td>
										<td align="center"><%=dto.getSubjectName()%></td>
										<td align="center"><%=dto.getExamDate()%></td>
										<td align="center"><%=dto.getExamTime()%></td>

										<td style="size: 20%; text-align: center;">
											<%
						if (userdto.getRoleId() == 2||userdto.getRoleId() == 4||userdto.getRoleId()==1) {
					%> <a href="TimeTableCtl?id=<%=dto.getId()%>"> <span
												class="glyphicon glyphicon-edit"></span></a> <%
						}else{
					%><a> <span class="glyphicon glyphicon-ban-circle"></span></a> <%} %>
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

							<div style="float: right">

								<div class="col-sm-4"">
									<button type="submit" name="operation"
										value="<%=TimeTableListCtl.OP_NEXT%>"
										<%=(index == count || dto.getId()==0 || list.size() < pageSize) ? "disabled" : ""%>
										class="btn btn-primary"><%=TimeTableListCtl.OP_NEXT%>
										<span class="glyphicon glyphicon-chevron-right"></span>
									</button>
								</div>

							</div>

							<div style="float: left">

								<div class="col-sm-4"">
									<button type="submit" name="operation"
										value="<%=TimeTableListCtl.OP_PREVIOUS%>"
										<%=(pageNo == 1) ? "disabled" : ""%> class="btn btn-primary">
										<span class="glyphicon glyphicon-chevron-left"></span>
										<%=TimeTableListCtl.OP_PREVIOUS%>
									</button>
								</div>

							</div>
						</div>
						<hr>

						<%}else{ %>
						<table align="center">
							<tr>
								<td>

									<button type="submit" name="operation"
										class=" form-control btn btn-warning"
										value="<%=TimeTableListCtl.OP_BACK%>"
										style="width: 150px; height: 47px; font-size: 16px; background-color: gray;">
										<span style="margin-right: 7px;"
											class="	glyphicon glyphicon-folder-open"></span> Back
									</button>

								</td>

							</tr>
						</table>

						<%} %>
					
	</form>

	<br>
	<%@include file="Footer.jsp"%>

</body>

</html>
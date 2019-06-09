<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="connection" scope="page" class="tools.ConnDB"></jsp:useBean>
<link rel="stylesheet" href="../css/aside_public.css">
<link rel="stylesheet" href="../css/manager/aside.css">
<link rel="stylesheet" href="../css/template/level.css">
<aside>
	<ul>
		 <li id="info_M">账号管理</li>
		 <li id="teacher_M">教师管理</li>
		 <li id="student_M">学生管理
		  <img src="../images/select_bottom.png" alt="select-bottom">
			 <div class="grades">
			   <%for(int i=0;i<4;i++){%>
			     <div class="<%=i+1%>">
   				     	<span>大<%=i+1%></span>
			     		<img src="../images/select.png" alt="select-left">
			        <div class="classes">
			       <%
			         ResultSet rs = connection.executeQuery("select * from number where grade_all = '" + (i+1) + "'");
			         int classes = 0;
			         while(rs.next()){
			        	 classes = rs.getInt("class_all");
			        	 for(int j=0;j<classes;j++){
			       %>
			        	   <div class="<%=j+1%>"><%=j+1%>班</div>
			       <%}}%>
			      </div>
			     </div>
			   <%}%>
			 </div>
		 </li>
	</ul>
</aside> 
<script type="text/javascript">
	document.querySelector('#info_M').addEventListener('click',function(){
	 	window.location.href = "./management_info.jsp"
	})
	document.querySelector('#teacher_M').addEventListener('click',function(e){
	 	window.location.href = "./management_teacher.jsp?user=teacher"
	})
	calculateAndReturn()
	function calculateAndReturn(){
		  var grade;
		  var classes;
		  //计算班级和年级
		  document.querySelectorAll('.classes > div').forEach(function(element){
			  element.addEventListener('click',function(e){
				  grade = e.target.parentNode.parentNode.className
				  classes = e.currentTarget.className
				  window.location.href = './management_student.jsp?grade=' + grade + '&class=' + classes +'&user=student'
			  })
		  })
	}

// 		  //计算年级
// 		  document.querySelectorAll('.grades > div').forEach(function(element){
// 			  element.addEventListener('click',function(e){
// 				  grade = e.currentTarget.className
// 			  })
// 		  })
// 		  document.querySelector('#student_M').addEventListener('click',function(e){
// 			  if(typeof(grade) === 'undefined' && typeof(classes) === 'undefined'){
// 				  window.location.href = './management_student.jsp?grade=1&class=1&user=student'
// 			  }
// 			  if(!(typeof(grade)==='undefined') && typeof(classes)==='undefined'){
// 				  window.location.href = './management_student.jsp?grade=' + grade + '&class=1&user=student'
// 			  }
// 			  if(!(typeof(grade)==='undefined') && !(typeof(classes)==='undefined')){
// 				  window.location.href = './management_student.jsp?grade=' + grade + '&class=' + classes +'&user=student'
// 			  }
// 		  })
</script>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
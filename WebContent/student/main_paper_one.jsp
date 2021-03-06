<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="ChStr" scope="page" class="tools.chStr" />
<jsp:useBean id="connP" scope="page" class="tools.ConnDB" />
<link rel="stylesheet" href="../css/paper.css">
<link rel="stylesheet" href="../css/student/main_paper_one.css">
<%
	String loginUser = (String)session.getAttribute("username");
	ResultSet rs_n = connP.executeQuery("select [user] from complete_user where [user]='" + loginUser + "'");
	//看用户是否还能参加考试
	if(!rs_n.next()){
		connP.executeUpdate("insert into complete_user ([user]) values('"+ loginUser + "')");
    %> 
		<div class="main">
		<form method="post" id="commitPaperForm" class="container">
			<div class="selectionContainer">
				<h3>一、选择题(该题型每题2分，一共10题)。</h3>
				<%		
				int [] selections = new int[10];
				String selectionSql = "select top 10 * from selection order by NEWID()"	;
				ResultSet rs_s = connP.executeQuery(selectionSql);
				int sum = 0;
				while(rs_s.next()){
					sum ++;%>
					<ul class="selectionRow row_<%=sum%>">
						<li><b><%=sum%></b>、<%=rs_s.getString("title")%></li>
						<li>
							<div>
								<input type="radio" name="sradio<%=sum%>" value="A"><span>A、<%=rs_s.getString(3)%></span>
							</div>
							<div>
								<input type="radio" name="sradio<%=sum%>" value="B"><span>B、<%=rs_s.getString(4)%></span>
							</div>
							<div>
								<input type="radio" name="sradio<%=sum%>" value="C"><span>C、<%=rs_s.getString(5)%></span>
							</div>
							<div>
								<input type="radio" name="sradio<%=sum%>" value="D"><span>D、<%=rs_s.getString(6)%></span>
							</div>
						</li>
					</ul>
				<%	
				 selections[sum-1] = rs_s.getInt("ID");
				}
				ResultSet rs_x = connP.executeQuery("select [user] from question_selection where [user] = '" + loginUser + "'");
				if(!rs_x.next()){
					String sql = "insert into question_selection"
							+ "([user],s1_ID,s2_ID,s3_ID,s4_ID,s5_ID,s6_ID,s7_ID,s8_ID,s9_ID,s10_ID) values"
							+ "('" + loginUser
							+ "'," + selections[0]
							+ "," + selections[1]
							+ "," + selections[2]
							+ "," + selections[3]
							+ "," + selections[4]
							+ "," + selections[5]
							+ "," + selections[6]
							+ "," + selections[7]
							+ "," + selections[8]
							+ "," + selections[9]
							+")";
					connP.executeUpdate(sql);
				}else{
					String sql = "update question_selection set s1_ID = "
								+ selections[0] + ",s2_ID = "
								+ selections[1] + ",s3_ID = "
								+ selections[2] + ",s4_ID = "
								+ selections[3] + ",s5_ID = "
								+ selections[4] + ",s6_ID = "
								+ selections[5] + ",s7_ID = "
								+ selections[6] + ",s8_ID = "
								+ selections[7] + ",s9_ID = "
								+ selections[8] + ",s10_ID = "
								+ selections[9]
								+ "where [user] = '" + loginUser + "'";
					connP.executeUpdate(sql);
				}%>
			</div>
			<div class="judgementContainer">
				<h3>二、判断题(该题型每题2分，一共10题)。</h3>
				<%String judgementSql = "select top 10 * from judgement order by NEWID()";
				ResultSet rs_j = connP.executeQuery(judgementSql);
				int [] judgements = new int[10];
				int sum2 = 0;
				while(rs_j.next()){
					judgements[sum2] = rs_j.getInt("ID");
					sum2 ++;%>
				<ul class="judgementRow">
					<li><b><%=sum2%></b>、<%=rs_j.getString("title")%></li>
					<li><input type="radio" name="jradio<%=sum2%>" value="true"><span>true</span>
						<input class="option2" type="radio" name="jradio<%=sum2%>" value="false"><span>false</span>
					</li>
				</ul>
				<%}
				ResultSet rs_y = connP.executeQuery("select [user] from question_judgement where [user] = '" + loginUser + "'");
				if(!rs_y.next()){
					String sql2 = "insert into question_judgement"
							+ "([user],j1_ID,j2_ID,j3_ID,j4_ID,j5_ID,j6_ID,j7_ID,j8_ID,j9_ID,j10_ID) values"
							+ "('" + loginUser
							+ "'," + judgements[0]
							+ "," + judgements[1]
							+ "," + judgements[2]
							+ "," + judgements[3]
							+ "," + judgements[4]
							+ "," + judgements[5]
							+ "," + judgements[6]
							+ "," + judgements[7]
							+ "," + judgements[8]
							+ "," + judgements[9]
							+")";
					int result2 = connP.executeUpdate(sql2);
				}else{
					String sql2 = "update question_judgement set"
								+ " j1_ID=" + judgements[0]
								+ ",j2_ID=" + judgements[1]
								+ ",j3_ID=" + judgements[2]
								+ ",j4_ID=" + judgements[3]
								+ ",j5_ID=" + judgements[4]
								+ ",j6_ID=" + judgements[5]
								+ ",j7_ID=" + judgements[6]
								+ ",j8_ID=" + judgements[7]
								+ ",j9_ID=" + judgements[8]
								+ ",j10_ID=" + judgements[9]
								+ "where [user] = '" + loginUser + "'";
					connP.executeUpdate(sql2);
				}

			%>
			</div>
			<div class="shortContainer">
				<h3>三、简答题(前五题每题5分，最后三题分别为10分、10分、15分,一共8题)。</h3>
				<div class="shortFive">
					<%String shortFiveSql = "select top 5 * from short_5 order by NEWID()";
					ResultSet rs_5 = connP.executeQuery(shortFiveSql);
					int [] shorts = new int[5];
					int sum3 = 0;
					while(rs_5.next()){
						shorts[sum3] = rs_5.getInt("ID");
						sum3 ++;%>
					<ul class="shortFiveRow row_<%=sum3%>">
						<li><b><%=sum3%></b>、<%=rs_5.getString("title")%><span>(5分)</span></li>
						<li><textarea rows="5" cols="100" placeholder="请输入答案"
								name="textarea<%=sum3%>"></textarea></li>
					</ul>
					<%}
					ResultSet rs_z = connP.executeQuery("select [user] from question_short_5 where [user] ='" + loginUser +"'");
					if(!rs_z.next()){
						String sql3 = "insert into question_short_5"
								+ "([user],c1_ID,c2_ID,c3_ID,c4_ID,c5_ID) values"
								+ "('" + loginUser
								+ "'," + shorts[0]
								+ "," + shorts[1]
								+ "," + shorts[2]
								+ "," + shorts[3]
								+ "," + shorts[4]
								+")";
						int result3 = connP.executeUpdate(sql3);
					}else{
						String sql3 = "update question_short_5 set"
								+ " c1_ID=" + shorts[0]
								+ ",c2_ID=" + shorts[1]
								+ ",c3_ID=" + shorts[2]
								+ ",c4_ID=" + shorts[3]
								+ ",c5_ID=" + shorts[4]
								+ "where [user] = '" + loginUser + "'";
						connP.executeUpdate(sql3);
					}

					%>
				</div>
				<div class="shortTen">
					<%String shortTenSql = "select top 2 *  from short_10 order by NEWID()";
					ResultSet rs_10 = connP.executeQuery(shortTenSql);
					int [] shortTen = new int[2];
					int sum4 = 0;
					while(rs_10.next()){
						shortTen[sum4] = rs_10.getInt("ID");
						sum4 ++;%>
						<ul class="shortTenRow row_<%=sum3+sum4%>">
							<li><b><%=sum3 + sum4%></b>、<%=rs_10.getString("title")%><span>(10分)</span></li>
							<li><textarea rows="5" cols="100" placeholder="请输入答案"
									name="textarea<%=sum3+sum4%>"></textarea></li>
						</ul>
					<%}
					ResultSet rs_z2 = connP.executeQuery("select [user] from question_short_10 where [user] = '" + loginUser + "'");
					if(!rs_z2.next()){
						String sql4 = "insert into question_short_10"
								+ "([user],c1_ID,c2_ID) values"
								+ "('" + loginUser
								+ "'," + shortTen[0]
								+ "," + shortTen[1]
								+")";
						int result4 = connP.executeUpdate(sql4);
					}else{
						String sql4 = "update question_short_10 set"
								+ "c1_ID=" + shortTen[0]
								+ ",c2_ID=" + shortTen[1]
								+ "where [user]='" + loginUser + "'";
						connP.executeUpdate(sql4);
					}

				%>
				</div>
				<div class="shortFifteen">
				<%
					ResultSet rs_15 = connP.executeQuery("select top 1 * from short_15 order by NEWID()");
					int shortFifteen = 0;
					int sum5 = 0;
					while(rs_15.next()){
						shortFifteen = rs_15.getInt("ID");
						sum5 ++;%>
					<ul class="shortFifteenRow row_<%=sum3+sum4+sum5%>">
						<li><b><%=sum3 + sum4 + sum5%></b>、<%=rs_15.getString("title")%><span>(15分)</span></li>
						<li><textarea rows="5" cols="100" placeholder="请输入答案"
								name="textarea<%=sum3+sum4+sum5%>"></textarea></li>
					</ul>
					<%}
					ResultSet rs_z3 = connP.executeQuery("select [user] from question_short_15 where [user] = '" + loginUser + "'");
					if(!rs_z3.next()){
						String sql5 = "insert into question_short_15"
								+ "([user],c1_ID) values"
								+ "('" + loginUser
								+ "'," + shortFifteen
								+")";
						int result5 = connP.executeUpdate(sql5);
					}else{
						String sql5 = "update question_short_15 set"
								+ "c1_ID=" + shortFifteen
								+"where [user]='" + loginUser + "'";
						connP.executeUpdate(sql5);
					}
					%>
				</div>
			</div>
			<div class="commitPaperContainer">
				<input type="button" id="commit_paper" onclick="return submitPaper()" value="提交试卷">
			</div>
		</form>
	</div>
	<script>
		//提交试卷按钮， 离开此页面提醒以及提交试卷提醒
		function submitPaper(){
		    window.onbeforeunload = null 
		    if(confirm("请认真检查试卷，确定后即可提交")){
				document.querySelector('#commitPaperForm').setAttribute('action','./exam_result.jsp')
				document.querySelector('#commitPaperForm').submit()
		    }else{
		    	return false
		    }
		}
		window.onbeforeunload = function(e) {	
		  	(e || window.event).returnValue = "确认离开吗？你只有一次答题机会...";     // Gecko and Trident
		  	return "确认离开吗？你只有一次答题机会...";                                // Gecko and WebKit
		};
		//禁止F5刷新
		window.onkeydown = function(e){  
		 if (e.keyCode==116){     		
		    e.keyCode = 0;  		
		    e.cancelBubble = true;  		
		    return false;  		
		  }  		
		} 
	</script>
	<%}else{
  		out.println("<script language='javascript'>alert('您已参加过考试，请耐心等待结果... ');window.location.href='./exam.jsp'</script>");
 	}%>

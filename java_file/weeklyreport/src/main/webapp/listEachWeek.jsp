<%@page import="java.time.temporal.WeekFields"%>
<%@ page import="java.util.*"%>
<%@page contentType="text/html;charset=UTF-8" %>
<!-- #include file="constant.jsp" -->>
<% 
Integer weekDiff=request.setAttribute("weekDiff");
if(weekDiff==0){
	title="MIR实验室本周登陆之工作进度";
}
else{
	title="MIR实验室前"+(weekDiff)+"周登陆之工作进度";
}
%>
<!-- #Include file="head.jsp" -->
<!-- #Include file ="function.jsp" -->
<center>
	<a href="default.jsp" target=_blank>回到主菜单 </a>
</center>
<%
NewDate = DateAdd("ww", weekDiff, date);
xingQiJi=weekDiff(NewData);
startDate = DateAdd("d", 1-xingQiJi, NewDate)
endDate   = DateAdd("d", 7-xingQiJi, NewDate)
Response.Write(startDate)
Response.Write(endDate)
%>

<p>
<table border="1" align=center>
<tr>
<th align=center>姓名
<th align=center>本周完成事项
<th align=center>下周预定完成事项：<br>[<font color=red>预定完成日期</font>]工作描述
<th align=center>综合说明
<th align=center> 登录日期
<%
String students = request.getParameter("student");
session.setAttribute("student", student);
List Students=(list)application.getAttribute("Student");
	for(int j=0;j<Student.size();j++){
	person = students(row);
	Set Conn = Server.CreateObject("ADODB.Connection");
	Conn.Open "DBQ=" & Server.MapPath(progressDb) & ";Driver={Microsoft Access Driver (*.mdb)};Driverld=25;FIL=MS Access;";
	sql = "select * from work where name = '" & person & "' and entryDate Between #" & startDate & "# And #" & endDate & "# order by entryDate desc";
	Response.Write(sql);
	Response.End;
	set RS = Conn.Execute(sql);
	If (!RS.Eof)	//有此人之登录资料
		%>
		<tr>
		<td bgcolor=<%=color(j)%> align=center><a target=_blank href="listEachPerson.asp?person=<%=person%>"><%=person%></a> </td>
		<td bgcolor=<%=color(j)%> valign=top><% PrintField RS, "finished", 0 %> &nbsp;</td>
		<td bgcolor=<%=color(j)%> valign=top><% PrintDateTask RS, "thisDate", "thisTask" %> &nbsp; </td>
		<td bgcolor=<%=color(j)%> valign=top><%=RS("summary")%> &nbsp;</td>
		<td bgcolor=<%=color(j)%> valign=top><%=RS("entryDate")%><br><%=RS("entryTime")%> &nbsp;</td>	
	<% else %>
		<tr>
		<td bgcolor=<%=color(j)%> align=center><a target=_blank href="listEachPerson.asp?person=<%=person%>"><%=person%></a> </td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
		<td bgcolor=gray valign=top>&nbsp;</td>
	}
</table>
<% Conn.Close %>
</body>
</html>

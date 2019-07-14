<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.time.temporal.WeekFields"%>
<%@ page import="java.util.*"%>
public void sameweek(data1,data2)
{
	Interger data0,weekNum1,weekNum2;
	weekNum1=DataDiff("ww",data0,data1,vbSunday,vbFirstFullWeek);
	weekNum2=Datediff("ww",data0,data2,vbSundat,vbFirstFullWeek);
	if(weekNum1==weekNum2)
	{
	
	}
}
//登陆
public void login(HttpServletRequest request,HttpServletResponse response) throws Exception {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    User user = userDao.login(username, password);
    if (user != null) {
        user.setLastLogin(new Date());
        userDao.update(user);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // 加入在线列表
        session.setAttribute("onlineUserBindingListener", new OnlineUserBindingListener(username));

        response.sendRedirect(request.getContextPath() + "/security/loginSuccess.jsp");
    } else {
        request.setAttribute("error", "用户名或密码错误！");
        request.getRequestDispatcher("/security/login.jsp").forward(request, response);
    }

}

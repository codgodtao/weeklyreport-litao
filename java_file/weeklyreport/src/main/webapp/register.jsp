
<%@page contentType="text/html;charset=UTF-8"  %>
<!--#include file="constant.asp"-->
<!--#include file="head.asp"-->
<!--#include file="function.asp"-->
public void register(HttpServletRequest request,HttpServletResponse response) throws Exception {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    boolean userExists = userDao.checkExists(username);
    if (userExists) {
        request.setAttribute("error", "用户名：" + username + "已被使用了，请更换其他用户名注册。");
        request.getRequestDispatcher("/security/register.jsp").forward(request, response);
    } else {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        userDao.save(user);
        response.sendRedirect(request.getContextPath() + "/security/registerSuccess.jsp");
    }
}
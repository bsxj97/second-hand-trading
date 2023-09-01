<%@ page language="java" import="com.daowen.entity.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.daowen.service.*" %>
<%@ page import="com.daowen.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.daowen.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
      Huiyuan tem_huiyuan=null;
      
      if(request.getSession().getAttribute("huiyuan")!=null){
         tem_huiyuan=(Huiyuan)request.getSession().getAttribute("huiyuan");
      }
      else
      {
    	 String forwardurl=request.getRequestURI().replace(request.getContextPath(), "");
         response.sendRedirect(request.getContextPath()+"/e/login.jsp");
      }  
      
 %>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.svnadmin.Constants"%>
<%@page import="org.svnadmin.util.I18N"%>
<%@include file="header.jsp"%>
<span style="color:green;font-weight:bold;"><a href="pj"><%=I18N.getLbl(request,"pj.title","项目管理") %>(<%=request.getParameter("pj")%>)</a> --> <%=I18N.getLbl(request,"pjauth.title","权限管理") %></span><br><br>
<%
org.svnadmin.entity.PjAuth entity = (org.svnadmin.entity.PjAuth)request.getAttribute("entity");
if(entity==null)entity=new org.svnadmin.entity.PjAuth();
%>
<script>
function checkForm(f){
	if(f.elements["pj"].value==""){
		alert("<%=I18N.getLbl(request,"pjauth.error.pj","项目不可以为空") %>");
		f.elements["pj"].focus();
		return false;
	}
	if(f.elements["res"].value==""){
		alert("<%=I18N.getLbl(request,"pjauth.error.res","资源不可以为空") %>");
		f.elements["res"].focus();
		return false;
	}
	if(f.elements["grs"].value=="" && f.elements["usrs"].value==""){
		alert("<%=I18N.getLbl(request,"pjauth.error.grusr","请选择用户组或用户") %>");
		f.elements["grs"].focus();
		return false;
	}
	return true;
}
</script>
<form name="pjauth" action="<%=ctx%>/pjauth" method="post" onsubmit="return checkForm(this);">
	<input type="hidden" name="act" value="save">
	<table>
		<tr>
			<td><%=I18N.getLbl(request,"pj.pj","项目") %></td>
			<td><input type="hidden" name="pj" value="<%=request.getParameter("pj")%>"><%=request.getParameter("pj")%></td>
			<td><%=I18N.getLbl(request,"pjauth.res","资源") %></td>
			<td>
				<input type="text" name="res" value="<%=entity.getRes()==null?"":entity.getRes()%>" style="width:400px;"><span style="color:red;">*</span>
				<select onchange="this.form.res.value=this.value">
				<option value=""><%=I18N.getLbl(request,"pjauth.res.select","选择资源") %></option>
				 <%
				 java.util.List<String> pjreslist = (java.util.List<String>)request.getAttribute("pjreslist");
				 for(int i=0;i<pjreslist.size();i++){
				 %>
				 <option value="<%=pjreslist.get(i)%>"><%=pjreslist.get(i)%></option>
				 <%
				 }
				 %>	
				 </select>
			</td>
		</tr>
		<tr>
			<td><%=I18N.getLbl(request,"pj_gr.gr","用户组") %></td>
			<td>
				<select name="grs" multiple="multiple">
					<%
					java.util.List<org.svnadmin.entity.PjGr> pjgrlist = (java.util.List<org.svnadmin.entity.PjGr>)request.getAttribute("pjgrlist");
					if(pjgrlist!=null){	
					for(int i = 0;i<pjgrlist.size();i++){
						org.svnadmin.entity.PjGr pjGr = pjgrlist.get(i);
					%>
					<option value="<%=pjGr.getGr()%>"><%=pjGr.getGr()%></option>
					<%}}%>
				</select>
			<td><%=I18N.getLbl(request,"usr.usr","用户") %></td>
			<td>
				<select name="usrs" multiple="multiple">
					<%
					java.util.List<org.svnadmin.entity.Usr> usrlist = (java.util.List<org.svnadmin.entity.Usr>)request.getAttribute("usrList");
					if(usrlist!=null){	
					for(int i = 0;i<usrlist.size();i++){
						org.svnadmin.entity.Usr usr = usrlist.get(i);
					%>
					<option value="<%=usr.getUsr()%>"><%=usr.getUsr()%></option>
					<%}}%>
				</select>
			</td>
		</tr>
		<tr>
			<td><%=I18N.getLbl(request,"pjauth.rw","权限") %></td>
			<td colspan="3">
			<select name="rw">
					<option value="" <%="".equals(entity.getRw())?"selected='selected'":""%> ><%=I18N.getLbl(request,"pjauth.rw.none","没有权限") %></option>
					<option value="r"<%="r".equals(entity.getRw())?"selected='selected'":""%>><%=I18N.getLbl(request,"pjauth.rw.r","可读") %></option>
					<option value="rw"<%="rw".equals(entity.getRw())?"selected='selected'":""%>><%=I18N.getLbl(request,"pjauth.rw.rw","可读可写") %></option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" value="<%=I18N.getLbl(request,"pjauth.btn.submit","保存") %>">
			</td>
		</tr>
	</table>
</form>

<table class="sortable">

	<thead>
		<td><%=I18N.getLbl(request,"sys.lbl.no","NO.") %></td>
		<td><%=I18N.getLbl(request,"pj.pj","项目") %></td>
		<td><%=I18N.getLbl(request,"pjauth.res","资源") %></td>
		<td><%=I18N.getLbl(request,"pj_gr.gr","用户组") %>/<%=I18N.getLbl(request,"usr.usr","用户") %></td>
		<td><%=I18N.getLbl(request,"pjauth.rw","权限") %></td>
		<td><%=I18N.getLbl(request,"pjauth.op.delete","删除") %></td>
	</thead>
	<%
	java.util.List<org.svnadmin.entity.PjAuth> list = (java.util.List<org.svnadmin.entity.PjAuth>)request.getAttribute("list");

	if(list!=null){
	  for(int i = 0;i<list.size();i++){
		  org.svnadmin.entity.PjAuth pjAuth = list.get(i);
		%>
		<tr>
		<td><%=(i+1) %></td>
		<td><%=pjAuth.getPj() %></td>
		<td><%=pjAuth.getRes() %></td>
		<td><%=pjAuth.getGr()==null?"":pjAuth.getGr() %><%=pjAuth.getUsr()==null?"":pjAuth.getUsr() %></td>
		<td><%=pjAuth.getRw() %></td>
		<td>
		<a href="javascript:if(confirm('<%=I18N.getLbl(request,"pjauth.op.delete.confirm","确认删除?") %>')){del('<%=ctx%>/pjauth?pj=<%=pjAuth.getPj()%>&res=<%=pjAuth.getRes()%>&gr=<%=pjAuth.getGr()%>&usr=<%=pjAuth.getUsr()%>')}"><%=I18N.getLbl(request,"pjauth.op.delete","删除") %></a>
		</td>
	</tr>
		<%	
	}}
	%>
</table>
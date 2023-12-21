<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<link href="../css/index.css" rel="stylesheet" type="text/css" >
<body>

<%@ include file="jdbc.jsp" %>
<%@ include file="authAdmin.jsp"%>
<%@ include file="header.jsp" %>

<h1>Order List</h1>

<table border="1">
	<tr>
		<th>Order ID</th>
		<th>Order Date</th>
		<th>Customer ID</th>
		<th>Customer Name</th>
		<th>Total Amount</th>
	</tr>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
	String uid = "sa";
	String pw = "304#sa#pw";
			
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 
	{			
		
		ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, customer.customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId");
		String sql = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		while (rst.next())
		{	
			%>
			<tr>
				<td><%= rst.getString(1) %></td>
				<td><%= rst.getString(2) %></td>
				<td><%= rst.getString(3) %></td>
				<td><%= rst.getString(4) + " " + rst.getString(5) %></td>
				<td><%= currFormat.format(rst.getDouble(6)) %></td>
			</tr>
			<%
			pstmt.setString(1, rst.getString(1));
			ResultSet rst2 = pstmt.executeQuery();
			%>
			<tr>
				<td>
				<table border="1">
					<tr>
						<th>Product Id</th>
						<th>Quantity</th>
						<th>Price</th>
					</tr>
			<%
			while (rst2.next()) {
				%>
				<tr>
					<td><%= rst2.getString(1) %></td>
					<td><%= rst2.getString(2) %></td>
					<td><%= rst2.getString(3) %></td>
				</tr>
				<%
			}
			rst2.close();
			%>
			</td>
			</table>
			<%
		}
	}
	catch (SQLException ex)
	{
		out.println("SQLException: " + ex);
	}
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

%>
</table>

</body>
</html>


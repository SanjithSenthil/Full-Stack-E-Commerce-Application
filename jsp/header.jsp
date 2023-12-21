<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<nav>
    <ul>
        <li><a href="../index.jsp">Home</a></li>
        <li><a href="http://localhost/shop/jsp/listprod.jsp">Products</a></li>
        <li><a href="http://localhost/shop/jsp/showcart.jsp">Shopping Cart</a></li>
		<% if (userName != null) { %>
            <li><a href="http://localhost/shop/jsp/customer.jsp"><%= userName %></a></li>
        <% } else { %>
            <li><a href="http://localhost/shop/jsp/login.jsp">Login</a></li>
        <% } %>
    </ul>
</nav>

<style>
	nav {
		font-family: Arial, sans-serif;
		background-color: #333;
		overflow: hidden;
		margin: 0;
		padding: 0;
	}
	nav ul {
		list-style-type: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
	}
	nav li {
		float: left;
	}
	nav li a {
		display: block;
		color: white;
		text-align: center;
		padding: 18px 16px;
		text-decoration: none;
		font-weight: bold;
	}
	nav li a:hover {
		background-color: #ddd;
		color: black;
	}
	nav li:last-child {
		float: right;
	}
</style>
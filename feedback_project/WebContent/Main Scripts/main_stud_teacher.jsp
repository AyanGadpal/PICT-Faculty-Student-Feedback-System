<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="jclass.*"%>

<script>
	var a = 7
	var title_name = "Select Mapping Type"
</script>
<%@ include file = "navbar.jsp" %>


<section id="header-footer">
	<div class="row match-height">
		<div class="col-lg-4 col-md-12">
			<div class="card">
				<div class="card-body">
					<a href="ltl_map.jsp"><button class="btn"> LTL Mapping</button></a> 
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-md-12">
			<div class="card">
				<div class="card-body">
					<a href="be_map.jsp"><button class="btn"> BE Mapping</button></a>
				</div>
			</div>
		</div>
		<div class="col-lg-4 col-md-12">
			<div class="card">
				<div class="card-body">
					<a href="show_map.jsp"><button class="btn">Show LTL Mappings</button></a>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file = "downbar.jsp" %>

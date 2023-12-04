<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP PAGE</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body>
        <%
        String idDel = request.getParameter("CED_EST");
        
        if (idDel != null && !idDel.isEmpty()) {
            try {
                    String urlString = "http://localhost/Quinto/api.php?cedula=" + idDel;

                    HttpClient cliente = HttpClient.newHttpClient();
                    HttpRequest solicitud = HttpRequest.newBuilder()
                            .uri(URI.create(urlString))
                            .DELETE()
                            .build();

                    // Enviar la solicitud y obtener la respuesta
                    HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());
                    // Manejar la respuesta del servicio web
                    if (respuesta.statusCode() == 200) {
                        // Mostrar la respuesta del servicio web
                        out.print("<br>");
                        response.sendRedirect("person_list.jsp"); // Redireccionar a la lista de personas
                    } else {
                        out.print("<div class='alert alert-danger' role='alert'>ERROR AL ELIMINAR</div> " + respuesta.statusCode());
                    }
                } catch (Exception e) {
                    out.print("<div class='alert alert-danger' role='alert'>ERROR: " + e.getMessage() + "</div>");
               }
        } else {
                out.print("<div class='alert alert-warning' role='alert'>ID de eliminación no proporcionado</div>");
        }
        %>
    </body>
</html>

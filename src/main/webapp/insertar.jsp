<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%@page import="java.util.Scanner"%>
<%@page import="javax.management.RuntimeErrorException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
        <jsp:include page="head.jsp"/>
    <body>
        <div>
            <jsp:include page="navbar.jsp"/>
        </div>
        <h1>Nuevo Estudiante</h1><br>
        <form method="POST" autocomplete="off">
            <div class="mb-3">
              <label for="" class="form-label">Cédula</label>
              <input type="number" class="form-control" id="CED_EST" name="CED_EST" required>
            </div>
            <div class="mb-3">
              <label for="" class="form-label">Nombre</label>
              <input type="text" class="form-control" id="NOM_EST" name="NOM_EST" required>
            </div>
            <div class="mb-3">
              <label for="" class="form-label">Apellido</label>
              <input type="text" class="form-control" id="APE_EST" name="APE_EST" required>
            </div>
            <div class="mb-3">
              <label for="" class="form-label">Dirección</label>
              <input type="text" class="form-control" id="DIR_EST" name="DIR_EST" required>
            </div>
            <div class="mb-3">
              <label for="" class="form-label">Teléfono</label>
              <input type="number" class="form-control" id="TEL_EST" name="TEL_EST" required>
            </div>
            <button type="submit" class="btn btn-primary">Agregar Persona</button>
        </form>
        <%
            if (request.getMethod().equals("POST")) { 
                String api = "http://localhost/Quinto/api.php";
            
                String cedula = request.getParameter("CED_EST");
                String nombre = request.getParameter("NOM_EST");
                String apellido = request.getParameter("APE_EST");
                String direccion = request.getParameter("DIR_EST");
                String telefono = request.getParameter("TEL_EST");

                String postData = "cedula=" + cedula + "&nombre=" + nombre + "&apellido=" + apellido + "&direccion=" + direccion + "&telefono=" + telefono ;

                HttpClient cliente  = HttpClient.newHttpClient();

                HttpRequest solicitud = HttpRequest.newBuilder()
                        .uri(URI.create(api))
                        .header("Content-Type", "application/x-www-form-urlencoded")
                        .POST(HttpRequest.BodyPublishers.ofString(postData))
                        .build();

                HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());

                if(respuesta.statusCode() == 200){
                    out.print("<br>");
                    out.print("<div class='alert alert-success' role='alert'>REGISTRADO CON ÉXITO</div>");
                }else{
                    out.print("<div class='alert alert-danger' role='alert'>ERROR AL REGISTRAR</div> " + respuesta.statusCode());
                }
            }
            

        %>
    </body>
</html>
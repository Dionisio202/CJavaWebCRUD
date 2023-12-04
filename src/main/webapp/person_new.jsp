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
            if (request.getMethod().equalsIgnoreCase("POST")) { 
                String url = "http://localhost/quinto-api/api.php";
                try {
                    // Obtener los datos del formulario
                    String cedula = request.getParameter("CED_EST");
                    String nombre = request.getParameter("NOM_EST");
                    String apellido = request.getParameter("APE_EST");
                    String direccion = request.getParameter("DIR_EST");
                    String telefono = request.getParameter("TEL_EST");

                    // Crear la cadena de datos a enviar
                    String postData = "CED_EST=" + cedula + "&NOM_EST=" + nombre + "&APE_EST=" + apellido + "&DIR_EST=" + direccion + "&TEL_EST=" + telefono ;

                    // Establecer la conexión y enviar los datos
                    URL obj = new URL(url);
                    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
                    con.setRequestMethod("POST");
                    con.setDoOutput(true);
                    con.getOutputStream().write(postData.getBytes("UTF-8"));

                    // Obtener la respuesta del servicio web
                    int responseCode = con.getResponseCode();

                    if (responseCode == 200) {
                        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                        StringBuilder responseBuilder = new StringBuilder();
                        String inputLine;
                        while ((inputLine = in.readLine()) != null) {
                            responseBuilder.append(inputLine);
                        }
                        in.close();

                        // Mostrar la respuesta del servicio web
                        out.print("<br>");
                        out.print("<div class='alert alert-success' role='alert'>REGISTRADO CON ÉXITO</div>");
                    } else {
                        out.print("<div class='alert alert-danger' role='alert'>ERROR AL REGISTRAR</div> " + responseCode);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print("Error al consumir el servicio web: " + e.getMessage());
                }
            }
        %>
    </body>
</html>

<%@page import="com.fasterxml.jackson.core.type.TypeReference"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <jsp:include page="head.jsp"/>
    <body>
        <div>
            <jsp:include page="navbar.jsp"/>
        </div>
        <%
            String nombre = "";
            String apellido = "";
            String direccion = "";
            String telefono = "";
            String id = "";
            try {
                    id = request.getParameter("CED_EST");
                    String urlString = "http://localhost/Quinto/secionar.php?cedula="+id;

                    HttpClient cliente  = HttpClient.newHttpClient();
                    HttpRequest solicitud = HttpRequest.newBuilder()
                            .uri(URI.create(urlString))
                            .GET()
                            .build();

                    HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());

                    if (respuesta.statusCode() == 200) {
                        String jsonResponse = respuesta.body();
                        ObjectMapper objectMapper = new ObjectMapper();

                        // Convertir el JSON a una lista de mapas
                        List<Map<String, String>> lista = objectMapper.readValue(jsonResponse, new TypeReference<List<Map<String, String>>>() {});

                        // OBTENER VALORES DEL JSON
                        for (Map<String, String> persona : lista) {
                            nombre = persona.get("nombre");
                            apellido = persona.get("apellido");
                            direccion = persona.get("direccion");
                            telefono = persona.get("telefono");
                        }
                    } else {
                        out.println("Error al obtener los datos del servicio web. Código de respuesta: " + respuesta.statusCode());
                    }
                } catch (Exception e) {
                    out.print(e.getMessage());
                    out.println("Error al obtener los datos del servicio web.");
                }
           %>
        
        <form method="POST" autocomplete="off" action="actualizar.jsp">
            
            <h1>Actualizar Persona</h1><br>
                <input type="hidden" class="form-control" id="CED_EST" name="CED_EST" value="<%out.print(id);%>">
                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="NOM_EST" name="NOM_EST" value="<%out.print(nombre);%>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Apellido</label>
                    <input type="text" class="form-control" id="APE_EST" name="APE_EST" value="<%out.print(apellido);%>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Dirección</label>
                    <input type="text" class="form-control" id="DIR_EST" name="DIR_EST" value="<%out.print(direccion);%>">
                </div>
                <div class="mb-3">
                    <label class="form-label">Teléfono</label>
                    <input type="text" class="form-control" id="TEL_EST" name="TEL_EST" value="<%out.print(telefono);%>">
                </div>

                <button type="submit" class="btn btn-primary">ACTUALIZAR PERSONA</button>
        </form>

            
    </body>
</html>
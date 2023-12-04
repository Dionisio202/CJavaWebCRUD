
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
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
        <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col">Cédula</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col">Dirección</th>
                <th scope="col">Teléfono</th>
                <th scope="col">Acciones</th>
              </tr>
            </thead>
            <tbody>
                <%
                String api = "http://localhost/Quinto/api.php";
    
                HttpClient cliente  = HttpClient.newHttpClient();
                HttpRequest solicitud = HttpRequest.newBuilder()
                        .uri(URI.create(api))
                        .GET()
                        .build();
                try {
                    HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());
                    StringBuilder tablaBody = new StringBuilder();
                    JSONArray jSONArray = new JSONArray(respuesta.body());
                    JSONObject jSONObject;
                    
                    for (int i = 0; i < jSONArray.length(); i++) {
                        jSONObject = jSONArray.getJSONObject(i);
                        String fila = "<tr>" +
                                "<td>" + jSONObject.get("cedula").toString() + "</td>" +
                                "<td>" + jSONObject.get("nombre").toString() + "</td>" +
                                "<td>" + jSONObject.get("apellido").toString() + "</td>" +
                                "<td>" + jSONObject.get("direccion").toString() + "</td>" +
                                "<td>" + jSONObject.get("telefono").toString() + "</td>" +
                                "<td>" +
                                "<a href=\"update_person.jsp?CED_EST=" + jSONObject.get("cedula").toString() + "\">" +
                                "<button type=\"button\" class=\"btn btn-primary\">ACTUALIZAR</button></a>\t" +
                                "<a href=\"delete_person.jsp?CED_EST=" + jSONObject.get("cedula").toString() + "\">" +
                                "<button type=\"button\" class=\"btn btn-danger\">ELIMINAR</button></a>" +
                                "</td>" +
                                "</tr>";
                        tablaBody.append(fila);
                    }
                    out.println(tablaBody.toString());
                } catch (Exception e) {
                    out.println(e);
                }
                %>
            </tbody>
        </table>
    </body>
</html>
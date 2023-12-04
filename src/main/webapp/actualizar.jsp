<%@page import="java.net.http.HttpResponse"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="java.net.http.HttpClient"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.OutputStream"%>
<jsp:include page="update_person.jsp"/>
<%          
    if (request.getMethod().equals("POST")) {
        try {
            String url = "http://localhost/Quinto/api.php";

            // Obtener los datos del formulario
            String id = request.getParameter("CED_EST");
            String nombre_n = request.getParameter("NOM_EST");
            String apellido_n = request.getParameter("APE_EST");
            String direccion_n = request.getParameter("DIR_EST");
            String telefono_n = request.getParameter("TEL_EST");

            // Crear el objeto JSON con los datos
            JSONObject json = new JSONObject();
            json.put("cedula", id);
            json.put("nombre", nombre_n);
            json.put("apellido", apellido_n);
            json.put("direccion", direccion_n);
            json.put("telefono", telefono_n);

            // Configurar la solicitud HTTP PUT
            HttpClient cliente = HttpClient.newHttpClient();
            HttpRequest solicitud = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(json.toString()))
                    .build();

            // Enviar la solicitud y obtener la respuesta
            HttpResponse<String> respuesta = cliente.send(solicitud, HttpResponse.BodyHandlers.ofString());

            // Manejar la respuesta del servicio web
            if (respuesta.statusCode() == 200) {
                // Mostrar la respuesta del servicio web
                //out.print("<br>");
                response.sendRedirect("person_list.jsp"); // Redireccionar a la lista de personas
            } else {
                out.print("<div class='alert alert-danger' role='alert'>ERROR AL ACTUALIZAR</div> " + respuesta.statusCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error al consumir el servicio web: " + e.getMessage());
        }
    }
%>
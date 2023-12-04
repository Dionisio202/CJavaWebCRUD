<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
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
        <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Cédula</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col">Dirección</th>
                <th scope="col">Teléfono</th>
                <th scope="col">Acciones</th>
              </tr>
            </thead>
            <tbody id="tablaBody">
            </tbody>
        </table>
        <script>
            // Realizar la solicitud al servicio web PHP para obtener datos JSON
            fetch('http://localhost/quinto-api/api.php', {
                method: 'GET' // Especificar el método como GET
            })
            .then(response => response.json())
            .then(data => {
                // Obtener el cuerpo de la tabla
                var tablaBody = document.getElementById('tablaBody');

                // Iterar sobre los datos JSON y agregar filas a la tabla
                data.forEach(function(item, index) {
                    var fila = '<tr>' +
                                    '<th scope="row">' + (index + 1) + '</th>' +
                                    '<td>' + item.CED_EST + '</td>' +
                                    '<td>' + item.NOM_EST + '</td>' +
                                    '<td>' + item.APE_EST + '</td>' +
                                    '<td>' + item.DIR_EST + '</td>' +
                                    '<td>' + item.TEL_EST + '</td>' +
                                    '<td>' +
                                        '<a href="update_person.jsp?CED_EST='+item.CED_EST+'"><button type="button" class="btn btn-primary">ACTUALIZAR</button></a>\t' +
                                        '<a href="delete_person.jsp?CED_EST='+item.CED_EST+'"><button type="button" class="btn btn-danger">ELIMINAR</button></a>' +
                                    '</td>' +
                                '</tr>';
                    tablaBody.innerHTML += fila;
                });
            })
            .catch(error => console.error('Error:', error));
        </script>
    </body>
</html>
#!/bin/bash
dnf install -y nginx bind-utils
systemctl enable --now nginx
cat > /usr/share/nginx/html/index.html <<EOF
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Librería Tinta - Servidor 2</title>
</head>
<body style="background-color: #f0f8ff;">
  <h1>Librería Tinta [SERVIDOR 2 - VERSIÓN B (20%)]</h1>
  <p>Tu librería de barrio - Nueva versión en pruebas.</p>
  <p><strong>Dirección:</strong> Calle Mayor 14, Alicante</p>
  <p><strong>Horario:</strong> Lunes a Viernes de 09:30 a 14:00 y de 17:00 a 20:30 | Sábados de 10:00 a 14:00</p>
  <p><strong>Recomendación del mes:</strong> <em>Fahrenheit 451</em> - Ray Bradbury</p>
  <hr>
  <small>Desplegado por Tania Algarra en el servidor \$(hostname) el \$(date '+%d/%m/%Y %H:%M')</small>
</body>
</html>
EOF
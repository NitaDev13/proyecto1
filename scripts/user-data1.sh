#!/bin/bash
dnf install -y nginx
systemctl enable --now nginx
cat > /usr/share/nginx/html/index.html <<EOF
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>Librería Tinta</title>
</head>
<body>
  <h1>Librería Tinta</h1>
  <p>Tu librería de barrio.</p>
  <p><strong>Dirección:</strong> Calle Mayor 14, Alicante</p>
  <p><strong>Horario:</strong> Lunes a Viernes de 09:30 a 14:00 y de 17:00 a 20:30 | Sábados de 10:00 a 14:00</p>
  <p><strong>Recomendación del mes:</strong> <em>Cien años de soledad</em> - Gabriel García Márquez</p>
  <hr>
  <small>Desplegado por Tania Algarra en el servidor \$(hostname) el \$(date '+%d/%m/%Y %H:%M')</small>
</body>
</html>
EOF
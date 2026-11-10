# proyecto1
Proyecto 1: Despliegue de infraestructura web y alta disponibilidad en AWS con CLI y Route 53 (2º DAW - Nube Pública)

## Nivel Básico

### B1. Configuración de Red
Se ha creado una VPC dedicada (`libreria-vpc`) con bloque CIDR `10.0.0.0/16`, una subred pública (`libreria-publica`) en `us-east-1a` con auto-asignación de IPv4 pública habilitada, un Internet Gateway (`libreria-igw`) conectado a la VPC y una tabla de rutas (`libreria-rt-publica`) asociada a la subred con salida directa a Internet (`0.0.0.0/0`).

![Tabla de rutas pública](img/b1-tabla-rutas.png)

### B2. Grupo de Seguridad
Se ha creado el Security Group `libreria-sg` dentro de `libreria-vpc` con reglas de entrada para permitir el tráfico SSH (puerto 22) y HTTP (puerto 80) desde cualquier origen IPv4 (`0.0.0.0/0`).

![Reglas de entrada del Security Group](img/b2-grupo-seguridad.png)

### B3. El Servidor Web
Se ha desplegado la instancia EC2 `libreria-web` (`t3.micro`) sobre Amazon Linux 2023 en la subred pública `libreria-publica`, configurada con el Security Group `libreria-sg` y etiquetada con `Proyecto=P1` y `Alumno=Tania Algarra`.

![Configuración de la instancia EC2](img/b3-ec2-instancia.png)

A través del script de *User Data*, el servidor instaló e inició Nginx de forma desatendida, sirviendo la web corporativa de la librería:

![Web de la librería activa en el navegador](img/b3-web-navegador.png)

### B4. Cálculo de Costes
Se ha realizado la estimación de costes con **AWS Pricing Calculator** para mantener la instancia `libreria-web` (`t3.micro` bajo demanda con disco EBS gp3 en la región `us-east-1`) encendida 24/7 (730 horas/mes):

- **Coste mensual estimado:** 8,23 USD/mes.
- **Enlace a la estimación pública:** [Estimación AWS Pricing Calculator](https://calculator.aws/#/estimate?id=fc3b379bd28c6dae67edce243333f34138e9bce6)

**Optimización de costes:**
Para abaratar este servicio se podría programar el apagado automático de la máquina fuera del horario laboral de la librería mediante AWS Lambda o Instance Scheduler.
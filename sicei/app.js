const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Base de datos en memoria
const alumnos = [
  { nombre: "Vicente Nava", matricula: "A16001508" },
  { nombre: "María González", matricula: "A16001124" },
  { nombre: "Carlos Rodríguez", matricula: "A16001125" },
  { nombre: "Ana Martínez", matricula: "A16001126" },
  { nombre: "Roberto Sánchez", matricula: "A16001127" }
];

const profesores = [
  { nombre: "Víctor Menéndez Domínguez", numeroEmpleado: "P001" },
  { nombre: "Otilio Santos Aguilar", numeroEmpleado: "P002" },
  { nombre: "Eduardo Rodríguez González", numeroEmpleado: "P003" },
  { nombre: "Luis Curi Quintal", numeroEmpleado: "P004" }
];

// Endpoints
app.get('/', (req, res) => {
  res.json({ message: 'Bienvenido a la API de SICEI' });
});

app.get('/alumnos', (req, res) => {
  res.json(alumnos);
});

app.get('/profesores', (req, res) => {
  res.json(profesores);
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor SICEI corriendo en el puerto ${PORT}`);
});
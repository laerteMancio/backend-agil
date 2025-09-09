// api/server.js
const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const cookieParser = require("cookie-parser");


// Rotas
const sendEmailRoute = require("./routes/enviarEmail");



dotenv.config();

const app = express();

// ------------------ CORS ------------------
// Permite localhost para desenvolvimento
app.use(cors({
  origin: [
    "http://localhost:5173",
    "https://frontend-gerenciador-campanhas.vercel.app"
  ],
  credentials: true
}));

app.use(cookieParser());
app.use(express.json());

// ------------------ Rotas ------------------

app.use("/send-email", sendEmailRoute);





// ------------------ Export ------------------
// Para Vercel, sem listen()
module.exports = app;

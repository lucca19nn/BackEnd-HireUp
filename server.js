require('dotenv').config();
const express = require("express");
const cors = require("cors");
const pool = require('./src/config/database'); 

const userRoutes = require('./src/routes/UserRoutes');
const jobRoutes = require('./src/routes/JobRoutes');
const candidateRoutes = require('./src/routes/CandidateRoutes');
const applicationRoutes = require('./src/routes/ApplicationRoutes');
const authRoutes = require('./src/routes/authRoutes');


const app = express();

app.use(cors());
app.use(express.json());

app.use('/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/jobs', jobRoutes);
app.use('/api/candidates', candidateRoutes);
app.use('/api/applications', applicationRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor rodando em http://localhost:${PORT}`);
});
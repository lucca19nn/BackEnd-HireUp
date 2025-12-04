const CandidateModel = require('../models/CandidateModel');
const bcrypt = require('bcryptjs');

module.exports = {
  async getAll(req, res) {
    const candidates = await CandidateModel.getAll();
    return res.json(candidates);
  },

  async getById(req, res) {
    const candidate = await CandidateModel.getById(req.params.id);
    if (!candidate) return res.status(404).json({ error: 'Candidate not found' });
    return res.json(candidate);
  },

  async create(req, res) {
    try {
      const { name, email, phone, linkedin_url, avatar_url, password, status } = req.body;

      if (!password) {
        return res.status(400).json({ error: 'Password is required' });
      }

      const passwordHash = await bcrypt.hash(password, 10);

      const candidate = await CandidateModel.create({
        name, 
        email, 
        phone, 
        linkedin_url, 
        avatar_url, 
        password: passwordHash,
        status: status || 'Triagem'
      });

      return res.status(201).json(candidate);
    } catch (err) {
      return res.status(400).json({ error: err.message });
    }
  },

  async update(req, res) {
    const candidate = await CandidateModel.update(req.params.id, req.body);
    if (!candidate) return res.status(404).json({ error: 'Candidate not found' });
    return res.json(candidate);
  },

  async delete(req, res) {
    const candidate = await CandidateModel.delete(req.params.id);
    if (!candidate) return res.status(404).json({ error: 'Candidate not found' });
    return res.status(204).send();
  }
};
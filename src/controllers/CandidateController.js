const CandidateModel = require('../models/CandidateModel');

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
      const candidate = await CandidateModel.create(req.body);
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
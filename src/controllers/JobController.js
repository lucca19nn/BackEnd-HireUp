const JobModel = require('../models/JobModel');

module.exports = {
  async getAll(req, res) {
    try {
      const { title, company, city, type } = req.query;
      const jobs = await JobModel.getAll(title, company, city, type);
      return res.json(jobs);
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
    
  },

  async getById(req, res) {
    const job = await JobModel.getById(req.params.id);
    if (!job) return res.status(404).json({ error: 'Job not found' });
    return res.json(job);
  },

  async create(req, res) {
    try {
      const job = await JobModel.create(req.body);
      return res.status(201).json(job);
    } catch (err) {
      return res.status(400).json({ error: err.message });
    }
  },

  async update(req, res) {
    const job = await JobModel.update(req.params.id, req.body);
    if (!job) return res.status(404).json({ error: 'Job not found' });
    return res.json(job);
  },

  async delete(req, res) {
    const job = await JobModel.delete(req.params.id);
    if (!job) return res.status(404).json({ error: 'Job not found' });
    return res.status(204).send();
  },

  async removeInactive(req, res) {
    try {
      const count = await JobModel.deleteInactive();
      return res.status(200).json({ message: `Limpeza concluída. ${count} vagas antigas foram removidas.` });
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
  }
};
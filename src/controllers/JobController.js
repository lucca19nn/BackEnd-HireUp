const JobModel = require('../models/JobModel');

module.exports = {
  async getAll(req, res) {
    const jobs = await JobModel.getAll();
    return res.json(jobs);
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
  }
};
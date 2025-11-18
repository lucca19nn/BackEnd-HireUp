const ApplicationModel = require('../models/ApplicationModel');

module.exports = {
  async getAll(req, res) {
    const apps = await ApplicationModel.getAll();
    return res.json(apps);
  },

  async getById(req, res) {
    const app = await ApplicationModel.getById(req.params.id);
    if (!app) return res.status(404).json({ error: 'Application not found' });
    return res.json(app);
  },

  async create(req, res) {
    try {
      const app = await ApplicationModel.create(req.body);
      return res.status(201).json(app);
    } catch (err) {
      if (err.code === '23505') return res.status(409).json({ error: 'Already applied' });
      return res.status(400).json({ error: err.message });
    }
  },

  async update(req, res) {
    const { status } = req.body;
    const app = await ApplicationModel.update(req.params.id, status);
    if (!app) return res.status(404).json({ error: 'Application not found' });
    return res.json(app);
  },

  async delete(req, res) {
    const app = await ApplicationModel.delete(req.params.id);
    if (!app) return res.status(404).json({ error: 'Application not found' });
    return res.status(204).send();
  }
};
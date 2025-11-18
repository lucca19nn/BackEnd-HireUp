const ApplicationModel = require('../models/ApplicationModel');

module.exports = {
  async getAll(req, res) {
    try {
      const applications = await ApplicationModel.getAll();
      return res.json(applications);
    } catch (err) {
      return res.status(500).json({ error: 'Erro ao buscar candidaturas.' });
    }
  },

  async getById(req, res) {
    const application = await ApplicationModel.getById(req.params.id);
    if (!application) {
      return res.status(404).json({ error: 'Candidatura não encontrada' });
    }
    return res.json(application);
  },

  async getByJobId(req, res) {
    const jobId = req.params.jobId;

    try {
      const applications = await ApplicationModel.getByJobId(jobId);

      if (applications.length === 0) {
        return res.status(404).json({ error: 'Nenhuma candidatura encontrada para esta vaga.' });
      }

      return res.json(applications);
    } catch (err) {
      return res.status(500).json({ error: err.message });
    }
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
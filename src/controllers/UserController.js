const UserModel = require('../models/UserModel');

module.exports = {
  async getAll(req, res) {
    const users = await UserModel.getAll();
    return res.json(users);
  },

  async getById(req, res) {
    const { id } = req.params;
    const user = await UserModel.getById(id);
    if (!user) return res.status(404).json({ error: 'User not found' });
    return res.json(user);
  },

  async create(req, res) {
    try {
      const user = await UserModel.create(req.body);
      return res.status(201).json(user);
    } catch (err) {
      return res.status(400).json({ error: err.message });
    }
  },

  async update(req, res) {
    const { id } = req.params;
    const user = await UserModel.update(id, req.body);
    if (!user) return res.status(404).json({ error: 'User not found' });
    return res.json(user);
  },

  async delete(req, res) {
    const { id } = req.params;
    const user = await UserModel.delete(id);
    if (!user) return res.status(404).json({ error: 'User not found' });
    return res.status(204).send();
  }
};
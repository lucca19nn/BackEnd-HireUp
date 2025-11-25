const pool = require('../config/database');

module.exports = { 
  async getAll(roleFilter) {
    let query = 'SELECT id, name, email, role, avatar_url, created_at FROM users';
    let values = [];

    if (roleFilter) {
        query += ' WHERE role = $1';
        values.push(roleFilter);
    }
    query += ' ORDER BY id ASC';

    const result = await pool.query(query, values);
    return result.rows;
  },

  async findByEmail(email) {
    const result = await pool.query(
      'SELECT id, name, email, password, role, avatar_url, created_at FROM users WHERE email = $1', 
      [email]
    );
    return result.rows[0]; 
  },

  async getById(id) {
    const result = await pool.query(
      'SELECT id, name, email, role, avatar_url, created_at FROM users WHERE id = $1', 
      [id]
    );
    return result.rows[0];
  },

  async create(user) {
    const { name, email, password, role, avatar_url } = user;
    const result = await pool.query(
      `INSERT INTO users (name, email, password, role, avatar_url) 
        VALUES ($1, $2, $3, $4, $5) 
        RETURNING id, name, email, role, avatar_url, created_at`,
      [name, email, password, role || 'recruiter', avatar_url]
    );
    return result.rows[0];
  },

  async update(id, user) {
    const { name, email, role, avatar_url } = user;
    const result = await pool.query(
      `UPDATE users SET name = $1, email = $2, role = $3, avatar_url = $4 
        WHERE id = $5 RETURNING id, name, email, role, avatar_url`,
      [name, email, role, avatar_url, id]
    );
    return result.rows[0];
  },

  async delete(id) {
    const result = await pool.query('DELETE FROM users WHERE id = $1 RETURNING id', [id]);
    return result.rows[0];
  }
};
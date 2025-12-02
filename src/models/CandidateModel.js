const pool = require('../config/database');

module.exports = {
  async getAll() {
    const result = await pool.query('SELECT * FROM candidates ORDER BY created_at DESC');
    return result.rows;
  },

  async getById(id) {
    const result = await pool.query('SELECT * FROM candidates WHERE id = $1', [id]);
    return result.rows[0];
  },

  async create(candidate) {
    const { name, email, phone, linkedin_url, avatar_url, password } = candidate;
    const result = await pool.query(
      `INSERT INTO candidates (name, email, phone, linkedin_url, avatar_url, password) 
       VALUES ($1, $2, $3, $4, $5, $6) 
       RETURNING id, name, email, created_at`, 
      [name, email, phone, linkedin_url, avatar_url, password]
    );
    return result.rows[0];
  },

  async update(id, candidate) {
    const { name, email, phone, linkedin_url, avatar_url } = candidate;
    const result = await pool.query(
      `UPDATE candidates SET name = $1, email = $2, phone = $3, linkedin_url = $4, avatar_url = $5 
       WHERE id = $6 RETURNING *`,
      [name, email, phone, linkedin_url, avatar_url, id]
    );
    return result.rows[0];
  },

  async delete(id) {
    await pool.query('DELETE FROM applications WHERE candidate_id = $1', [id]);

    const result = await pool.query('DELETE FROM candidates WHERE id = $1', [id]);
    return result.rowCount > 0;
  }
};
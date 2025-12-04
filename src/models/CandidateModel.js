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
    const { name, email, phone, linkedin_url, avatar_url, password, status } = candidate;
    const result = await pool.query(
      `INSERT INTO candidates (name, email, phone, linkedin_url, avatar_url, password, status) 
       VALUES ($1, $2, $3, $4, $5, $6, $7) 
       RETURNING *`, 
      [name, email, phone, linkedin_url, avatar_url, password, status || 'Triagem']
    );
    return result.rows[0];
  },

  async update(id, candidate) {
    const { name, email, phone, linkedin_url, avatar_url, status } = candidate;
    const result = await pool.query(
      `UPDATE candidates SET name = $1, email = $2, phone = $3, linkedin_url = $4, avatar_url = $5, status = $6
       WHERE id = $7 RETURNING *`,
      [name, email, phone, linkedin_url, avatar_url, status, id]
    );
    return result.rows[0];
  },

  async delete(id) {
    await pool.query('DELETE FROM applications WHERE candidate_id = $1', [id]);

    const result = await pool.query('DELETE FROM candidates WHERE id = $1', [id]);
    return result.rowCount > 0;
  }
};
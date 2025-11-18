const pool = require('../config/database');

module.exports = {
  async getAll() {
    const query = `
      SELECT j.*, u.name as recruiter_name, u.avatar_url as recruiter_avatar 
      FROM jobs j JOIN users u ON j.recruiter_id = u.id ORDER BY j.created_at DESC`;
    const result = await pool.query(query);
    return result.rows;
  },

  async getById(id) {
    const query = `
      SELECT j.*, u.name as recruiter_name 
      FROM jobs j JOIN users u ON j.recruiter_id = u.id WHERE j.id = $1`;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  async create(job) {
    const { title, description, salary, status, recruiter_id } = job;
    const result = await pool.query(
      `INSERT INTO jobs (title, description, salary, status, recruiter_id) 
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [title, description, salary, status || 'OPEN', recruiter_id]
    );
    return result.rows[0];
  },

  async update(id, job) {
    const { title, description, salary, status } = job;
    const result = await pool.query(
      `UPDATE jobs SET title = $1, description = $2, salary = $3, status = $4 
       WHERE id = $5 RETURNING *`,
      [title, description, salary, status, id]
    );
    return result.rows[0];
  },

  async delete(id) {
    const result = await pool.query('DELETE FROM jobs WHERE id = $1 RETURNING id', [id]);
    return result.rows[0];
  }
};
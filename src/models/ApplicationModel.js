const pool = require('../config/database');

module.exports = {
  async getAll() {
    const query = `
      SELECT a.id, a.status, j.title as job_title, c.name as candidate_name 
      FROM applications a 
      JOIN jobs j ON a.job_id = j.id 
      JOIN candidates c ON a.candidate_id = c.id 
      ORDER BY a.id DESC`;
    const result = await pool.query(query);
    return result.rows;
  },

  async getById(id) {
    const query = `SELECT * FROM applications WHERE id = $1`;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  async create(app) {
    const { job_id, candidate_id, status } = app;
    const result = await pool.query(
      `INSERT INTO applications (job_id, candidate_id, status) VALUES ($1, $2, $3) RETURNING *`,
      [job_id, candidate_id, status || 'APPLIED']
    );
    return result.rows[0];
  },

  async update(id, status) {
    const result = await pool.query(
      `UPDATE applications SET status = $1 WHERE id = $2 RETURNING *`,
      [status, id]
    );
    return result.rows[0];
  },

  async delete(id) {
    const result = await pool.query('DELETE FROM applications WHERE id = $1 RETURNING id', [id]);
    return result.rows[0];
  },

  async getByJobId(jobId) {
    const query = `
        SELECT a.id, a.status, 
               c.id as candidate_id, c.name as candidate_name, c.email as candidate_email
        FROM applications a 
        JOIN candidates c ON a.candidate_id = c.id
        WHERE a.job_id = $1
        ORDER BY a.id DESC`;
    
    const result = await pool.query(query, [jobId]);
    return result.rows;
}
};
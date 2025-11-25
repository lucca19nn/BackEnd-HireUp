const pool = require('../config/database');

module.exports = {
  async getAll(title, company, city, type) {
    if (title) {
      const query = `
        SELECT j.*, u.name as recruiter_name, u.avatar_url as recruiter_avatar  
        FROM jobs j JOIN users u ON j.recruiter_id = u.id
        WHERE j.title ILIKE $1
        ORDER BY j.created_at DESC`;
      const result = await pool.query(query, [`%${title}%`]);
      return result.rows;
    }
    if (company) {
      const query = `
        SELECT j.*, u.name as recruiter_name, u.avatar_url as recruiter_avatar
        FROM jobs j JOIN users u ON j.recruiter_id = u.id
        WHERE j.company ILIKE $1
        ORDER BY j.created_at DESC`;
      const result = await pool.query(query, [`%${company}%`]);
      return result.rows;
    }

    if (city) {
      const query = `
        SELECT j.*, u.name as recruiter_name, u.avatar_url as recruiter_avatar
        FROM jobs j JOIN users u ON j.recruiter_id = u.id
        WHERE j.city ILIKE $1
        ORDER BY j.created_at DESC`;
      const result = await pool.query(query, [`%${city}%`]);
      return result.rows;
    }
    if (type) {
      const query = `
        SELECT j.*, u.name as recruiter_name, u.avatar_url as recruiter_avatar  
        FROM jobs j JOIN users u ON j.recruiter_id = u.id
        WHERE j.type ILIKE $1
        ORDER BY j.created_at DESC`;
      const result = await pool.query(query, [`%${type}%`]);
      return result.rows;
    }
    
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
    const { title, description, company, city, type,salary, status } = job;
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
  },

  async deleteInactive() {
    const query = `
      DELETE FROM jobs 
      WHERE status IN ('CLOSED', 'FILLED', 'CANCELLED') 
      RETURNING id
    `;
    const result = await pool.query(query);
    return result.rowCount; 
  }
};
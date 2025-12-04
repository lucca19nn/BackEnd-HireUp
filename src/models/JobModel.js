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
      SELECT 
        j.*, 
        u.name as recruiter_name,
        u.avatar_url as recruiter_avatar
      FROM jobs j 
      JOIN users u ON j.recruiter_id = u.id 
      WHERE j.id = $1`;
    const result = await pool.query(query, [id]);
    return result.rows[0];
  },

  async create(job) {
    const {  title,
      description,
      company,
      city,
      type,
      salary,
      status,
      recruiter_id,
      salary_description,
      summary,
      responsibilities,
      requirements,
      company_mission,
      company_vision,
      company_values,
      address,
      company_description,
      company_overview
    } = job;
    const result = await pool.query(
      ` INSERT INTO jobs (
        title, description, company, city, type, salary, status, recruiter_id,
        salary_description, summary, responsibilities, requirements,
        company_mission, company_vision, company_values, address,
        company_description, company_overview
      )
      VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8,
        $9, $10, $11, $12,
        $13, $14, $15, $16,
        $17, $18
      )
      RETURNING *
    `,
      [  title,
        description,
        company,
        city,
        type,
        salary,
        status,
        recruiter_id,
        salary_description,
        summary,
        responsibilities,
        requirements,
        company_mission,
        company_vision,
        company_values,
        address,
        company_description,
        company_overview
      ]
    );
    return result.rows[0];
  },

  async update(id, job) {
    const {title,
      description,
      company,
      city,
      type,
      salary,
      status,
      salary_description,
      summary,
      responsibilities,
      requirements,
      company_mission,
      company_vision,
      company_values,
      address,
      company_description,
      company_overview
    } = job;
    const result = await pool.query(
      `  UPDATE jobs SET
        title = $1,
        description = $2,
        company = $3,
        city = $4,
        type = $5,
        salary = $6,
        status = $7,
        salary_description = $8,
        summary = $9,
        responsibilities = $10,
        requirements = $11,
        company_mission = $12,
        company_vision = $13,
        company_values = $14,
        address = $15,
        company_description = $16,
        company_overview = $17
      WHERE id = $18
      RETURNING *
    `,
      [ title,
        description,
        company,
        city,
        type,
        salary,
        status,
        salary_description,
        summary,
        responsibilities,
        requirements,
        company_mission,
        company_vision,
        company_values,
        address,
        company_description,
        company_overview,
        id]
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
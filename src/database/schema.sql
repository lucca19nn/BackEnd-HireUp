CREATE DATABASE hire_db;
\c hire_db;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'recruiter',
    avatar_url VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP )
;


CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    company VARCHAR(255),
    city VARCHAR(255),
    type VARCHAR(50),
    salary NUMERIC(10, 2),
    status VARCHAR(50) DEFAULT 'OPEN',
    recruiter_id INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (recruiter_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE candidates (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    linkedin_url VARCHAR(255),
    avatar_url VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
);

    CREATE TABLE applications (
        id SERIAL PRIMARY KEY,
        job_id INTEGER NOT NULL,
        candidate_id INTEGER NOT NULL,
        status VARCHAR(50) DEFAULT 'APPLIED', 
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
        FOREIGN KEY (candidate_id) REFERENCES candidates(id),
        UNIQUE(job_id, candidate_id) 
    );

INSERT INTO users (name, email, password, role, avatar_url) VALUES 
(
    'Ana Silva', 
    'ana.recrutadora@empresa.com', 
    'senha_hash_segura_123', 
    'recruiter', 
    'https://i.pravatar.cc/150?u=ana'
),
(
    'Roberto Santos', 
    'roberto.tech@empresa.com', 
    'senha_forte_456', 
    'admin', 
    'https://i.pravatar.cc/150?u=roberto'
),
(
    'Carla Mendez', 
    'carla.rh@empresa.com', 
    'outra_senha_789', 
    'recruiter', 
    'https://i.pravatar.cc/150?u=carla'
);

INSERT INTO jobs (title, description, company, city, type, salary, status, recruiter_id) VALUES 
('Desenvolvedor Backend Senior', 'Experiencia com Node.js PostgreSQL e Docker.', 'High Tech', 'Sao Paulo', 'CLT', 12000.00, 'OPEN', 1),
('Designer UX/UI', 'Figma prototipacao e pesquisa com usuarios.', 'Nubank', 'Rio de Janeiro', 'PJ', 8500.50, 'OPEN', 1),
('Tech Lead', 'Lideranca tecnica de equipe agil.', 'Banco do Bradesco', 'Belo Horizonte', 'CLT', 18000.00, 'INTERVIEWING', 2),
('Estagiario de QA', 'Testes manuais e automacao basica.', 'Arcell Mital', 'Curitiba', 'Estagio', 2500.00, 'CLOSED', 3);

INSERT INTO candidates (name, email, phone, linkedin_url, avatar_url) VALUES 
('Lucas Oliveira', 'lucas.dev@email.com', '11999991111', 'linkedin.com/in/lucasdev', 'https://i.pravatar.cc/150?u=lucasdev'),
('Fernanda Costa', 'fernanda.design@email.com', '21988882222', 'linkedin.com/in/fernandaux', 'https://i.pravatar.cc/150?u=fernandaux'),
('João Pedro', 'joao.pedro@email.com', '31977773333', 'linkedin.com/in/joaopedro', 'https://i.pravatar.cc/150?u=joaopedro'),
('Mariana Souza', 'mari.souza@email.com', '41966664444', 'linkedin.com/in/marisouza', 'https://i.pravatar.cc/150?u=marisouza');

INSERT INTO applications (job_id, candidate_id, status) VALUES 
(1, 1, 'INTERVIEW'),   
(1, 4, 'APPLIED'),     
(2, 2, 'HIRED'),       
(3, 1, 'REJECTED'),    
(4, 3, 'APPLIED');  
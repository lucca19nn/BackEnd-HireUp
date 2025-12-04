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
    password VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Triagem',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
);

    CREATE TABLE applications (
        id SERIAL PRIMARY KEY,
        job_id INTEGER NOT NULL,
        candidate_id INTEGER NOT NULL,
        status VARCHAR(50) DEFAULT 'APPLIED', 
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
        FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
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
('Estagiario de QA', 'Testes manuais e automacao basica.', 'Arcell Mital', 'Curitiba', 'Estagio', 2500.00, 'CLOSED', 3),
('Desenvolvedor Frontend Pleno', 'React, Next.js, consumo de APIs REST e experiencia com UI/UX.', 'TechOne', 'Sao Paulo', 'CLT', 9000.00, 'OPEN', 1),
('Analista de Dados Junior', 'SQL, Python e Power BI. Apoio em analises e dashboards.', 'DataSpark', 'Rio de Janeiro', 'CLT', 6000.00, 'OPEN', 2),
('Product Manager', 'Gestao de produto, roadmap e stakeholder management.', 'Innova Digital', 'Florianopolis', 'PJ', 15000.00, 'OPEN', 1),
('Desenvolvedor Mobile React Native', 'Criacao de aplicativos multiplataforma e integracao com APIs.', 'AppWorks', 'Sao Paulo', 'CLT', 11000.00, 'OPEN', 3),
('Engenheiro DevOps', 'Kubernetes, CI/CD, AWS, monitoramento e automacao de pipelines.', 'CloudBridge', 'Porto Alegre', 'PJ', 16000.00, 'OPEN', 2),
('Analista de Suporte Tecnico', 'Atendimento ao cliente, troubleshooting e documentacao.', 'HelpTech', 'Salvador', 'CLT', 3500.00, 'OPEN', 2),
('Cientista de Dados Pleno', 'Machine Learning, Python, modelos estatisticos e big data.', 'Brain Analytics', 'Recife', 'PJ', 14000.00, 'OPEN', 1),
('UI Designer', 'Design de interfaces, sistemas de design e prototipacao no Figma.', 'PixelPro', 'Campinas', 'CLT', 8000.00, 'OPEN', 3),
('Especialista em Ciberseguranca', 'Hardening, testes de penetracao e monitoramento de vulnerabilidades.', 'SecureHub', 'Sao Paulo', 'CLT', 17000.00, 'OPEN', 1),
('Coordenador de TI', 'Gestao de equipes, infraestrutura de TI e governanca.', 'Global Systems', 'Brasilia', 'CLT', 13000.00, 'OPEN', 2);


INSERT INTO candidates (name, email, phone, linkedin_url, avatar_url, password, status) VALUES
('Lucas Oliveira', 'lucas.dev@email.com', '11999991111', 'linkedin.com/in/lucasdev', 'https://i.pravatar.cc/150?u=lucasdev', 'hash_123', 'Triagem'),
('Fernanda Costa', 'fernanda.design@email.com', '21988882222', 'linkedin.com/in/fernandaux', 'https://i.pravatar.cc/150?u=fernandaux', 'hash_456', 'Entrevista'),
('João Pedro', 'joao.pedro@email.com', '31977773333', 'linkedin.com/in/joaopedro', 'https://i.pravatar.cc/150?u=joaopedro', 'hash_789', 'Triagem'),
('Mariana Souza', 'mari.souza@email.com', '41966664444', 'linkedin.com/in/marisouza', 'https://i.pravatar.cc/150?u=marisouza', 'hash_abc', 'Aprovado');

INSERT INTO applications (job_id, candidate_id, status) VALUES 
(1, 1, 'INTERVIEW'),   
(1, 4, 'APPLIED'),     
(2, 2, 'HIRED'),       
(3, 1, 'REJECTED'),    
(4, 3, 'APPLIED');  
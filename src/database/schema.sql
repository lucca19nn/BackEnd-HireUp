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
    salary_description TEXT,
    summary TEXT,
    responsibilities TEXT[], 
    requirements TEXT[],
    company_mission TEXT,
    company_vision TEXT,
    company_values TEXT,
    address TEXT,
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

INSERT INTO jobs (
    title, description, company, city, type, salary, status, recruiter_id,
    salary_description, summary, responsibilities, requirements,
    company_mission, company_vision, company_values, address
) VALUES 
(
    'Desenvolvedor Backend Senior',
    'Experiencia com Node.js PostgreSQL e Docker.',
    'High Tech',
    'Sao Paulo',
    'CLT',
    12000.00,
    'OPEN',
    1,
    'Faixa salarial compatível com sênior + benefícios.',
    'Profissional experiente para atuar em sistemas escaláveis.',
    ARRAY['Criar APIs robustas', 'Gerenciar banco PostgreSQL', 'Implementar testes'],
    ARRAY['5+ anos de experiência', 'Node.js avançado', 'Docker', 'SQL'],
    'Inovar soluções tecnológicas.',
    'Ser referência nacional em tecnologia.',
    'Transparência, inovação, respeito.',
    'Avenida Paulista, 1000 - São Paulo'
),
(
    'Designer UX/UI',
    'Figma prototipacao e pesquisa com usuarios.',
    'Nubank',
    'Rio de Janeiro',
    'PJ',
    8500.50,
    'OPEN',
    1,
    'Pagamento mensal via contrato PJ.',
    'Criação de interfaces focadas no usuário.',
    ARRAY['Criar protótipos', 'Conduzir pesquisas', 'Testes de usabilidade'],
    ARRAY['Domínio em Figma', 'Experiência em UX', 'Portfólio atualizado'],
    'Descomplicar serviços financeiros.',
    'Ser a maior fintech da América Latina.',
    'Usuário em primeiro lugar, simplicidade, ética.',
    'Rua das Laranjeiras, 250 - Rio de Janeiro'
),
(
    'Tech Lead',
    'Lideranca tecnica de equipe agil.',
    'Banco do Bradesco',
    'Belo Horizonte',
    'CLT',
    18000.00,
    'INTERVIEWING',
    2,
    'Salário CLT + bônus anual.',
    'Liderar squad de engenharia.',
    ARRAY['Guiar decisões técnicas', 'Mentorar equipe', 'Apoiar arquitetura'],
    ARRAY['Experiência com liderança', 'Conhecimento sólido em backend', 'DevOps básico'],
    'Apoiar o crescimento financeiro do país.',
    'Ser o banco mais inovador do Brasil.',
    'Responsabilidade, ética, colaboração.',
    'Av. Afonso Pena, 700 - Belo Horizonte'
),
(
    'Estagiario de QA',
    'Testes manuais e automacao basica.',
    'Arcell Mital',
    'Curitiba',
    'Estagio',
    2500.00,
    'CLOSED',
    3,
    'Bolsa estágio + VT.',
    'Apoiar rotinas de testes.',
    ARRAY['Executar testes', 'Criar cenários simples', 'Documentar bugs'],
    ARRAY['Estar cursando TI', 'Conhecimento básico de testes'],
    'Criar produtos de alto padrão.',
    'Ser líder global em tecnologia industrial.',
    'Compromisso, segurança, qualidade.',
    'Rua XV de Novembro, 90 - Curitiba'
),
(
    'Desenvolvedor Frontend Pleno',
    'Responsável pelo desenvolvimento de interfaces modernas com React e Next.js.',
    'Stone',
    'Sao Paulo',
    'CLT',
    9000.00,
    'OPEN',
    1,
    'Faixa salarial de pleno + VR, VA, plano de saúde.',
    'Atuação em produtos de grande escala.',
    ARRAY['Criar componentes', 'Consumir APIs', 'Aplicar boas práticas de UI'],
    ARRAY['React', 'Next.js', 'Git', 'CSS moderno'],
    'Impulsionar negócios com tecnologia.',
    'Ser referência em soluções financeiras.',
    'Cliente em primeiro lugar, autonomia, confiança.',
    'Rua dos Pinheiros, 650 - São Paulo'
),
(
    'Cientista de Dados',
    'Modelagem estatística e machine learning.',
    'iFood',
    'Campinas',
    'Estágio',
    15000.00,
    'OPEN',
    2,
    'Salário compatível com mercado + bônus.',
    'Times de dados focados em alto impacto.',
    ARRAY['Criar modelos', 'Trabalhar com big data', 'Analisar KPIs'],
    ARRAY['Python', 'SQL', 'Machine Learning', 'Estatística'],
    'Transformar o delivery no Brasil.',
    'Crescer globalmente com tecnologia.',
    'Velocidade, responsabilidade, inovação.',
    'Av. Norte-Sul, 1500 - Campinas'
),
(
    'Analista de Suporte Tecnico',
    'Atendimento N2 e automação de rotinas.',
    'Totvs',
    'Rio de Janeiro',
    'Pessoa Jurídica',
    4500.00,
    'OPEN',
    3,
    'Contrato PJ com horário flexível.',
    'Atuação em ambiente corporativo.',
    ARRAY['Atender chamados', 'Gerar scripts', 'Documentar processos'],
    ARRAY['Conhecimento em infraestrutura', 'Comandos Linux', 'SQL básico'],
    'Digitalizar empresas brasileiras.',
    'Ser referência em ERP.',
    'Excelência, responsabilidade, ética.',
    'Rua Barão de Mesquita, 40 - Rio de Janeiro'
),
(
    'Scrum Master',
    'Facilitação de cerimônias e remoção de impedimentos.',
    'Mercado Livre',
    'Porto Alegre',
    'Jovem Aprendiz',
    11000.00,
    'INTERVIEWING',
    1,
    'Remuneração com bônus trimestral.',
    'Cultura ágil forte e colaborativa.',
    ARRAY['Facilitar reuniões', 'Apoiar squads', 'Medir métricas ágeis'],
    ARRAY['Scrum', 'Kanban', 'Comunicação clara', 'Liderança servidor'],
    'Potencializar o comércio digital.',
    'Expandir globalmente operações.',
    'Agilidade, abertura, inclusão.',
    'Av. Ipiranga, 2000 - Porto Alegre'
);

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
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
    company_description TEXT,
    company_overview TEXT,
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

INSERT INTO jobs (
    id, title, description, company, city, type, salary, status, recruiter_id,
    salary_description, summary, responsibilities, requirements,
    company_mission, company_vision, company_values, address,
    company_description, company_overview
) VALUES 
(
    1,
    'Desenvolvedor Backend Senior',
    'Experiencia solida com Node.js, PostgreSQL, Docker e arquitetura escalavel. Atuacao em sistemas distribuido s e aplicacoes de alta performance.',
    'High Tech',
    'Sao Paulo',
    'CLT',
    12000.00,
    'OPEN',
    1,
    'Faixa salarial compativel com senior, incluindo VR, VA, plano de saude e bonus anual.',
    'Profissional experiente para atuar na criacao e manutencao de servicos escalaveis.',
    ARRAY['Criar APIs robustas', 'Gerenciar banco PostgreSQL', 'Implementar testes automatizados', 'Participar de decisoes arquiteturais'],
    ARRAY['5+ anos de experiencia', 'Node.js avancado', 'SQL avancado', 'Docker e CI/CD', 'Experiencia com microsservicos'],
    'Inovar solucoes tecnologicas e criar produtos digitais de alto impacto.',
    'Ser referencia nacional na criacao de plataformas escalaveis e inteligentes.',
    'Transparencia, inovacao, colaboracao e respeito.',
    'Avenida Paulista, 1000 - Sao Paulo',
    ARRAY[
        'A High Tech e uma empresa focada no desenvolvimento de solucoes digitais avancadas, atendendo clientes de diversos segmentos que buscam tecnologia de ponta. Nossos produtos sao desenvolvidos com foco em escalabilidade, seguranca e eficiencia, permitindo que empresas crescam de forma estruturada.',
        'Trabalhamos com uma cultura forte de colaboracao, onde os times sao incentivados a compartilhar conhecimento, explorar novas tecnologias e participar de decisoes importantes. Aqui, cada profissional tem autonomia para influenciar diretamente a evolucao dos sistemas.'
    ],
    ARRAY[
        'Nossa equipe opera com metodologias ageis, promovendo ciclos rapidos de entrega e validacao. Incentivamos a pesquisa e desenvolvimento continuo para garantir que nossas solucoes estejam sempre alinhadas as melhores praticas do mercado.',
        'A High Tech oferece um ambiente moderno, com foco em aprendizado constante e liberdade para propor novas ideias. Valorizamos profissionais criativos que queiram participar da construcao de plataformas que impactam milhares de usuarios.'
    ]
),
(
    2,
    'Designer UX/UI',
    'Desenvolvimento de interfaces intuitivas e centradas no usuario, utilizando Figma, prototipo de alta fidelidade e testes de usabilidade.',
    'Nubank',
    'Rio de Janeiro',
    'PJ',
    8500.50,
    'OPEN',
    1,
    'Pagamento mensal via contrato PJ + beneficios flexiveis.',
    'Criacao de experiencias visuais que melhorem a jornada do usuario.',
    ARRAY['Criar prototipos', 'Conduzir pesquisas', 'Realizar testes de usabilidade', 'Trabalhar com times multidisciplinares'],
    ARRAY['Dominio em Figma', 'Experiencia comprovada em UX', 'Pensamento centrado no usuario', 'Portfolio atual'],
    'Descomplicar o acesso a servicos financeiros.',
    'Ser lider global em experiencia financeira digital.',
    'Simplicidade, etica, foco no usuario e transparencia.',
    'Rua das Laranjeiras, 250 - Rio de Janeiro',
    ARRAY[
        'O Nubank e uma das principais fintechs do mundo e nasceu com a proposta de transformar a relacao das pessoas com o dinheiro, eliminando burocracias e oferecendo servicos simples e acessiveis. Nossos times trabalham com foco absoluto na experiencia do usuario.',
        'O ambiente e altamente colaborativo, com profissionais de tecnologia e design trabalhando juntos para criar solucoes inclusivas, intuitivas e seguras. A cultura forte valoriza autonomia e incentiva experimentacao constante.'
    ],
    ARRAY[
        'O Nubank aposta em inovacao continua, promovendo testes, validacoes e pesquisas frequentes para garantir que cada produto entregue gere impacto real na vida de milhoes de usuarios.',
        'A empresa incentiva diversidade e inclusao, garantindo que diferentes perspectivas participem da construcao de solucoes mais humanas e eficientes. Aqui, o design tem papel estrategico no desenvolvimento da empresa.'
    ]
),
(
    3,
    'Tech Lead',
    'Lideranca tecnica de squads ageis e tomada de decisoes arquiteturais.',
    'Banco do Bradesco',
    'Belo Horizonte',
    'CLT',
    18000.00,
    'INTERVIEWING',
    2,
    'Salario CLT com bonus anual, VR, VA e previdencia privada.',
    'Liderar squad de engenharia e suportar definicoes de arquitetura.',
    ARRAY['Guiar decisoes tecnicas', 'Mentorar equipe', 'Participar de arquitetura corporativa', 'Garantir boas praticas'],
    ARRAY['Experiencia comprovada com lideranca tecnica', 'Conhecimento avancado em backend', 'DevOps e CI/CD', 'Metodologias ageis'],
    'Apoiar o crescimento financeiro do pais por meio da tecnologia.',
    'Ser o banco mais inovador e digital do Brasil.',
    'Responsabilidade, etica, seguranca e colaboracao.',
    'Av. Afonso Pena, 700 - Belo Horizonte',
    ARRAY[
        'O Bradesco e um dos maiores bancos do Brasil e um dos lideres em transformacao digital no setor financeiro. Com alto investimento em tecnologia, busca melhorar a experiencia dos milhoes de clientes por meio de solucoes eficientes e seguras.',
        'Ao integrar o time de tecnologia, o profissional participa de projetos estrategicos que envolvem modernizacao de sistemas, arquitetura escalavel, seguranca avancada e automacao de processos.'
    ],
    ARRAY[
        'A instituicao valoriza responsabilidade, colaboracao e inovacao continua, oferecendo ambiente seguro e estruturado para desenvolvimento profissional.',
        'A cultura incentiva o aprendizado constante e a participacao ativa de cada colaborador na criacao de solucoes que ajudam a transformar o cenario financeiro brasileiro.'
    ]
),
(
    4,
    'Estagiario de QA',
    'Testes manuais, automacao basica e documentacao de evidencias.',
    'Arcell Mital',
    'Curitiba',
    'Estagio',
    2500.00,
    'CLOSED',
    3,
    'Bolsa estagio + VT + possibilidade de efetivacao.',
    'Apoiar rotinas de testes em produtos de alta complexidade.',
    ARRAY['Executar testes', 'Criar cenarios simples', 'Documentar bugs', 'Analisar requisitos'],
    ARRAY['Estar cursando TI', 'Conhecimentos basicos de testes', 'Organizacao e atencao aos detalhes'],
    'Criar produtos industriais de alto padrao.',
    'Ser lider global em tecnologia industrial e inovacao.',
    'Compromisso, seguranca, responsabilidade e qualidade.',
    'Rua XV de Novembro, 90 - Curitiba',
    ARRAY[
        'A ArcelorMittal e lider mundial na producao de aço e referencia em inovacao industrial. Com forte presenca no Brasil, a empresa atua em diferentes setores, incluindo construcao civil, automotivo e mineracao.',
        'A companhia investe constantemente em automacao, seguranca e desenvolvimento de novos talentos, oferecendo oportunidades reais de crescimento para profissionais que desejam atuar em ambientes modernos.'
    ],
    ARRAY[
        'O ambiente e marcado pela colaboracao entre equipes multidisciplinares e pelo foco em melhoria continua. A empresa valoriza profissionais analiticos e comprometidos com entregas de alta qualidade.',
        'Estagiarios tem contato direto com tecnologias reais e processos industriais complexos, desenvolvendo habilidades tecnicas e comportamentais essenciais para carreira na area.'
    ]
),
(
    5,
    'Desenvolvedor Frontend Pleno',
    'Desenvolvimento de interfaces escalaveis utilizando React e Next.js em produtos de grande demanda.',
    'Stone',
    'Sao Paulo',
    'CLT',
    9000.00,
    'OPEN',
    1,
    'Faixa salarial de pleno + VR, VA, plano de saude, bonus anual.',
    'Participacao em plataformas de grande escala e alta disponibilidade.',
    ARRAY['Criar componentes reutilizaveis', 'Consumir APIs', 'Implementar acessibilidade', 'Melhorar performance'],
    ARRAY['React avancado', 'Next.js', 'Git', 'CSS moderno', 'APIs REST'],
    'Impulsionar negocios utilizando tecnologia.',
    'Ser referencia nacional em solucoes de pagamento e servicos financeiros.',
    'Cliente em primeiro lugar, autonomia, confianca e responsabilidade.',
    'Rua dos Pinheiros, 650 - Sao Paulo',
    ARRAY[
        'A Stone e uma empresa de tecnologia e servicos financeiros que ajuda empreendedores de todo o Brasil a crescer. Com solucoes de pagamento modernas e robustas, impacta milhoes de clientes diariamente.',
        'A empresa possui forte cultura de autonomia e responsabilidade, com equipes multidisciplinares que utilizam tecnologias de ponta para desenvolver produtos escalaveis.'
    ],
    ARRAY[
        'Os profissionais tem liberdade para testar ideias e atuar diretamente na evolucao dos produtos. O ambiente e dinamico, acelerado e orientado a resolucao de problemas.',
        'A Stone valoriza um time forte e colaborativo, e trabalha para garantir que cada pessoa tenha condicoes de crescer e assumir novos desafios constantemente.'
    ]
),
(
    6,
    'Cientista de Dados',
    'Modelagem estatistica, machine learning e analise de dados para produtos de grande escala.',
    'iFood',
    'Campinas',
    'Estagio',
    15000.00,
    'OPEN',
    2,
    'Salario compativel com o mercado + bonus de resultado.',
    'Atuacao com times de dados focados em impacto real.',
    ARRAY['Criar modelos preditivos', 'Trabalhar com big data', 'Analisar KPIs', 'Automatizar pipelines'],
    ARRAY['Python avancado', 'SQL', 'Machine Learning', 'Estatistica', 'Versionamento'],
    'Transformar o delivery por meio de tecnologia.',
    'Expandir globalmente utilizando IA e inovacao continua.',
    'Velocidade, inovacao, responsabilidade e diversidade.',
    'Av. Norte-Sul, 1500 - Campinas',
    ARRAY[
        'O iFood e a maior plataforma de delivery da America Latina e lider em inovacao no setor. A empresa utiliza inteligencia artificial e dados em larga escala para otimizar entregas, consumo e logistica.',
        'Os times de tecnologia trabalham com ambientes altamente complexos e modernos, desenvolvendo modelos e plataformas que processam milhoes de eventos diariamente.'
    ],
    ARRAY[
        'A cultura do iFood incentiva aprendizado constante, experimentacao e uso intensivo de dados para tomada de decisoes.',
        'Quem entra para o time acessa um ecossistema tecnologico avancado, com oportunidades reais de crescimento e participacao em solucoes de alto impacto social e economico.'
    ]
),
(
    7,
    'Analista de Suporte Tecnico',
    'Atendimento N2, automacao de rotinas e suporte a clientes corporativos.',
    'Totvs',
    'Rio de Janeiro',
    'Pessoa Juridica',
    4500.00,
    'OPEN',
    3,
    'Contrato PJ com horario flexivel + suporte de infraestrutura.',
    'Atuacao em sistemas corporativos de grande escala.',
    ARRAY['Atender chamados', 'Criar scripts', 'Documentar processos', 'Suporte a ERP'],
    ARRAY['Infraestrutura', 'Linux', 'SQL basico', 'Boa comunicacao'],
    'Digitalizar empresas brasileiras.',
    'Ser a maior referencia em software de gestao do pais.',
    'Excelencia, etica, responsabilidade e qualidade.',
    'Rua Barao de Mesquita, 40 - Rio de Janeiro',
    ARRAY[
        'A TOTVS e lider nacional em desenvolvimento de sistemas de gestao e atua auxiliando empresas de diversos segmentos a modernizarem seus processos. Com presenca em todo o pais, oferece solucoes completas para organizacoes de diferentes portes.',
        'A empresa investe continuamente em inovacao, automacao e tecnologia de ponta para entregar plataformas robustas, seguras e eficientes, impactando milhares de clientes corporativos.'
    ],
    ARRAY[
        'O ambiente incentiva autonomia, colaboracao e aprendizado continuo. Os profissionais tem contato com tecnologias modernas e desafios reais em ambientes de missao critica.',
        'A TOTVS oferece oportunidades concretas de desenvolvimento e crescimento, valorizando profissionais comprometidos com excelencia e evolucao tecnica.'
    ]
),
(
    8,
    'Scrum Master',
    'Facilitacao de ceremonias ageis, desenvolvimento de metricas e remocao de impedimentos.',
    'Mercado Livre',
    'Porto Alegre',
    'Jovem Aprendiz',
    11000.00,
    'INTERVIEWING',
    1,
    'Remuneracao com bonus trimestral + ambiente de alto impacto.',
    'Atuacao em squads que utilizam metodologias ageis avancadas.',
    ARRAY['Facilitar reunioes', 'Apoiar squads', 'Gerenciar impedimentos', 'Mensurar metricas ageis'],
    ARRAY['Scrum', 'Kanban', 'Comunicacao clara', 'Lideranca servidora'],
    'Potencializar o comercio digital na America Latina.',
    'Expandir globalmente por meio de tecnologia de ponta.',
    'Agilidade, abertura, colaboracao e inclusao.',
    'Av. Ipiranga, 2000 - Porto Alegre',
    ARRAY[
        'O Mercado Livre e lider em e-commerce na America Latina e referencia internacional em inovacao, tecnologia e operacoes logisticas de grande escala. Seu ecossistema digital conecta milhoes de usuarios e empreendedores diariamente.',
        'As equipes trabalham com autonomia e foco em entregar solucoes rapidas, seguras e escalaveis que impactam de maneira significativa a economia digital do continente.'
    ],
    ARRAY[
        'A cultura da empresa valoriza agilidade, liberdade e colaboracao. Profissionais sao incentivados a testar ideias, experimentar abordagens novas e utilizar dados para tomar decisoes estrategicas.',
        'Aqui, cada colaborador tem a chance de contribuir para plataformas de altissimo impacto, utilizando tecnologia moderna e boas praticas de desenvolvimento agil.'
    ]
);


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
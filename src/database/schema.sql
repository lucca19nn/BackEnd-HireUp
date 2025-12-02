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
    company_mission, company_vision, company_values, address,
    company_description, company_overview
) VALUES 
(
    'Desenvolvedor Backend Senior',
    'Experiência sólida com Node.js, PostgreSQL, Docker e arquitetura escalável. Atuação em sistemas distribuídos e aplicações de alta performance.',
    'High Tech',
    'Sao Paulo',
    'CLT',
    12000.00,
    'OPEN',
    1,
    'Faixa salarial compatível com sênior, incluindo VR, VA, plano de saúde e bônus anual.',
    'Profissional experiente para atuar na criação e manutenção de serviços escaláveis.',
    ARRAY['Criar APIs robustas', 'Gerenciar banco PostgreSQL', 'Implementar testes automatizados', 'Participar de decisões arquiteturais'],
    ARRAY['5+ anos de experiência', 'Node.js avançado', 'SQL avançado', 'Docker e CI/CD', 'Experiência com microsserviços'],
    'Inovar soluções tecnológicas e criar produtos digitais de alto impacto.',
    'Ser referência nacional na criação de plataformas escaláveis e inteligentes.',
    'Transparência, inovação, colaboração e respeito.',
    'Avenida Paulista, 1000 - São Paulo',
    ARRAY[
        'A High Tech é uma empresa focada no desenvolvimento de soluções digitais avançadas, atendendo clientes de diversos segmentos que buscam tecnologia de ponta. Nossos produtos são desenvolvidos com foco em escalabilidade, segurança e eficiência, permitindo que empresas cresçam de forma estruturada.',
        'Trabalhamos com uma cultura forte de colaboração, onde os times são incentivados a compartilhar conhecimento, explorar novas tecnologias e participar de decisões importantes. Aqui, cada profissional tem autonomia para influenciar diretamente a evolução dos sistemas.'
    ],
    ARRAY[
        'Nossa equipe opera com metodologias ágeis, promovendo ciclos rápidos de entrega e validação. Incentivamos a pesquisa e desenvolvimento contínuo para garantir que nossas soluções estejam sempre alinhadas às melhores práticas do mercado.',
        'A High Tech oferece um ambiente moderno, com foco em aprendizado constante e liberdade para propor novas ideias. Valorizamos profissionais criativos que queiram participar da construção de plataformas que impactam milhares de usuários.'
    ]
),
(
    'Designer UX/UI',
    'Desenvolvimento de interfaces intuitivas e centradas no usuário, utilizando Figma, protótipo de alta fidelidade e testes de usabilidade.',
    'Nubank',
    'Rio de Janeiro',
    'PJ',
    8500.50,
    'OPEN',
    1,
    'Pagamento mensal via contrato PJ + benefícios flexíveis.',
    'Criação de experiências visuais que melhorem a jornada do usuário.',
    ARRAY['Criar protótipos', 'Conduzir pesquisas', 'Realizar testes de usabilidade', 'Trabalhar com times multidisciplinares'],
    ARRAY['Domínio em Figma', 'Experiência comprovada em UX', 'Pensamento centrado no usuário', 'Portfólio atual'],
    'Descomplicar o acesso a serviços financeiros.',
    'Ser líder global em experiência financeira digital.',
    'Simplicidade, ética, foco no usuário e transparência.',
    'Rua das Laranjeiras, 250 - Rio de Janeiro',
    ARRAY[
        'O Nubank é uma das principais fintechs do mundo e nasceu com a proposta de transformar a relação das pessoas com o dinheiro, eliminando burocracias e oferecendo serviços simples e acessíveis. Nossos times trabalham com foco absoluto na experiência do usuário.',
        'O ambiente é altamente colaborativo, com profissionais de tecnologia e design trabalhando juntos para criar soluções inclusivas, intuitivas e seguras. A cultura forte valoriza autonomia e incentiva experimentação constante.'
    ],
    ARRAY[
        'O Nubank aposta em inovação contínua, promovendo testes, validações e pesquisas frequentes para garantir que cada produto entregue gere impacto real na vida de milhões de usuários.',
        'A empresa incentiva diversidade e inclusão, garantindo que diferentes perspectivas participem da construção de soluções mais humanas e eficientes. Aqui, o design tem papel estratégico no desenvolvimento da empresa.'
    ]
),
(
    'Tech Lead',
    'Liderança técnica de squads ágeis e tomada de decisões arquiteturais.',
    'Banco do Bradesco',
    'Belo Horizonte',
    'CLT',
    18000.00,
    'INTERVIEWING',
    2,
    'Salário CLT com bônus anual, VR, VA e previdência privada.',
    'Liderar squad de engenharia e suportar definições de arquitetura.',
    ARRAY['Guiar decisões técnicas', 'Mentorar equipe', 'Participar de arquitetura corporativa', 'Garantir boas práticas'],
    ARRAY['Experiência comprovada com liderança técnica', 'Conhecimento avançado em backend', 'DevOps e CI/CD', 'Metodologias ágeis'],
    'Apoiar o crescimento financeiro do país por meio da tecnologia.',
    'Ser o banco mais inovador e digital do Brasil.',
    'Responsabilidade, ética, segurança e colaboração.',
    'Av. Afonso Pena, 700 - Belo Horizonte',
    ARRAY[
        'O Bradesco é um dos maiores bancos do Brasil e um dos líderes em transformação digital no setor financeiro. Com alto investimento em tecnologia, busca melhorar a experiência dos milhões de clientes por meio de soluções eficientes e seguras.',
        'Ao integrar o time de tecnologia, o profissional participa de projetos estratégicos que envolvem modernização de sistemas, arquitetura escalável, segurança avançada e automação de processos.'
    ],
    ARRAY[
        'A instituição valoriza responsabilidade, colaboração e inovação contínua, oferecendo ambiente seguro e estruturado para desenvolvimento profissional.',
        'A cultura incentiva o aprendizado constante e a participação ativa de cada colaborador na criação de soluções que ajudam a transformar o cenário financeiro brasileiro.'
    ]
),
(
    'Estagiario de QA',
    'Testes manuais, automação básica e documentação de evidências.',
    'Arcell Mital',
    'Curitiba',
    'Estagio',
    2500.00,
    'CLOSED',
    3,
    'Bolsa estágio + VT + possibilidade de efetivação.',
    'Apoiar rotinas de testes em produtos de alta complexidade.',
    ARRAY['Executar testes', 'Criar cenários simples', 'Documentar bugs', 'Analisar requisitos'],
    ARRAY['Estar cursando TI', 'Conhecimentos básicos de testes', 'Organização e atenção aos detalhes'],
    'Criar produtos industriais de alto padrão.',
    'Ser líder global em tecnologia industrial e inovação.',
    'Compromisso, segurança, responsabilidade e qualidade.',
    'Rua XV de Novembro, 90 - Curitiba',
    ARRAY[
        'A ArcelorMittal é líder mundial na produção de aço e referência em inovação industrial. Com forte presença no Brasil, a empresa atua em diferentes setores, incluindo construção civil, automotivo e mineração.',
        'A companhia investe constantemente em automação, segurança e desenvolvimento de novos talentos, oferecendo oportunidades reais de crescimento para profissionais que desejam atuar em ambientes modernos.'
    ],
    ARRAY[
        'O ambiente é marcado pela colaboração entre equipes multidisciplinares e pelo foco em melhoria contínua. A empresa valoriza profissionais analíticos e comprometidos com entregas de alta qualidade.',
        'Estagiários têm contato direto com tecnologias reais e processos industriais complexos, desenvolvendo habilidades técnicas e comportamentais essenciais para carreira na área.'
    ]
),
(
    'Desenvolvedor Frontend Pleno',
    'Desenvolvimento de interfaces escaláveis utilizando React e Next.js em produtos de grande demanda.',
    'Stone',
    'Sao Paulo',
    'CLT',
    9000.00,
    'OPEN',
    1,
    'Faixa salarial de pleno + VR, VA, plano de saúde, bônus anual.',
    'Participação em plataformas de grande escala e alta disponibilidade.',
    ARRAY['Criar componentes reutilizáveis', 'Consumir APIs', 'Implementar acessibilidade', 'Melhorar performance'],
    ARRAY['React avançado', 'Next.js', 'Git', 'CSS moderno', 'APIs REST'],
    'Impulsionar negócios utilizando tecnologia.',
    'Ser referência nacional em soluções de pagamento e serviços financeiros.',
    'Cliente em primeiro lugar, autonomia, confiança e responsabilidade.',
    'Rua dos Pinheiros, 650 - São Paulo',
    ARRAY[
        'A Stone é uma empresa de tecnologia e serviços financeiros que ajuda empreendedores de todo o Brasil a crescer. Com soluções de pagamento modernas e robustas, impacta milhões de clientes diariamente.',
        'A empresa possui forte cultura de autonomia e responsabilidade, com equipes multidisciplinares que utilizam tecnologias de ponta para desenvolver produtos escaláveis.'
    ],
    ARRAY[
        'Os profissionais têm liberdade para testar ideias e atuar diretamente na evolução dos produtos. O ambiente é dinâmico, acelerado e orientado à resolução de problemas.',
        'A Stone valoriza um time forte e colaborativo, e trabalha para garantir que cada pessoa tenha condições de crescer e assumir novos desafios constantemente.'
    ]
),
(
    'Cientista de Dados',
    'Modelagem estatística, machine learning e análise de dados para produtos de grande escala.',
    'iFood',
    'Campinas',
    'Estágio',
    15000.00,
    'OPEN',
    2,
    'Salário compatível com o mercado + bônus de resultado.',
    'Atuação com times de dados focados em impacto real.',
    ARRAY['Criar modelos preditivos', 'Trabalhar com big data', 'Analisar KPIs', 'Automatizar pipelines'],
    ARRAY['Python avançado', 'SQL', 'Machine Learning', 'Estatística', 'Versionamento'],
    'Transformar o delivery por meio de tecnologia.',
    'Expandir globalmente utilizando IA e inovação contínua.',
    'Velocidade, inovação, responsabilidade e diversidade.',
    'Av. Norte-Sul, 1500 - Campinas',
    ARRAY[
        'O iFood é a maior plataforma de delivery da América Latina e líder em inovação no setor. A empresa utiliza inteligência artificial e dados em larga escala para otimizar entregas, consumo e logística.',
        'Os times de tecnologia trabalham com ambientes altamente complexos e modernos, desenvolvendo modelos e plataformas que processam milhões de eventos diariamente.'
    ],
    ARRAY[
        'A cultura do iFood incentiva aprendizado constante, experimentação e uso intensivo de dados para tomada de decisões.',
        'Quem entra para o time acessa um ecossistema tecnológico avançado, com oportunidades reais de crescimento e participação em soluções de alto impacto social e econômico.'
    ]
),
(
    'Analista de Suporte Tecnico',
    'Atendimento N2, automação de rotinas e suporte a clientes corporativos.',
    'Totvs',
    'Rio de Janeiro',
    'Pessoa Jurídica',
    4500.00,
    'OPEN',
    3,
    'Contrato PJ com horário flexível + suporte de infraestrutura.',
    'Atuação em sistemas corporativos de grande escala.',
    ARRAY['Atender chamados', 'Criar scripts', 'Documentar processos', 'Suporte a ERP'],
    ARRAY['Infraestrutura', 'Linux', 'SQL básico', 'Boa comunicação'],
    'Digitalizar empresas brasileiras.',
    'Ser a maior referência em software de gestão do país.',
    'Excelência, ética, responsabilidade e qualidade.',
    'Rua Barão de Mesquita, 40 - Rio de Janeiro',
    ARRAY[
        'A TOTVS é líder nacional em desenvolvimento de sistemas de gestão e atua auxiliando empresas de diversos segmentos a modernizarem seus processos. Com presença em todo o país, oferece soluções completas para organizações de diferentes portes.',
        'A empresa investe continuamente em inovação, automação e tecnologia de ponta para entregar plataformas robustas, seguras e eficientes, impactando milhares de clientes corporativos.'
    ],
    ARRAY[
        'O ambiente incentiva autonomia, colaboração e aprendizado contínuo. Os profissionais têm contato com tecnologias modernas e desafios reais em ambientes de missão crítica.',
        'A TOTVS oferece oportunidades concretas de desenvolvimento e crescimento, valorizando profissionais comprometidos com excelência e evolução técnica.'
    ]
),
(
    'Scrum Master',
    'Facilitação de cerimônias ágeis, desenvolvimento de métricas e remoção de impedimentos.',
    'Mercado Livre',
    'Porto Alegre',
    'Jovem Aprendiz',
    11000.00,
    'INTERVIEWING',
    1,
    'Remuneração com bônus trimestral + ambiente de alto impacto.',
    'Atuação em squads que utilizam metodologias ágeis avançadas.',
    ARRAY['Facilitar reuniões', 'Apoiar squads', 'Gerenciar impedimentos', 'Mensurar métricas ágeis'],
    ARRAY['Scrum', 'Kanban', 'Comunicação clara', 'Liderança servidora'],
    'Potencializar o comércio digital na América Latina.',
    'Expandir globalmente por meio de tecnologia de ponta.',
    'Agilidade, abertura, colaboração e inclusão.',
    'Av. Ipiranga, 2000 - Porto Alegre',
    ARRAY[
        'O Mercado Livre é líder em e-commerce na América Latina e referência internacional em inovação, tecnologia e operações logísticas de grande escala. Seu ecossistema digital conecta milhões de usuários e empreendedores diariamente.',
        'As equipes trabalham com autonomia e foco em entregar soluções rápidas, seguras e escaláveis que impactam de maneira significativa a economia digital do continente.'
    ],
    ARRAY[
        'A cultura da empresa valoriza agilidade, liberdade e colaboração. Profissionais são incentivados a testar ideias, experimentar abordagens novas e utilizar dados para tomar decisões estratégicas.',
        'Aqui, cada colaborador tem a chance de contribuir para plataformas de altíssimo impacto, utilizando tecnologia moderna e boas práticas de desenvolvimento ágil.'
    ]
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
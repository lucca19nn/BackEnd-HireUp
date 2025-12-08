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
    company_description TEXT[],
    company_overview TEXT[],
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
),
(
    9,
    'Desenvolvedor Fullstack Pleno',
    'Atuacao em sistemas de grande porte utilizando Node.js, React, microservicos e arquitetura limpa. Responsavel por entregar features completas e colaborar com squads multidisciplinares.',
    'CI&T',
    'Campinas',
    'CLT',
    10500.00,
    'OPEN',
    2,
    'Salario competitivo + VR + VA + PLR + apoio educacional.',
    'Atuar em solucoes digitais escalaveis com foco em performance e qualidade.',
    ARRAY['Desenvolver APIs', 'Criar interfaces responsivas', 'Participar de code reviews', 'Implementar testes'],
    ARRAY['React', 'Node.js', 'Docker', 'Arquitetura limpa', 'Git'],
    'Transformar empresas por meio de tecnologia e alta performance.',
    'Ser referencia global em transformacao digital.',
    'Colaboracao, aprendizado continuo, excelencia e respeito.',
    'Rodovia Dom Pedro I, 300 - Campinas',
    ARRAY[
        'A CI&T e lider em transformacao digital e trabalha com empresas globais entregando produtos inovadores. Focada em performance, qualidade e agilidade, utiliza metodologias modernas e times altamente especializados.',
        'O ambiente favorece troca de conhecimento, autonomia e envolvimento direto com desafios reais em escala global.'
    ],
    ARRAY[
        'A empresa incentiva evolucao tecnica e oferece plano de carreira estruturado para profissionais de tecnologia.',
        'Os squads trabalham com cultura de dados, entregas rapidas e alta colaboracao entre diferentes areas.'
    ]
),
(
    10,
    'Product Owner',
    'Responsavel por backlog, discovery, contexto de negocio e alinhamento entre stakeholders.',
    'PicPay',
    'Vitoria',
    'CLT',
    13800.00,
    'OPEN',
    1,
    'Salario CLT + bonus anual + auxilio home office.',
    'Gerenciar backlog e entregar valor continuo ao usuario.',
    ARRAY['Refinar backlog', 'Conduzir discovery', 'Acompanhar KPIs', 'Priorizar entregas'],
    ARRAY['PO experiente', 'Conhecimento de UX', 'Agile', 'Boa comunicacao'],
    'Simplificar transacoes financeiras para milhoes de pessoas.',
    'Ser lider em pagamentos digitais na America Latina.',
    'Inovacao, transparencia, autonomia e foco no cliente.',
    'Av. Nossa Senhora da Penha, 1400 - Vitoria',
    ARRAY[
        'O PicPay e uma das maiores plataformas de pagamento do Brasil, atuando com produtos digitais de alto impacto e usuario no centro.',
        'A cultura da empresa incentiva autonomia, ownership e inovacao continua, valorizando profissionais estrategicos.'
    ],
    ARRAY[
        'Os times trabalham com agilidade, orientacao a dados e foco em resultados de negocio.',
        'Profissionais participam ativamente da evolucao dos produtos e da experiencia do cliente.'
    ]
),
(
    11,
    'Engenheiro de Software Mobile',
    'Desenvolvimento de aplicativos mobile de grande escala utilizando React Native e integrações com APIs modernas.',
    'Magazine Luiza',
    'Franca',
    'CLT',
    14000.00,
    'OPEN',
    3,
    'Salario competitivo + PLR + plano de saude + beneficios internos.',
    'Construir apps performaticos para milhoes de usuarios.',
    ARRAY['Criar apps mobile', 'Implementar integrações', 'Melhorar performance', 'Participar de arquiteturas modernas'],
    ARRAY['React Native', 'TypeScript', 'APIs REST', 'Git'],
    'Transformar o varejo brasileiro por meio da tecnologia.',
    'Ser a maior plataforma digital de varejo da America Latina.',
    'Cliente em primeiro lugar, colaboracao e protagonismo.',
    'Av. Severino Tostes, 900 - Franca',
    ARRAY[
        'O Magalu se tornou uma das empresas mais tecnologicas do Brasil, investindo fortemente em digitalizacao e experiencia mobile.',
        'O ambiente estimula autonomia, aprendizado continuo e inovacao para escalar produtos com milhoes de acessos diarios.'
    ],
    ARRAY[
        'A cultura valoriza criatividade, responsabilidade e tomada de decisao baseada em dados.',
        'Profissionais atuam diretamente em produtos que definem o futuro do varejo digital.'
    ]
),
(
    12,
    'Administrador de Banco de Dados (DBA)',
    'Gerenciamento de ambientes PostgreSQL, SQL Server e MySQL com foco em segurança, disponibilidade e performance.',
    'SICOOB',
    'Brasilia',
    'CLT',
    15000.00,
    'OPEN',
    1,
    'Salario CLT + previdencia + auxilio educacional + VR.',
    'Garantir alta disponibilidade e performance de bancos de dados.',
    ARRAY['Monitorar BD', 'Criar rotinas de backup', 'Otimizar queries', 'Gerenciar seguranca'],
    ARRAY['PostgreSQL', 'SQL Server', 'Shell Script', 'Infraestrutura'],
    'Impulsionar cooperados por meio de tecnologia e servicos financeiros.',
    'Ser o maior sistema de cooperativas do Brasil.',
    'Cooperacao, confianca e responsabilidade.',
    'Setor Bancario Norte, Quadra 5 - Brasilia',
    ARRAY[
        'O Sicoob atua com sistemas financeiros robustos e de alta criticidade, exigindo profissionais altamente especializados.',
        'A empresa investe em inovacao e modernizacao de ambientes corporativos, com foco em seguranca e escabilidade.'
    ],
    ARRAY[
        'O ambiente e colaborativo e valoriza crescimento continuo.',
        'Profissionais participam de projetos de transformacao digital que impactam milhares de cooperados.'
    ]
),
(
    13,
    'Engenheiro DevOps',
    'Construção e manutenção de pipelines CI/CD, automação de infraestrutura e observabilidade.',
    'XP Inc.',
    'São Paulo',
    'Pessoa Juridica',
    16000.00,
    'OPEN',
    2,
    'Contrato PJ + beneficios flexiveis + auxilio educacional.',
    'Atuar com automacao e infraestrutura escalavel.',
    ARRAY['Criar pipelines', 'Gerenciar Kubernetes', 'Monitorar aplicacoes', 'Automatizar processos'],
    ARRAY['AWS', 'Docker', 'Kubernetes', 'Terraform', 'CI/CD'],
    'Transformar o mercado financeiro com tecnologia.',
    'Ser maior plataforma de investimentos da America Latina.',
    'Transparencia, responsabilidade, foco no cliente.',
    'Av. Brigadeiro Faria Lima, 4000 - Sao Paulo',
    ARRAY[
        'A XP e referencia em tecnologia financeira, com sistemas que precisam operar em alta disponibilidade.',
        'Times trabalham com engenharia de ponta e cultura forte de automacao, testes e observabilidade.'
    ],
    ARRAY[
        'A empresa estimula autonomia, inovacao e aprendizado continuo.',
        'Profissionais atuam em ambientes complexos com grande volume de dados e transacoes.'
    ]
),
(
    14,
    'Analista de Marketing Digital',
    'Gestão de campanhas, criacao de conteudo e analise de performance.',
    'Hotmart',
    'Belo Horizonte',
    'CLT',
    7200.00,
    'OPEN',
    3,
    'Salario CLT + PLR + apoio educacional.',
    'Criar estrategias para aumentar conversao e engajamento.',
    ARRAY['Criar campanhas', 'Gerenciar redes sociais', 'Analisar métricas', 'Planejar conteudos'],
    ARRAY['Marketing', 'Copywriting', 'Google Ads', 'Meta Ads'],
    'Empoderar criadores de conteudo no mundo todo.',
    'Expandir globalmente com educacao digital.',
    'Cultura forte, inovação e transparencia.',
    'Av. Raja Gabaglia, 3000 - Belo Horizonte',
    ARRAY[
        'A Hotmart e uma das maiores plataformas de produtos digitais do mundo e conecta criadores e consumidores.',
        'O ambiente e dinamico e estimula criacao, autonomia e uso de dados para estrategias inteligentes.'
    ],
    ARRAY[
        'Profissionais tem acesso a ferramentas modernas e atuam diretamente em campanhas internacionais.',
        'A cultura valoriza diversidade, aprendizado continuo e inovacao.'
    ]
),
(
    15,
    'Arquiteto de Software',
    'Definir arquiteturas escalaveis, guiar squads e validar solucoes complexas.',
    'Banco Inter',
    'Belo Horizonte',
    'CLT',
    19500.00,
    'OPEN',
    1,
    'Salario CLT com PLR + beneficios premium.',
    'Atuar com arquitetura moderna e sistemas financeiros de alta criticidade.',
    ARRAY['Criar arquiteturas', 'Revisar codigo', 'Definir padroes', 'Mentorar squads'],
    ARRAY['Microservicos', 'Cloud AWS', 'Java', 'Node.js', 'Kubernetes'],
    'Transformar servicos financeiros com digitalizacao total.',
    'Ser um banco 100% digital e inovador.',
    'Transparencia, eficiencia, inovacao e foco no cliente.',
    'Av. Barbacena, 1200 - Belo Horizonte',
    ARRAY[
        'O Banco Inter e referencia em digitalizacao bancária e opera com alta disponibilidade e escalabilidade.',
        'A area de tecnologia trabalha com sistemas modernos, cultura de dados e foco extremo em performance.'
    ],
    ARRAY[
        'Profissionais sao incentivados a testar novas abordagens e propor solucoes inovadoras.',
        'O banco investe pesado em arquitetura moderna e experiencia digital.'
    ]
),
(
    16,
    'Analista Financeiro Pleno',
    'Gestao financeira, reconciliacao, planejamento e controle.',
    'Vale',
    'Belo Horizonte',
    'CLT',
    9800.00,
    'OPEN',
    3,
    'Salario CLT + plano de carreira + beneficios completos.',
    'Atuar com processos financeiros de grande complexidade.',
    ARRAY['Criar relatorios', 'Analisar fluxo de caixa', 'Controlar despesas', 'Conciliação de contas'],
    ARRAY['Excel avançado', 'Analise financeira', 'Raciocinio logico', 'Organizacao'],
    'Gerar valor sustentavel com mineracao responsavel.',
    'Ser lider global em mineracao com responsabilidade ambiental.',
    'Seguranca, sustentabilidade, etica e respeito.',
    'Av. Joao Pinheiro, 400 - Belo Horizonte',
    ARRAY[
        'A Vale e uma das maiores empresas de mineracao do mundo e opera com processos complexos e estruturados.',
        'A area financeira participa de decisoes estrategicas e processos robustos de governanca.'
    ],
    ARRAY[
        'A empresa valoriza profissionais analiticos, organizados e com capacidade de tomada de decisao.',
        'Ambiente com forte investimento em desenvolvimento profissional.'
    ]
),
(
    17,
    'Analista de Recursos Humanos',
    'Recrutamento, cultura interna, onboarding e gestao de clima organizacional.',
    'Google Brasil',
    'São Paulo',
    'CLT',
    17000.00,
    'OPEN',
    2,
    'Salario + beneficios premium + oportunidades globais.',
    'Atuar com RH estrategico e processos de alta complexidade.',
    ARRAY['Conduzir entrevistas', 'Gerenciar onboarding', 'Criar projetos de clima', 'Apoiar liderancas'],
    ARRAY['Comunicacao', 'Organizacao', 'People Analytics', 'RH generalista'],
    'Organizar as informacoes do mundo e tornalas acessiveis.',
    'Ser referencia global em inovacao e acessibilidade digital.',
    'Inclusao, diversidade, transparencia e inovacao.',
    'Av. Brigadeiro Faria Lima, 3900 - São Paulo',
    ARRAY[
        'O Google Brasil trabalha com cultura forte, inovacao e equipes multidisciplinares.',
        'A area de RH tem papel fundamental em apoiar talentos, liderancas e promover diversidade.'
    ],
    ARRAY[
        'A empresa incentiva desenvolvimento continuo e lideranca aberta.',
        'Profissionais atuam em projetos globais e ambientes altamente colaborativos.'
    ]
),
(
    18,
    'Analista de Dados Jr.',
    'Criacao de relatorios, dashboards, ETL e analise de indicadores para times internos.',
    'Loft',
    'São Paulo',
    'CLT',
    6200.00,
    'INTERVIEWING',
    1,
    'Salario + VR + VA + bônus anual + auxilio educacional.',
    'Apoiar áreas internas com insights e dados qualificAdos.',
    ARRAY['Criar dashboards', 'Analisar dados', 'Automatizar ETLs', 'Gerenciar KPIs'],
    ARRAY['SQL', 'Python', 'Power BI', 'Raciocinio logico'],
    'Transformar o mercado imobiliario brasileiro.',
    'Ser a maior plataforma de imoveis digitais do Brasil.',
    'Transparencia, eficiencia, responsabilidade e foco no cliente.',
    'Av. Paulista, 1800 - São Paulo',
    ARRAY[
        'A Loft atua com tecnologia e dados para modernizar o mercado imobiliario por meio de plataformas eficientes.',
        'A area de dados e essencial para tomada de decisao e criacao de solucoes inteligentes.'
    ],
    ARRAY[
        'O ambiente fomenta aprendizado rapido, autonomia e contato direto com tecnologias modernas.',
        'Profissionais participam da evolucao de produtos digitais com alto impacto social e economico.'
    ]
), 
(19,
 'Data Analyst',
 'Responsavel por analisar grandes volumes de dados, criar relatorios e apoiar decisoes estrategicas.',
 'DataWise',
 'São Paulo',
 'CLT',
 6800.00,
 'OPEN',
 1,
 'Salario compatível com o mercado, VR, VA, plano de saúde e PLR.',
 'Analista para atuar com dados estruturados e não estruturados.',
 ARRAY['Construir dashboards', 'Analisar grandes bases de dados', 'Criar relatorios gerenciais', 'Apoiar times estratégicos'],
 ARRAY['SQL avançado', 'Power BI ou Tableau', 'Conhecimento de estatística', 'Boa comunicação'],
 'Transformar dados em inteligencia de negocio.',
 'Ser lider nacional em soluções baseadas em dados.',
 'Transparencia, analise crítica e inovação.',
 'Avenida Paulista, 1500 - São Paulo',
 ARRAY[
     'A DataWise é especializada em projetos de análise de dados e BI.',
     'Atuamos com empresas que buscam crescimento baseado em insights.'
 ],
 ARRAY[
     'Cultura orientada a dados e colaboração.',
     'Valorizamos profissionais analíticos e curiosos.'
]),

(20,
 'Backend Developer Node.js',
 'Desenvolvimento de APIs escaláveis em Node.js e integrações diversas.',
 'CloudBridge',
 'Remoto',
 'PJ',
 12000.00,
 'OPEN',
 2,
 'Contrato PJ com horário flexível e bônus por entrega.',
 'Desenvolvedor para atuar com microsserviços e arquiteturas distribuídas.',
 ARRAY['Construir APIs robustas', 'Integrar serviços externos', 'Criar testes automatizados', 'Apoiar decisões de arquitetura'],
 ARRAY['Node.js avançado', 'Docker', 'Bancos SQL e NoSQL', 'GitFlow'],
 'Construir soluções backend seguras e escaláveis.',
 'Ser referência em integrações cloud.',
 'Autonomia, inovação e qualidade.',
 'Remoto',
 ARRAY[
     'A CloudBridge desenvolve soluções de alta performance para empresas cloud native.',
     'Time 100% remoto e colaborativo.'
 ],
 ARRAY[
     'Cultura de ownership e entrega.',
     'Valorizamos desenvolvedores disciplinados e pró-ativos.'
]),

(21,
 'Inside Sales',
 'Atuar no atendimento, prospecção e conversão de leads.',
 'VendasPro',
 'Florianópolis',
 'CLT',
 3200.00,
 'OPEN',
 1,
 'Salário fixo + comissão agressiva + VR + bônus trimestral.',
 'Vendedor interno com foco em metas e follow-up contínuo.',
 ARRAY['Realizar prospecção ativa', 'Atender leads inbound', 'Registrar atividades no CRM', 'Fechar vendas'],
 ARRAY['Boa comunicação', 'Experiência com vendas', 'Conhecimento de CRM', 'Persistência'],
 'Conectar clientes às melhores soluções de mercado.',
 'Ser referência nacional em vendas B2B.',
 'Transparência, disciplina e foco em resultados.',
 'Rua Rio Branco, 120 - Florianópolis',
 ARRAY[
     'A VendasPro atua com soluções B2B e processos comerciais estruturados.',
     'Equipe orientada a resultados e crescimento contínuo.'
 ],
 ARRAY[
     'Cultura de metas, colaboração e aprendizado.',
     'Buscamos profissionais motivados e comunicativos.'
]),

(22,
 'Full Stack Developer',
 'Atuar no desenvolvimento completo de aplicações web modernas.',
 'InfinityCode',
 'Remoto',
 'PJ',
 15000.00,
 'OPEN',
 2,
 'Contrato PJ com liberdade de horários, bônus por performance e trabalho remoto.',
 'Profissional para atuar tanto no front-end quanto no back-end da aplicação.',
 ARRAY['Criar interfaces web', 'Construir APIs', 'Integrar serviços', 'Aplicar boas práticas de código'],
 ARRAY['React', 'Node.js', 'Arquiteturas modernas', 'DevOps básico'],
 'Criar softwares completos e eficientes.',
 'Ser referência em desenvolvimento full stack.',
 'Qualidade, inovação e flexibilidade.',
 'Remoto',
 ARRAY[
     'A InfinityCode cria soluções completas para empresas globais.',
     'Foco em performance, escalabilidade e UX.'
 ],
 ARRAY[
     'Cultura flexível e orientada a resultados.',
     'Buscamos desenvolvedores que dominem o ciclo completo do produto.'
]),

(23,
 'Analista de RH',
 'Responsável por recrutamento, seleção e apoio às rotinas de RH.',
 'HumanGroup',
 'Recife',
 'CLT',
 3700.00,
 'OPEN',
 2,
 'Salário com VR, VT, plano de saúde e bônus anual.',
 'Profissional para atuar no RH em processos estruturados.',
 ARRAY['Conduzir entrevistas', 'Realizar triagens', 'Acompanhar onboarding', 'Organizar documentação'],
 ARRAY['Boa comunicação', 'Experiência em R&S', 'Conhecimento em avaliações comportamentais'],
 'Apoiar empresas na construção de equipes fortes.',
 'Ser referência em gestão de pessoas.',
 'Humanização, ética, desenvolvimento.',
 'Avenida Boa Viagem, 400 - Recife',
 ARRAY[
     'A HumanGroup atua com gestão de pessoas há mais de 10 anos.',
     'Foco em desenvolvimento humano e cultura organizacional.'
 ],
 ARRAY[
     'Ambiente colaborativo com foco em pessoas.',
     'Buscamos profissionais comunicativos e empáticos.'
]),

(24,
 'DevOps Engineer',
 'Automatização, pipelines, CI/CD e infraestrutura cloud.',
 'SkyDeploy',
 'Remoto',
 'PJ',
 17500.00,
 'OPEN',
 3,
 'Contrato PJ com bônus anual e apoio para certificações.',
 'Profissional para atuar em infraestrutura e automação.',
 ARRAY['Criar pipelines CI/CD', 'Gerenciar clusters Kubernetes', 'Automatizar processos', 'Monitorar aplicações'],
 ARRAY['Docker', 'Kubernetes', 'AWS ou GCP', 'Infra as Code'],
 'Acelerar entregas através de automação.',
 'Ser líder em soluções cloud-native.',
 'Automação, precisão e confiabilidade.',
 'Remoto',
 ARRAY[
     'A SkyDeploy atua com infraestrutura moderna e automação.',
     'Foco em estabilidade, escalabilidade e performance.'
 ],
 ARRAY[
     'Cultura altamente técnica e colaborativa.',
     'Buscamos engenheiros precisos e metódicos.'
]),

(25,
 'Gerente Comercial',
 'Gestão de equipe, metas, expansão e estratégia comercial.',
 'ComercialMax',
 'São Paulo',
 'CLT',
 13000.00,
 'OPEN',
 3,
 'Salário competitivo, comissão agressiva, bônus anual e benefícios completos.',
 'Gestor experiente para liderar área de vendas.',
 ARRAY['Gerir equipe', 'Definir metas', 'Treinar vendedores', 'Criar estratégias'],
 ARRAY['Experiência em liderança', 'Visão estratégica', 'Boa comunicação'],
 'Guiar equipes rumo ao crescimento.',
 'Ser referência em expansão comercial.',
 'Liderança, visão e compromisso.',
 'Rua das Acácias, 900 - São Paulo',
 ARRAY[
     'A ComercialMax atua no varejo em expansão nacional.',
     'Times com forte cultura de metas e resultado.'
 ],
 ARRAY[
     'Ambiente acelerado e competitivo.',
     'Buscamos líderes que inspirem e entreguem resultados.'
]),

(26,
 'QA Analyst',
 'Testes manuais e automatizados em aplicações web.',
 'QualityHub',
 'Curitiba',
 'CLT',
 5400.00,
 'OPEN',
 1,
 'Salário com VR, VT, plano médico e bônus mensal.',
 'Profissional para atuar garantindo qualidade do software.',
 ARRAY['Criar casos de teste', 'Executar testes', 'Automatizar cenários', 'Gerar relatórios'],
 ARRAY['Selenium', 'Postman', 'Conhecimento em APIs', 'Metodologias ágeis'],
 'Garantir qualidade e confiabilidade dos produtos.',
 'Ser referência em qualidade de software.',
 'Precisão, organização e excelência.',
 'Rua Marechal Deodoro, 300 - Curitiba',
 ARRAY[
     'A QualityHub é especializada em QA e testes.',
     'Times experientes e metodologia ágil.'
 ],
 ARRAY[
     'Cultura organizada e detalhista.',
     'Valorizamos analistas atentos e proativos.'
]),

(27,
 'Social Media',
 'Planejar e executar conteúdo para redes sociais.',
 'BuzzStudio',
 'Salvador',
 'CLT',
 3000.00,
 'OPEN',
 1,
 'Salário fixo, bônus, horário flexível e VR.',
 'Profissional criativo para atuar com conteúdo e engajamento.',
 ARRAY['Criar posts', 'Gerenciar calendário', 'Responder seguidores', 'Analisar métricas'],
 ARRAY['Experiência com redes sociais', 'Boa escrita', 'Conhecimento de métricas'],
 'Conectar marcas ao público.',
 'Ser referência em conteúdo digital.',
 'Criatividade, autenticidade e estratégia.',
 'Av. Tancredo Neves, 200 - Salvador',
 ARRAY[
     'A BuzzStudio trabalha com conteúdo relevante e de alto impacto.',
     'Equipe jovem e criativa.'
 ],
 ARRAY[
     'Cultura colaborativa e dinâmica.',
     'Valorizamos profissionais criativos e estratégicos.'
]),

(28,
 'Arquiteto de Software',
 'Responsável por definir arquitetura de alto nível em sistemas complexos.',
 'CodeStructure',
 'Remoto',
 'PJ',
 18500.00,
 'OPEN',
 3,
 'Contrato PJ com autonomia técnica total e bônus anual.',
 'Profissional para tomar decisões estruturais em produtos críticos.',
 ARRAY['Definir arquitetura', 'Escolher tecnologias', 'Guiar desenvolvedores', 'Revisar soluções'],
 ARRAY['Experiência sênior', 'Arquiteturas distribuídas', 'Cloud e microsserviços'],
 'Construir sistemas escaláveis e confiáveis.',
 'Ser referência em arquitetura moderna.',
 'Robustez, técnica e inovação.',
 'Remoto',
 ARRAY[
     'A CodeStructure atua com engenharia de software avançada.',
     'Projetos para empresas globais e ambientes críticos.'
 ],
 ARRAY[
     'Cultura técnica, forte e orientada a excelência.',
     'Buscamos arquitetos experientes e estratégicos.'
]),

(29,
 'Analista de Compras',
 'Gestão de compras, negociação e controle de fornecedores.',
 'SupplyOne',
 'Goiânia',
 'CLT',
 4800.00,
 'OPEN',
 2,
 'Salário, VR, plano de saúde e bônus trimestral.',
 'Profissional para atuar na área de suprimentos.',
 ARRAY['Negociar preços', 'Controlar pedidos', 'Avaliar fornecedores', 'Estruturar processos'],
 ARRAY['Boa negociação', 'Excel avançado', 'Organização', 'Experiência com compras'],
 'Otimizar custos e garantir bons fornecedores.',
 'Expandir redes de parceria eficientes.',
 'Responsabilidade, ética e organização.',
 'Rua T-63, 350 - Goiânia',
 ARRAY[
     'A SupplyOne atua com logística e suprimentos estratégicos.',
     'Foco em eficiência e processos sólidos.'
 ],
 ARRAY[
     'Ambiente organizado e processual.',
     'Buscamos analistas analíticos e ágeis.'
]),

(30,
 'Psicólogo Organizacional',
 'Atuar em clima organizacional, desenvolvimento e acompanhamento de equipes.',
 'MindCare',
 'Belo Horizonte',
 'CLT',
 6200.00,
 'OPEN',
 1,
 'Salário compatível com o mercado, VR, VT e plano de saúde.',
 'Profissional para atuar com desenvolvimento humano.',
 ARRAY['Realizar entrevistas', 'Conduzir programas internos', 'Aplicar questionários', 'Acompanhar lideranças'],
 ARRAY['Formação em Psicologia', 'Boa escuta', 'Experiência com DHO'],
 'Desenvolver pessoas e equipes.',
 'Ser referência em desenvolvimento humano.',
 'Empatia, crescimento e ética.',
 'Av. Cristiano Machado, 700 - Belo Horizonte',
 ARRAY[
     'A MindCare atua com desenvolvimento humano nas organizações.',
     'Times focados em bem-estar emocional e performance.'
 ],
 ARRAY[
     'Cultura humana, acolhedora e estratégica.',
     'Buscamos profissionais atentos ao comportamento humano.'
]),

(31,
 'Mobile Developer React Native',
 'Desenvolvimento de aplicativos mobile com React Native.',
 'AppMasters',
 'Remoto',
 'PJ',
 13000.00,
 'OPEN',
 1,
 'Contrato PJ com bônus por entrega e flexibilidade total.',
 'Atuar na construção de apps escaláveis.',
 ARRAY['Criar interfaces mobile', 'Consumir APIs', 'Publicar apps', 'Realizar manutenções'],
 ARRAY['React Native avançado', 'JavaScript e TypeScript', 'Git'],
 'Criar aplicações mobile modernas e performáticas.',
 'Ser referência em apps de alta performance.',
 'Qualidade, flexibilidade e eficiência.',
 'Remoto',
 ARRAY[
     'A AppMasters é especializada em apps modernos para clientes diversos.',
     'Foco em UX e performance.'
 ],
 ARRAY[
     'Cultura flexível e técnica.',
     'Valorizamos desenvolvedores disciplinados e criativos.'
]),

(32,
 'Auxiliar Administrativo',
 'Atuação em rotinas administrativas, atendimento e organização de documentos.',
 'OfficePlus',
 'Natal',
 'CLT',
 2100.00,
 'OPEN',
 2,
 'Salário, VT, VR e ambiente colaborativo.',
 'Profissional para apoiar rotinas internas.',
 ARRAY['Atender clientes', 'Organizar documentos', 'Controlar agendas', 'Apoiar processos internos'],
 ARRAY['Boa comunicação', 'Organização', 'Pacote Office'],
 'Apoiar a organização das operações internas.',
 'Ser líder regional em serviços administrativos.',
 'Responsabilidade, organização e profissionalismo.',
 'Rua Mossoró, 100 - Natal',
 ARRAY[
     'A OfficePlus é focada em serviços administrativos de qualidade.',
     'Equipe focada em eficiência e organização.'
 ],
 ARRAY[
     'Ambiente estável e colaborativo.',
     'Buscamos profissionais organizados e dedicados.'
]),

(33,
 'Coordenador de Projetos',
 'Coordenar equipes, prazos, escopo e qualidade em projetos multidisciplinares.',
 'PrimeProjects',
 'Rio de Janeiro',
 'CLT',
 9800.00,
 'OPEN',
 3,
 'Salário, bônus por entrega, plano de saúde e VR.',
 'Profissional experiente para liderar projetos.',
 ARRAY['Controlar escopo', 'Gerir equipes', 'Acompanhar entregas', 'Conduzir reuniões'],
 ARRAY['Gestão de projetos', 'Scrum/Kanban', 'Boa comunicação'],
 'Garantir entregas dentro do prazo e qualidade.',
 'Ser referência nacional em gestão de projetos.',
 'Organização, liderança e clareza.',
 'Av. Atlântica, 900 - Rio de Janeiro',
 ARRAY[
     'A PrimeProjects atua com gestão de projetos para empresas de grande porte.',
     'Foco em processos sólidos e lideranças fortes.'
 ],
 ARRAY[
     'Cultura organizada e orientada a metas.',
     'Buscamos líderes estratégicos e comunicativos.'
]);


INSERT INTO candidates (name, email, phone, linkedin_url, avatar_url, password, status) VALUES
('Lucas Oliveira', 'lucas.dev@email.com', '11999991111', 'linkedin.com/in/lucasdev', 'https://i.pravatar.cc/150?u=lucasdev', 'hash_123', 'Triagem'),
('Fernanda Costa', 'fernanda.design@email.com', '21988882222', 'linkedin.com/in/fernandaux', 'https://i.pravatar.cc/150?u=fernandaux', 'hash_456', 'Entrevista'),
('Joao Pedro', 'joao.pedro@email.com', '31977773333', 'linkedin.com/in/joaopedro', 'https://i.pravatar.cc/150?u=joaopedro', 'hash_789', 'Triagem'),
('Mariana Souza', 'mari.souza@email.com', '41966664444', 'linkedin.com/in/marisouza', 'https://i.pravatar.cc/150?u=marisouza', 'hash_abc', 'Aprovado');

INSERT INTO applications (job_id, candidate_id, status) VALUES 
(1, 1, 'INTERVIEW'),   
(1, 4, 'APPLIED'),     
(2, 2, 'HIRED'),       
(3, 1, 'REJECTED'),    
(4, 3, 'APPLIED');  

const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET; 

const protect = (req, res, next) => {
  let token;
  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
    try {
      token = req.headers.authorization.split(' ')[1];

      const decoded = jwt.verify(token, JWT_SECRET);

      req.user = { 
          id: decoded.userId,
          role: decoded.role 
      }; 

      next(); 
    } catch (error) {
      console.error('Erro na validação do token:', error.message);
      return res.status(401).json({ message: 'Não autorizado, token falhou.' });
    }
  }

  if (!token) {
    return res.status(401).json({ message: 'Não autorizado, nenhum token.' });
  }
};


const authorize = (...allowedRoles) => {
  return (req, res, next) => {
    if (!req.user || !req.user.role) {
        return res.status(403).json({ message: 'Acesso negado. Informação de usuário ausente.' });
    }

    if (allowedRoles.includes(req.user.role)) {
      next(); 
    } else {
      res.status(403).json({ message: 'Acesso negado. Você não tem a permissão necessária para esta ação.' });
    }
  };
};

module.exports = { protect, authorize };
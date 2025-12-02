const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const UserModel = require('../models/UserModel'); 

const JWT_SECRET = process.env.JWT_SECRET; 

exports.register = async (req, res) => {
  try {
    const { name, email, password, avatar_url } = req.body;

    if (!email || !password || !name) {
      return res.status(400).json({ message: 'Nome, e-mail e senha são obrigatórios.' });
    }

    const existingUser = await UserModel.findByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: 'Este e-mail já está em uso.' });
    }

    const saltRounds = 10; 
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    const newUser = { 
        name, 
        email, 
        password: hashedPassword,
        role: 'recruiter', 
        avatar_url 
    };
    
    const createdUser = await UserModel.create(newUser);

    const { password: _, ...userResponse } = createdUser; 

    res.status(201).json({ 
        message: 'Recrutador cadastrado com sucesso!', 
        user: userResponse 
    });
  } catch (error) {
    console.error('Erro no registro:', error);
    res.status(500).json({ message: 'Erro interno do servidor.', error: error.message });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await UserModel.findByEmail(email);
    if (!user) {
      return res.status(401).json({ message: 'Credenciais inválidas.' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Credenciais inválidas.' });
    }
    
    if (user.role !== 'recruiter' && user.role !== 'admin') {
    return res.status(403).json({ message: 'Acesso negado. Esta área é restrita a recrutadores e administradores.' });
}

    const token = jwt.sign(
      { 
        userId: user.id, 
        email: user.email,
        role: user.role 
      }, 
      JWT_SECRET, 
      { expiresIn: '1d' } 
    );

    res.status(200).json({ 
      message: 'Login realizado com sucesso!', 
      token: token,
      role: user.role,
      userId: user.id
  });

  } catch (error) {
    console.error('Erro no login:', error);
    res.status(500).json({ message: 'Erro interno do servidor.', error: error.message });
  }
};

exports.registerAdmin = async (req, res) => {
  try {
    const { name, email, password, admin_key } = req.body;

    if (admin_key !== process.env.ADMIN_CREATION_KEY) {
        return res.status(403).json({ message: 'Chave de administração incorreta. Acesso negado.' });
    }

    if (!email || !password || !name) {
      return res.status(400).json({ message: 'Nome, e-mail e senha são obrigatórios.' });
    }
    const existingUser = await UserModel.findByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: 'Este e-mail já está em uso.' });
    }

    const saltRounds = 10; 
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    
    const newUser = { 
        name, 
        email, 
        password: hashedPassword,
        role: 'admin',
        avatar_url: req.body.avatar_url 
    };
    
    const createdUser = await UserModel.create(newUser);
    
    const { password: _, ...userResponse } = createdUser; 

    res.status(201).json({ 
        message: 'Administrador cadastrado com sucesso!', 
        user: userResponse 
    });
  } catch (error) {
    console.error('Erro no registro de admin:', error);
    res.status(500).json({ message: 'Erro interno do servidor ao registrar admin.', error: error.message });
  }
};

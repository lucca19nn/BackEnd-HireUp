const express = require('express');
const router = express.Router();

const UserController = require('../controllers/UserController'); 
const AuthController = require('../controllers/AuthController'); 

const { protect, authorize } = require('../middlewares/authMiddleware');

router.post('/register', AuthController.register);
router.post('/login', AuthController.login);
router.post('/admin/register', AuthController.registerAdmin);
router.get('/', protect, authorize('admin'), UserController.getAll);
router.post('/', protect, authorize('admin'), UserController.create);
router.get('/:id', protect, UserController.getById);
router.put('/:id', protect, UserController.update); 
router.delete('/:id', protect, authorize('admin'), UserController.delete);

module.exports = router;
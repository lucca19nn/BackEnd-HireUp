const express = require('express');
const router = express.Router();
const JobController = require('../controllers/JobController');

router.get('/', JobController.getAll);          
router.post('/', JobController.create);        
router.get('/:id', JobController.getById);      
router.put('/:id', JobController.update);       
router.delete('/:id', JobController.delete);    

module.exports = router;
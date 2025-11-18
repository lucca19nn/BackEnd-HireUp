const express = require('express');
const router = express.Router();
const ApplicationController = require('../controllers/ApplicationController');

router.get('/', ApplicationController.getAll);
router.post('/', ApplicationController.create);
router.get('/job/:jobId', ApplicationController.getByJobId);
router.get('/:id', ApplicationController.getById);
router.put('/:id', ApplicationController.update);
router.delete('/:id', ApplicationController.delete);

module.exports = router;
const express = require('express');
const router = express.Router();
const CandidateController = require('../controllers/CandidateController');

router.get('/', CandidateController.getAll);
router.post('/', CandidateController.create);
router.get('/:id', CandidateController.getById);
router.put('/:id', CandidateController.update);
router.delete('/:id', CandidateController.delete);

module.exports = router;
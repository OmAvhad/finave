const router = require('express').Router();
const authenticateToken = require('../middlewares/authMiddleware');
const TransactionController = require('../controllers/transactionController');


const transactionController = new TransactionController();

router.post('/create', authenticateToken, transactionController.createTransaction);
router.get('/all', authenticateToken, transactionController.getTransactions);
router.delete('/delete/:id', authenticateToken, transactionController.deleteTransaction);
router.put('/update/:id', authenticateToken, transactionController.updateTransaction);
router.get('/get/:id', authenticateToken, transactionController.getTransaction);

module.exports = router;
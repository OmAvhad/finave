const router = require('express').Router();
const UserController = require('../controllers/userController');
const authenticateToken = require('../middlewares/authMiddleware');

const userController = new UserController();

router.post('/login', userController.login);
router.post('/signup', userController.signUp);
router.get('/verify', userController.verify);
router.get('/profile', authenticateToken, userController.profile);
router.put('/update', authenticateToken, userController.update);

module.exports = router;
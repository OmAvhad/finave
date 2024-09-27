const jwt = require('jsonwebtoken');
const secretToken = process.env.TOKEN_SECRET

function generateAccessToken(email, _id) {
    return jwt.sign(
        { email: email, _id: _id },
        process.env.TOKEN_SECRET, 
        { expiresIn: '2d' }
    );
}

const User = require('../models/user');

class UserController {

    async login(req, res) {
        const { email, password } = req.body;
        const user = await User
            .findOne({ email: email })
            .exec();
        if (!user) {
            return res.status(400).send('User not found');
        }
        if (user.password !== password) {
            return res.status(400).send('Password incorrect');
        }
        const token = generateAccessToken(email, user._id);
        res.send({
            token: token,
        });
    }

    async signUp(req, res) {
        const { name, email, password } = req.body;
        const user = await User
            .findOne({ email: email })
            .exec();
        if (user) {
            return res.status(400).send('User already exists');
        }
        const newUser = new User({ name: name, email: email, password: password });
        await newUser.save();
        const token = generateAccessToken(email, newUser._id);
        res.send(token);
    }

    async profile(req, res) {
        const user = await User
            .findOne({ email: req.user.email })
            .select('email name')
            .exec();

        if (!user) {
            return res.status(400).send('User not found');
        }

        res.send(user);
    }

    async update(req, res) {
        const { name } = req.body;
        const user = await User
            .findOne({ email: req.user.email })
            .select('email name')
            .exec();

        if (!user) {
            return res.status(400).send('User not found');
        }

        user.name = name;

        await user.save();
        res.send(user);
    }

    async verify(req, res) {
        const token = req.headers.authorization.split(' ')[1];
        jwt.verify(token, secretToken, (err, user) => {
            if (err) return res.sendStatus(403);
            res.send(user);
        });
    }
}

module.exports = UserController;
const {
    getCurrentTimeInTimeZone,
} = require("../helpers/timezoneHelper");
const Transaction = require("../models/Transaction");

class TransactionController {
    async createTransaction(req, res) {
        try {
            const { amount, type, category, description } = req.body;
            const transaction = await Transaction.create({
                amount,
                type,
                category,
                description,
                userId: req.user._id,
                date: getCurrentTimeInTimeZone(),
            });
            return res.status(201).json(transaction);
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
    
    async getTransactions(req, res) {
        try {
            const transactions = await Transaction.find({
                userId: req.user._id,
            });

            return res.status(200).json(transactions);
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    async deleteTransaction(req, res) {
        try {
            const result = await Transaction.deleteOne({
                _id: req.params.id,
                userId: req.user._id,
            });

            // Check if the deletion was successful
            if (result.deletedCount === 0) {
                return res.status(404).json({ error: "Transaction not found" });
            }

            return res.status(204).end();
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    async updateTransaction(req, res) {
        try {
            const transaction = await Transaction.findOne({
                _id: req.params.id,
                userId: req.user._id
            });

            if (!transaction) {
                return res.status(404).json({ error: "Transaction not found" });
            }

            const { amount, type, category, description } = req.body;
            if (amount) {
                transaction.amount = amount;
            }
            if (type) {
                transaction.type = type;
            }
            if (category) {
                transaction.category = category;
            }
            if (description) {
                transaction.description = description;
            }

            await transaction.save();

            return res.status(200).json(transaction);
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }

    async getTransaction(req, res) {
        try {
            const transaction = await Transaction.findOne({
                _id: req.params.id,
                userId: req.user._id,
            });

            if (!transaction) {
                return res.status(404).json({ error: "Transaction not found" });
            }

            return res.status(200).json(transaction);
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
}

module.exports = TransactionController;
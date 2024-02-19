const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

const app = express();
const PORT = process.env.PORT || 3000;

// Connect to MongoDB
mongoose.connect("mongodb://localhost:27017/todo-api");

// Create mongoose schema and model for todo
const todoSchema = new mongoose.Schema({
  task: String,
  completed: Boolean,
});

const Todo = mongoose.model("Todo", todoSchema);

// Middleware
app.use(bodyParser.json());

// Routes
app.get("/todos", async (req, res) => {
  try {
    const todos = await Todo.find();
    res.json(todos);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.post("/add-todo", async (req, res) => {
  const todo = new Todo({
    task: req.body.task,
    completed: req.body.completed || false,
  });

  try {
    const newTodo = await todo.save();
    res.status(201).json(newTodo);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

app.put("/todo/:id", async (req, res) => {
  const id = req.params.id;

  try{
    const todo = await Todo.findById(id);

    todo.completed = !todo.completed;

    await todo.save();
  }catch(e){
    console.log(`Error ${e}`);
  }

   
});

app.delete("/todo/:id", async (req, res) => {
  const id = req.params.id;

  try {
    await Todo.findByIdAndDelete(id);
    res.json({ message: "Todo deleted" });
  } catch (error) {
    res.status(404).json({ message: "Todo not found" });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

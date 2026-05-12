const express = require("express");
const app = express();
const PORT = 5000;

app.use(express.json());

// ─── Sample data (in-memory) ─────────────────
let tasks = [
  { id: 1, title: "Learn Docker", completed: false },
  { id: 2, title: "Build an API", completed: true },
  { id: 3, title: "Dockerize the app", completed: false },
];

// ─── Routes ──────────────────────────────────

// Health check
app.get("/api/health", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime() });
});

// Get all tasks
app.get("/api/tasks", (req, res) => {
  res.json(tasks);
});

// Get single task
app.get("/api/tasks/:id", (req, res) => {
  const task = tasks.find((t) => t.id === parseInt(req.params.id));
  if (!task) return res.status(404).json({ error: "Task not found" });
  res.json(task);
});

// Create task
app.post("/api/tasks", (req, res) => {
  const { title } = req.body;
  if (!title) return res.status(400).json({ error: "Title is required" });

  const newTask = {
    id: tasks.length + 1,
    title,
    completed: false,
  };
  tasks.push(newTask);
  res.status(201).json(newTask);
});

// Delete task
app.delete("/api/tasks/:id", (req, res) => {
  const index = tasks.findIndex((t) => t.id === parseInt(req.params.id));
  if (index === -1) return res.status(404).json({ error: "Task not found" });

  const deleted = tasks.splice(index, 1);
  res.json({ message: "Deleted", task: deleted[0] });
});

// ─── Start Server ────────────────────────────
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});

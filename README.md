# 💼 Freelance Management System

A complete **Database Management System (DBMS)** project designed for a freelancing platform where **project owners** and **freelancers** connect, collaborate, and complete projects smoothly.

---

## 🎯 Objective
To design and implement a fully functional and normalized database that:
- Manages freelance project data
- Connects freelancers and project owners
- Tracks milestones, payments, bids, messages, and feedback
- Ensures data integrity and smooth workflow

---

## 📖 Project Overview
The system enables project owners to upload project details that are visible to all freelancers, who can then submit bids for these projects. Project owners select the freelancer that best meets their requirements based on submitted bids. The platform supports effective communication between freelancers and project owners throughout the project lifecycle. Projects are divided into milestones, with payments released to freelancers upon the completion of each stage. After the project's completion, project owners can provide feedback and ratings, which reflect the quality of the work delivered.

---

## 🧱 Features

- Fully normalized schema (up to **BCNF**)
- 15+ well-defined relational tables
- Foreign keys with cascading updates & deletes
- Messaging & feedback system
- Milestone-based payment structure
- Skill tracking, bids, and project tagging
- Platform-level country-wise charges
- Tested on **PostgreSQL**

---

## 📂 Project Contents

- **Entity-Relationship (ER) Diagram**
- **Relational Model**
- **Functional Dependencies**
- **Normalization up to BCNF**
- **DDL Script** (Table creation)
- **DML Script** (Sample data insertion)
- **Sample SQL Queries**

---

## 🔎 Key Functionalities

- **User Profiles**  
  Separate records for freelancers and project owners with bank details and feedback.

- **Projects & Milestones**  
  Owners post projects with categories; freelancers complete work in steps (milestones).

- **Communication**  
  Real-time messaging and project-based feedback between users.

- **Bidding & Payments**  
  Freelancers bid on projects; payments are tracked per milestone.

- **Skills & Tags**  
  Freelancers showcase skills and projects are tagged for better discovery.

---

## 🧾 Technologies Used
- **PostgreSQL**
- SQL (DDL, DML, Queries)

---

> This project shows how databases power real-world platforms by managing structured data, relationships, and workflows with efficiency.

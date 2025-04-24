# My Class Project

Hey! This repo is where I’ve organized everything from our class project—think of it as a working portfolio for learning and applying data analysis using R, Quarto, and GitHub. The goal was to build good habits around reproducible research, using a structured pipeline that helps keep things organized and easy to follow.

![Data science pipeline](https://github.com/mbutler808/rclass/blob/main/images/dspipeline.png)  
Figure: The Data Science Pipeline from RD Peng

---

## What We Did

The class was broken up into three main projects:

1. **Project 1: Data Cleaning**  
   We started with just `Data` and `Code` folders. The focus here was understanding how to handle raw data and get it ready for analysis.
   
2. **Project 2: Analysis Workflow**  
   After cleaning our data, we added folders for `Results` and `Products` to reflect our new steps—analyzing the cleaned dataset and generating outputs like figures and tables.

3. **Project 3: Independent Project**  
   For this one, we pulled everything together using our own dataset. The idea was to go through the full process: cleaning, analyzing, and reporting.

---

## A Little Backstory

This project structure is based on a template from Andreas Handel’s data analysis workflow. I just cloned it and tweaked it for this course. First release was back in Feb 2023 when we kicked off the first project.

---

## What You Need

To work with this template, you’ll need:

- R
- Quarto
- GitHub (or Git)
- A reference manager for working with .bib files
- A plain text editor
- Optional: software that opens .docx files (Word, Pages, or LibreOffice)

There’s also a great list of reproducible research tools and packages in CRAN’s task view if you want to explore further.

---

## Folder Structure (a.k.a. How We Stay Sane)

This setup follows the idea that there should only ever be *one* version of anything—especially code or output. That helps prevent things from getting out of sync when you make edits. Also, all folder names start with a capital letter for consistency.

- `Data` – raw and processed datasets
- `Code` – scripts for data cleaning and analysis
- `Results` – any figures, tables, or numeric outputs
- `Products` – everything from reports and slides to web apps
- Each folder has a `README.md` inside to explain what goes where

---

## What’s Inside

Here’s a breakdown of what’s in each folder:

- **Raw_data**: contains the Palmer Penguins dataset we used to practice.
- **Processing_code**: scripts that take raw data, clean it, and save a processed version.
- **Analysis_code**: scripts for exploratory analysis and modeling—outputs are saved to `Results`.
- **Products**:
  - `bibtex` and CSL files for handling references
  - Example Quarto manuscript and slide decks
- **Manuscript**: a starter report written in Quarto, with a template for supplementary materials.
- **Slides**: a simple Quarto slide deck for presentations.

---

## Reflections

Honestly, one of the biggest takeaways for me was how important structure is. At first, it felt like a lot of folders, but once we got into running things in sequence, it really helped me understand how pieces of a project come together.

Also—I hadn’t used Quarto before this class, but now I’m kind of obsessed. Being able to weave together code, outputs, and narrative in one place makes the whole process feel more intuitive and complete.

---

## Getting Started

This repo uses GitHub’s template setup, so you can start your own version like this.

Here’s how to run the project from start to finish:

1. Run the data processing scripts → This gives you a clean dataset.
2. Run the analysis scripts → Generates figures and tables.
3. Render the manuscript, poster, or slides → These pull in your results and format your citations using the .bib and CSL files.

Let me know if you want help running any part of it or adapting it for your own work!
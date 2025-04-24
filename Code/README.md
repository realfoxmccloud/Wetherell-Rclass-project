# Code Folder Overview

This is where all your R scripts or Quarto (`.qmd`) files go—basically, anything that makes the data *do stuff*. The goal here is to stay organized and keep everything easy to follow, both for you and anyone else who might need to run your code later.

---

### Where to Put What

Split your code into the following folders depending on what it does:

- **Processing_code** – for cleaning raw data and saving the processed version
- **Analysis_code** – for exploring, modeling, and analyzing the cleaned data

You can always add subfolders if your project is more complex or has a bunch of steps. Just keep it logical and consistent.

---

### How to Structure Your Code

There’s no one right way to write your scripts, but you’ve got two main approaches:

- Write a few longer scripts that handle multiple tasks, or
- Break everything down into short, focused scripts that each do one thing well.

Either way, **document everything** clearly—use comments or a quick summary at the top of the script. Future-you will be super grateful, especially when you’re trying to figure out what you were doing three weeks (or three months) later.

Each script should:
- Load the right dataset (raw or cleaned),
- Do its thing (cleaning, analysis, visualization, etc.), and
- Save the results in the right folder (`Processed_data`, `Results`, etc.)

---

### Use Relative Paths

Super important: always use **relative paths** in your scripts. This way, your code will work no matter where your project folder lives on someone’s computer. Set your working directory to wherever the script is located, and go from there. I made the mistake of using absolute paths my first go around and it didnʻt work well for the person trying to check my work.

---

### What to Document

To keep everything smooth, make sure each script (or a README file like this one) includes:

- What data or files the script takes as input
- Where it saves the output
- If scripts need to be run in a specific order, make that clear
- Bonus: add comments *inside* the script as well as external notes for more complex steps

---

### Reflection

I used to think naming scripts and folders was just a formality, but now I see it’s really part of making your work accessible and reproducible. Being clear about what each script does and how it fits into the overall project has honestly made debugging and revisiting my code *so* much easier.


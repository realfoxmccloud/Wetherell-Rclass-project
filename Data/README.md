# Data Folder Overview

This folder is where *all* the data for the project lives, and it's organized to reflect the different stages of working with that data. So whether it's the raw stuff you just got your hands on, or a clean version ready for analysis, it's all here and easy to track.

The data gets loaded, cleaned, reshaped, and saved using scripts from the `Code` folder—so ideally, you're not manually editing any of these files outside of R unless you absolutely have to (more on that below).

---

### Raw Data

Anything that goes into the `Raw_data` folder should be left *exactly* as you received it. This is your starting point, your “master copy.” The idea here is: don’t change the raw data. Any fixes or tweaks should happen through your code—this way, there’s a clear record of every step in your workflow. It also keeps your analysis reproducible and transparent.

#### If This Is *Your* Data

If you collected and entered the data yourself, definitely take a moment to double-check it before adding it to the raw folder. You want this version to be as clean and accurate as possible. That said, if you spot a clear typo or error (and you can confirm it against field notes or original sources), go ahead and correct it before saving it as raw data. Just don’t "clean" in the sense of reshaping or recoding here—leave that to the code.

If you’re working with someone else’s dataset, though, it’s not really your job to fix unknown errors—you’ll just work with what they gave you.

---

### Cleaned Data

The cleaned-up version of your data goes into `Processed_data`. This is where your code comes into play.

Sometimes, the data comes in weird formats—like messy Excel files with color-coded cells or merged columns—and R just can’t handle it. In that case, save the original file in `Raw_data`, then make a **copy** of it to clean up manually (maybe in Excel or something similar). Just remember: only edit the *copy*, and be sure to document what you did. A quick note in the README is usually fine.

The rule of thumb: always keep an untouched version of your original data somewhere safe.

---

### A Few Tips

- Use subfolders if your process involves more than one cleaning or reshaping step. It really helps when you're trying to retrace your steps later.
- Save your processed data in multiple formats:
  - `.RDS` or `.RData` keeps all your R-specific stuff like factor levels intact.
  - `.csv` is great for archiving, sharing, or opening outside of R.
- Include a **data dictionary** that defines every variable in your dataset. Trust me, your future self will thank you.

Here’s a good resource on saving your data in R:  
http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

---

### Reflections

Something I realized during this process is just how important it is to treat your raw data like a time capsule—you don’t mess with it, you just document everything around it. That mindset really changed how I think about organizing projects.

Also, I used to think multiple file formats were overkill, but having both `.RDS` and `.csv` saved me more than once when switching between environments or trying to share results when not using R.


http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata
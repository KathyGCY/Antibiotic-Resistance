# Antibiotic-Resistance
Stochastic Simulation of Antibiotic Resistance
I made a few illustrations of the bacteria invasion progress and notes on how I could model it and then simulate the whole process.

**********************************************************
# What does a Bacteria Invasion Looks Like?
Bacteria invasion is just like the Chitaurian Army that invaded New York;
Immune System are like human armies, with {B-Cell, T-Cell and Mega} corresponding to {F15, M1A3, and Nuc Subs}, taking down small proportion of bacteria;
Antibiotics are like the Avengers, wiping out large proportion of bacteria.
**********************************************************

# Zoom In
Now if we zoom in to the combat zone, to have a close look at what the Bacteria, the ATB and the Immune System is doing:
The ATB and Immune System targets different part of the bacteria, each killing the bacteria one part at a time.
ATB (The Shield) is like jamming a Pugio into the Chitauri’s Head
Immune System (like the T-Cell or the M1A3 in the image) is blowing a whole in the Chitauri’s chest.
**********************************************************
Now that we know the mechanisms, how do we programme the process?
Let’s go back to the “Table-Top Exercises”, freeze the image to see what happens within one loop. Combining that with the zoomed in image, we now have several claims that helps us revise my simulation to make it more realistic.

# What Happens Within Loop?
# Two Things Always Happen:
1. Bacteria Multiplication:
Exponential Growth with a volatility term;
2. Immune System Fighting:
Kill a small proportion of bacteria in each loop;

# Two Things Might Happen:
3. Antibiotic Injected:
Kills a Large proportion of bacteria in this specific loop;
4. Bacteria leaning “Resistance”
To Be Continued…

# Antibiotic Resistance

# Learning Steps:
1. In each loop, a small proportion of bacteria MUTATES;
2. Each Mutant has a small chance of gaining the Resistance ability;
3. Once “learned”, never “forgets”.

# Resisting Steps:
1. “Resistance” is an ability to resist one or several antibiotics;
2. “Resistance” is an ability that LOWERS but NOT ELIMINATE the chance of being killed by that one or several antibiotics that it is resistant to.

# When We Drop The Curtain:
# “WIN”: 
1. Bacteria eliminated;
2. Number of bacteria lower than threshold;
3. Coexist.

# “LOSE”:
1. Ready for a REMATCH;
2. R.I.P.
3. Resuscitation (?)

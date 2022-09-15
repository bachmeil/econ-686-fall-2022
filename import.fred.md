# import.fred

## Overview

This function reads in a csv file that was downloaded from FRED. It needs to be the default CSV format provided by FRED, including the header, with no changes. It needs to be monthly, quarterly, or annual frequency.

The function determines the frequency and start date of the data. It returns a ts object with the correct frequency and start/end dates.

## Example

```
gdp <- import.fred("gdp.csv")
```

This line creates a new variable with the name `gdp` to hold the ts data downloaded from FRED that is stored in gdp.csv. It will be quarterly frequency with the correct start date.
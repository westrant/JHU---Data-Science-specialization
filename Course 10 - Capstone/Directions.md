---
title: "Directions - Word prediction"
author: "Tim Westran"
date: "3/5/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## What this is

This app performs text prediction, based on user input.
I'm using the stupid backoff algorithm to perform text prediction.

When trying to find the probability of word appearing in a sentence it will first look for context for the word at the n-gram level and if there is no n-gram of that size it will recurse to the (n-1)-gram and multiply its score with 0.4. The recursion stops at unigrams.



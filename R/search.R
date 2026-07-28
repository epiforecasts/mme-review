# Setting up search terms and running search of med/bio/arxiv

# Benchmark articles ------------------------------------------------------
library(europepmc)
seeds <- c(40029911, 28958414, 37985664, 28245814, 35394862, 40269898, 36635782, 39174027, 37118796, 37083521, 34508077, 37648218, 38714099, 30679458, 31756193, 39076350, 36476987, 34647627, 35349605, 36352249)
seed_query <- paste0("(EXT_ID:", paste(seeds, collapse = " OR EXT_ID:"), ")")
seed_works <- europepmc::epmc_search(seed_query)

# Search terms ------------------------------------------------------------
# MEDLINE & EMBASE
q_medline <- '(("infectious disease".ti,ab. OR epidemic$.ti,ab. OR pandemic$.ti,ab. OR outbreak$.ti,ab. OR influenza.ti,ab. OR COVID$.ti,ab. OR virus.ti,ab.) AND (nowcast$.ti,ab. OR forecast$.ti,ab. OR predicted.ti,ab. OR prediction$.ti,ab. OR predictive.ti,ab. OR projected.ti,ab. OR projection$.ti,ab.) AND ("ensemble".ti,ab. OR "multi-model$".ti,ab. OR "multi model$".ti,ab. OR "multiple model$".ti,ab. OR stacking.ti,ab. OR "model averaging".ti,ab. OR "forecast combination".ti,ab. OR "model combination".ti,ab.))'

# medrxiv, biorxiv
q_medrxiv <- list(
  c("infectious disease", "epidemic*", "pandemic*", "outbreak*", "influenza", "COVID*", "virus"),
  c("nowcast*", "forecast*", "predicted*", "prediction*", "predictive", "projected", "projection*"),
  c("ensemble", "multi-model*", "multi model*", "multiple model*", "stacking", "model averaging", "forecast combination", "model combination")
  )

q_arxiv <- '("infectious disease" OR "epidemic*" OR "pandemic*"  OR  "outbreak*" OR  "influenza" OR "COVID*" OR "virus") AND ("nowcast*" OR "forecast*" OR  "predicted*", "prediction*", "predictive", "projected", "projection*") AND ("ensemble" OR  "multi-model*" OR  "multi model*" OR "multiple model*" OR  "stacking" OR  "model averaging" OR  "forecast combination" OR  "model combination")'

# Search ---------------------------------------------------------------------
library(aRxiv)
library(medrxivr)
# medrxiv
mx_data <- mx_api_content(server = "medrxiv",
                          from_date = "2013-01-01",
                          to_date = "2025-09-23")

r_medrxiv <- mx_search(data = ,
                       query = q_medrxiv,
                       fields = c("title", "abstract"))
mx_export(r_medrxiv, file = "data/medrxiv.bib")

# arxiv
r_arxiv_l <- arxiv_search(q_arxiv,
                          limit = arxiv_count(q_arxiv),
                          output_format = "list")



# -------------------------------------------------------------------------
# OpenAlex

# '
# A list of filters are set using the filter parameter, formatted like this: filter=attribute:value,attribute2:value2. Examples:
#
#   Get the works whose type is book:
#   https://api.openalex.org/works?filter=type:book
#
# Get the authors whose name is Einstein:
#   https://api.openalex.org/authors?filter=display_name.search:einstein
#
# Filters are case-insensitive.
# '
# openalexR::oa_fetch()

library(openalexR)
# europepmc::epmc_search(query)
# remotes::install_github("elizagrames/litsearchr")
library(litsearchr)

#Snowball search
snowball_docs_doi <- oa_snowball(
  pmid = seeds,
  citing_params = list(),
  cited_by_params = list(),
  verbose = TRUE
)

theme_query <- oa_query(entity = "works", multiple_id = TRUE,
                        authorships.author.orcid = ids$person_orcid)
theme_works <- oa_request(theme_query)


# using litsearchr for keywords -----------------------------------------

library(igraph)

naive_results_full <- import_results(file = "naive-search.nbib")

naive_results <- naive_results_full[sample(nrow(naive_results_full), 500), ]

my_text <- paste(naive_results$title,
                 naive_results$abstract,
                 naive_results$keywords)
raked_keywords <- extract_terms(
  text = my_text,
  method = "fakerake",
  min_freq = 2,
  ngrams = TRUE,
  min_n = 2,
  language = "English"
)

naive_dfm <- create_dfm(
  elements = my_text,
  features = raked_keywords
)

naive_graph <- create_network(
  search_dfm = as.matrix(naive_dfm),
  min_studies = 2,
  min_occ = 2
)
strengths <- sort(strength(naive_graph), decreasing=TRUE)
cutoff <- find_cutoff(
  naive_graph,
  method = "cumulative",
  percent = .30,
  imp_method = "strength"
)

print(cutoff)
reduced_graph <- reduce_graph(naive_graph, cutoff_strength = cutoff)
search_terms <- get_keywords(reduced_graph)
print(search_terms)


# Installing packages 
install.packages("haven")
install.packages("tidyr")

#Loading libraries
library(haven)
library(tidyr)
library(dplyr)

#1) Sauvegarde des fichiers:

ISSP_2022 = read_sav("~/5a/SQD/S1/Assistanat de recherche/RA_CED/data/ZA10000_v2-0-0.dta/ZA10000_v2-0-0.sav")
ISSP_2012 = read_sav("~/5a/SQD/S1/Assistanat de recherche/RA_CED/data/ZA5900_v4-0-0.sav/ZA5900_v4-0-0.sav")

#2) Nettoyage des données:

ISSP_2022_filtered <- ISSP_2022 %>%
  filter(c_alphan == c("FR", "SE")) %>% #Conserve uniquement les données de la France (FR) et de la Suède (SE)
  mutate(year = 2022) #Crée une nouvelle variable "year" pour le reste de l'analyse

ISSP_2012_filtered <- ISSP_2012 %>%
  filter(C_ALPHAN == c("FR", "SE")) %>%
  mutate(year = 2012)

#3) Fusion des jeux de données de 2012 et 2022

#3.a: Comparaison des colonnes présentes en 2012 et 2022

col2022 <- as.list(colnames(ISSP_2022))
col2012 <- as.list(colnames(ISSP_2022))


  


# >on va merger 2012 et 2022, France et Suède;
# >on devriat travailler sur le champ suivant : parents en couples hétérosexuels cohabitants;
# >on devrait travailler sur les variables de temps domestique (housework) et de temps parental 
# (ou "care") en tant que VD : il faudra faire un score comme celui-ci : la part du travail domestique 
# et du travail parental (faire deux VD) faite par les hommes dans le couple 
# (donc dans le couple faire H/H+F). Ce sera donc un score d'égalité domestique à l'échelle du couple 
# et un score d'égalité parentale à l'échelle du couple
# >on prendra les VI suivantes : pays, sexe du répondant, âge de la femme, âge de l'homme, 
# niveau d'éducation de la femme (faire une variable avec seulement trois niveaux de diplômes), 
# niveau d'éducation de l'homme, nombre/sexe des enfants
# >on va faire une décomposition Oaxaca-Blinder 2012-2022 sur le score d'égalité domestique 
# et d'égalité parentale avec toutes ces VI;
# >on va faire des OLS sur les deux VD scores égalité dom et égalité par, 
# trois modèles "hiérarchiques" ou "emboités" sur chaque VD : M1:Pays+Année, M2=M1+autres VI, 
# M3=M2+interaction Pays x haut niveau de diplôme, M4=M2+interaction Année x haut niveau de diplôme.
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

col2022 <- as.list(colnames(ISSP_2022)) # Crée une liste des colonnes présentes
col2012 <- as.list(colnames(ISSP_2012)) 

# Fonction identifiant les colomnes manquantes
column_count <- function(liste_etudiee, liste_de_reference) { 
    count <- 0 # Reset le compteur à 0
    for (column in liste_etudiee) {
        if (as.character(column) %in% liste_de_reference) {
            next 
            #Si la colonne de la liste étudiée est présente dans la liste de référence, 
            #le code passe à la colonne suivante
        } else {
            print(column) # Ecrit la colonne manquante
            count <- count + 1}} #Ajoute 1 au compteur de colonnes manquantes
    print(paste("Nombre de colonnes manquantes : ", count)) } #Imprime un message

column_count(col2022, col2012) #Applique la fonction aux deux listes

#En plus d'avoir 3 colonnes d'écart, la moitié sont écrites différemment : en
#majuscules en 2012 et en minuscules en 2022


#3.b: harmonization des colonnes 


#Sélection des variables pertinentes

#Création d'une liste de variables à conserver pour 2012
col_selected2012 <- c("V37", "V38", "V39", "V40", "SEX", "AGE", "BIRTH", "DATEYR", 
                      "PARTLIV", "V66", "FR_DEGR", "SE_DEGR", "DEGREE", "V65", 
                      "C_ALPHAN", "year")

#V37 = "Q16a How many hours spend on household work"
#V38 = "Q16b How many hours spend on family members"
#V39 = "Q17a How many hours spouse, partner works on household"
#V40 = "Q17b How many hours spouse, partner spends on family members"
#V66 = "Q33 Spouse, partner: Age"

col_selected2022 <- c("EDULEVEL", "PARTLIV", "SEX", "AGE", "BIRTH", "DATEYR", 
                      "c_alphan", "year", "v34","v35", "v36", "v37", "v63", 
                      "FR_ISCD", "SE_ISCD", "ISCED", "FR_SPISCD",
                      "SE_SPISCD", "SPISCED", "SPEDULEV")

#v34 = "Q15a How many hours spend on household work"
#v35 = "Q15b How many hours spend on family members"
#v36 = "Q16a How many hours spouse, partner works on household"
#v37 = "Q16b How many hrs spouse, partner spends on family members"
#v63 = "Q30 How many children have you ever had"

#v64 = "O31a Provide care: child(ren) below school age"
#v65 = "O31b Provide care: child(ren) of school age, up to 18"
#v66 = "O31c Provide care: elderly person(s)"
#v67 = "O31d Provide care: long term sick/disabled person(s)"
#v68 = "O31e Provide care: other person(s)"


#Sélection et harmonisation des colonnes

ISSP_2012_cleaned <- ISSP_2012_filtered %>% #Crée un nouveau dataset
  select(all_of(col_selected2012)) %>% # Conserve uniquement les variables sélectionnées
  

ISSP_2022_cleaned <- ISSP_2022_filtered %>%
  select(all_of(col_selected2022))


column_count(col_selected2012, col_selected2022)

?rename
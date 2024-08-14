#descargar pack
install.packages("pacman")
pacman::p_load(
  readxl, #importar archivos excel
  tidyverse, #manejo de datos
  here,       # directorios relativos
  janitor,    # limpiar dataframes
  lubridate,  # trabajar con fechas
  labelled,    # añadir 
  summarytools,
  rio
)
#definir la ruta del archivo
ruta <- here('sesion_3',"data","data_le_anonima.xlsx")

#impotar el archivo
dato <- import(ruta) 

#revisar columnas 
names(dato)
#revisar los datos que tiene el archivo
dfSummary(dato)

dato <- dato %>% 
  clean_names()

#importar nueva ruta para realizar cruce
ruta2 <- here('sesion_3',"data","deis2024.xlsx")
deis <- import (ruta2) %>% 
clean_names() %>% 
  select(codigo_vigente, nombre_oficial) %>% 
  mutate(
    codigo_vigente = as.character (codigo_vigente)
  )

#CRUZAR DATOS LE Y DEIS
dato <- dato %>% 
  left_join(deis, by= c ("estab_orig" = "codigo_vigente"))


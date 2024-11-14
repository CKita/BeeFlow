# BeeFlow

Supplement to chapter 1 of the Ph.D. thesis "The effects of floral plantings on the crop pollination services". Graduate School in Ecology, Institute of Biosciences, University of São Paulo, Brazil.

[Ecological Synthesis Lab](https://marcomellolab.wordpress.com) (SintECO).

Authors: Cristina A. Kita, Sara D. Leonhardt & Marco A. R. Mello.

E-mail: [c.akemikita\@gmail.com](mailto:c.akemikita@gmail.com){.email}.

Not published yet

Run in R version 4.4.2 (2024-10-31) -- "Pile of Leaves".

Disclaimer: You may freely use the software and data provided here for commercial or non-commercial purposes at your own risk. We assume no responsibility or liability for the use of this material, convey no license or title under any patent, copyright, or mask work right to the product. We reserve the right to make changes in the material without notification. We also make no representation or warranty that such application will be suitable for the specified use without further testing or modification. If this material helps you produce any academic work (paper, book, chapter, monograph, dissertation, thesis, report, talk, keynote, lecture or similar), please acknowledge the authors and cite the source.

## Functionality

The data and scripts provided here aim at making our study fully reproducible. You will find code to reproduce both the analyses and the figures, as well as the main supplementary material.

## List of folders and files

### **Authors (folder)**

1.  Data (folder)

    a.  network_authors.csv -\> data frame with raw data.

    b.  uni.csv -\> data frame with raw data.
    
2.  Figure (folder)

    a.  network_authors.png -\> authors network.

    b.  uni.png -\> authors' institution per country.
    
3.  Code (folder)

    a.  network_authors.R -\> main script formatted as a tutorial to help you reproduce the authors network.

    b.  uni.R -\> main script formatted as a tutorial to help you reproduce the figure.

### **Bees (folder)**

1.  Data (folder)

    a.  withApis.csv -\> data frame with raw data.
   
2.  Figure (folder)

    a.  withApis.png -\> the top 10 most abundant bees reported in the studies. 
   
3.  Code (folder)

    a.  bee.R -\> main script formatted as a tutorial to help you reproduce the figure.

### **Crops (folder)**

1.  Data (folder)

    a.  crop_type.csv -\> data frame with raw data.

2.  Figure (folder)

    a.  crops.png -\> crops studied.
    
3.  Code (folder)

    a.  crops.R -\> main script formatted as a tutorial to help you reproduce the figure.

### **Effects (folder)**

1.  Code (folder)

    a.  fishbone.csv -\> data frame with raw data.

2.  Figure (folder)

    a.  fishbone.png -\> environmental factors that may influence the effects of floral plantings on crop pollination services by bees.
    
### **Floral plantings (folder)**

1.  Data (folder)

    a.  floral_planting_type.csv -\> data frame with the types of floral plantings (hedgerows and flower strips) reported in the studies.
    
    b.  flowerStrip_per_diff_floral_plantings.csv -\> data frame with the plant species in the floral plantings per study. 

2.  Figure (folder)

    a.  floral_planting_types.png -\> types of floral plantings reported in the studies.

    b.  floral_plantings.png -\> The top 10 most common plant species cultivated in floral plantings.

3.  Code (folder)

    a.  floral_planting_type.R -\> script formatted as a tutorial to help you reproduce the figure.

    b.  flowers.R -\> script formatted as a tutorial to help you reproduce the figure.

### **Keywords (folder)**

1.  Code (folder)

    a.  keywords.R -\> script formatted as a tutorial to help you reproduce the figure.

2.  Data (folder)

    a.  keywords.csv -\> data frame with the keywords reported per study.
    
4.  Figure (folder)

    a.  wordcloud.png -\> wordcloud of keywords.

### **Litsearch (folder)**

1.  Data (folder)

    a.  records_scopus.csv -\> data frame with the list of articles imported from Scopus.

    b.  wos.csv -\> data frame with the list of articles imported from Web of Science.

    c. scielo.csv -\> data frame with the list of articles imported from Scielo.
    
2.  Code (folder)

    a.  doc_keywords.R -\> main script formatted as a tutorial to help you deduplicate the list of articles imported from the databases using the litsearch package.

### **Sites (folder)**

1.  Data (folder)

    a.  sites.csv -\> data frame with raw data.

2.  Figure (folder)

    a.  sites.png -\> study sites (black, white, and grey).

    b. sites2.png -\> study sites (grey and green).
    
3.  Code (folder)

    a.  Sites.R -\> main script formatted as a tutorial to help you reproduce the figures.

### **Years (folder)**

1.  Data (folder)

    a.  Article.csv -\> data frame with raw data.

2.  Figure (folder)

    a.  journals.png -\> journals where the studies were published.

    b. publication_year.png -\> publication year of the studies.
    
3.  Code (folder)

    a.  Journals.R -\> main script formatted as a tutorial to help you reproduce the figure.

    b. publication_year -\> main script formatted as a tutorial to help you reproduce the figure.

        
## Instructions

1.  Choose between the type of analysis you want to reproduce and go to the respective folder;

2.  Run the main script of each folder to create the figures;

3.  Follow the instructions provided in each script.

## Feedback

If you have any questions, corrections, or suggestions, please feel free to open an [issue](https://github.com/CKita/BeeFlow/issues) or make a [pull request](https://github.com/CKita/BeeFlow/pulls).

## Acknowledgments

We thank the authors of all primary studies included in our systematic review, who made this synthesis possible. CAK thanks the Coordination for the Improvement of Higher Education Personnel (CAPES, 88887.802356/2023-00), the Graduate School in Ecology of the University of São Paulo (PPGE/IB-USP), and São Paulo Research Foundation (FAPESP, 2023/17728-9) for the Ph.D. scholarship. We also thank the Stack Overflow community (https://stackoverflow.com/), where we solve most of our coding dilemmas. We have no conflicts of interest to declare. 

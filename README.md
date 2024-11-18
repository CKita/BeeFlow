# BeeFlow

Supplement to the manuscript:

*Kita CA, Alves-dos-Santos I, Hrncir M, Leonhardt SD, Mello MAR. An ecological synthesis about the effects of floral plantings on crop pollination by bees. In prep.*

This manuscript is part of the Ph.D. thesis CA Kita, enrolled in the Graduate School in Ecology, Institute of Biosciences, University of São Paulo, Brazil.

[Ecological Synthesis Lab](https://marcomellolab.wordpress.com) (SintECO).

Authors: Cristina A. Kita, Isabel Alves-dos-Santos, Michael Hrncir, Sara D. Leonhardt & Marco A. R. Mello.

E-mail: [c.akemikita\@gmail.com](mailto:c.akemikita@gmail.com){.email}.

Originally published on November 12th, 2024.

Run in R version 4.4.2 (2024-10-31) -- "Pile of Leaves".

Disclaimer: You may freely use the software and data provided here for commercial or non-commercial purposes at your own risk. We assume no responsibility or liability for the use of this material, convey no license or title under any patent, copyright, or mask work right to the product. We reserve the right to make changes in the material without notification. We also make no representation or warranty that such application will be suitable for the specified use without further testing or modification. If this material helps you produce any academic work (paper, book, chapter, monograph, dissertation, thesis, report, poster, talk, keynote, lecture or similar), please acknowledge the authors and cite the source.

## Functionality

The data and scripts provided here aim at making our study reproducible. You will find code to reproduce both the analyses and the figures, as well as the main supplementary material.

## List of folders and files

### **Authors (folder)**

1.  Data (folder)

    a.  network_authors.csv -\> data frame with raw data on the authors of the selected studies.

    b.  uni.csv -\> data frame with raw data on the institutions where the authors of the selected studies are based.

2.  Figure (folder)

    a.  network_authors.png -\> coauthorship network.

    b.  uni.png -\> number of studies published per country.

3.  Code (folder)

    a.  network_authors.R -\> commented script to help reproduce the figure `network_authors.png`.

    b.  uni.R -\> commented script to help reproduce the figure `uni.png`.

### **Bees (folder)**

1.  Data (folder)

    a.  withApis.csv -\> data frame with raw data on bee Latin names and codes.

2.  Figure (folder)

    a.  withApis.png -\> the top 10 most abundant bee species reported in the selected studies.

3.  Code (folder)

    a.  bee.R -\> commented script to help reproduce the figure `withApis.png`.

### **Crops (folder)**

1.  Data (folder)

    a.  crop_type.csv -\> data frame with raw data on the crop types assessed in each study.

2.  Figure (folder)

    a.  crops.png -\> number of studies that assessed each crop type.

3.  Code (folder)

    a.  crops.R -\> commented script to help reproduce the figure `crops.png`.

### **Effects (folder)**

1.  Figure (folder)

    a.  fishbone.png -\> environmental factors that seem to influence the effects of floral plantings on crop pollination by bees.

2.  Code (folder)

    a.  fishbone.R -\> commented script to help reproduce the figure `fishbone.png`.

### **Floral plantings (folder)**

1.  Data (folder)

    a.  floral_planting_type.csv -\> data frame with the types of floral plantings (hedgerows and flower strips) assessed in the selected studies.

    b.  flowerStrip_per_diff_floral_plantings.csv -\> data frame with the plant species used in the floral plantings assessed in the selected study.

2.  Figure (folder)

    a.  floral_planting_types.png -\> number of studies that assessed each type of floral plantings.

    b.  floral_plantings.png -\> The top 10 most common plant species cultivated in floral plantings.

3.  Code (folder)

    a.  floral_planting_type.R -\> commented script to help reproduce the figure `floral_planting_types.png`.

    b.  flowers.R -\> commented script to help reproduce the figure `floral_plantings.png`.

### **Keywords (folder)**

1.  Data (folder)

    a.  keywords.csv -\> data frame with the keywords reported in each study.

2.  Figure (folder)

    a.  wordcloud.png -\> wordcloud with the keywords used in the selected studies.

3.  Code (folder)

    a.  keywords.R -\> commented script to help reproduce the figure `wordcloud.png`.

### **Litsearch (folder)**

1.  Data (folder)

    a.  records_scopus.csv -\> data frame with the list of studies imported from Scopus.

    b.  wos.csv -\> data frame with the list of studies imported from Web of Science.

    c.  scielo.csv -\> data frame with the list of studies imported from Scielo.

2.  Code (folder)

    a.  doc_keywords.R -\> commented script to help deduplicate the list of studies imported from the databases.

### **Sites (folder)**

1.  Data (folder)

    a.  sites.csv -\> data frame with raw data on the sites where the selected studies were conducted.

2.  Figure (folder)

    a.  sites.png -\> locations of the study sites on the world.

    b.  sites2.png -\> number of studies conducted per country.

3.  Code (folder)

    a.  Sites.R -\> commented script to help reproduce the figures `sites.png` and `sites2.png`.

### **Years (folder)**

1.  Data (folder)

    a.  Article.csv -\> data frame with raw data on the references of the selected studies.

2.  Figure (folder)

    a.  journals.png -\> number of studies published per journal.

    b.  publication_year.png -\> number of studies published per year.

3.  Code (folder)

    a.  Journals.R -\> commented script to help reproduce the figure `journals.png`.

    b.  publication_year -\> commented script to help reproduce the figure `publication_year.png`.

## Instructions

1.  Choose the analysis you want to reproduce and go to the respective folder;

2.  Open the main script;

3.  Follow the instructions provided in the script.

## Feedback

If you have any questions, corrections, or suggestions, please feel free to open an [issue](https://github.com/CKita/BeeFlow/issues) or make a [pull request](https://github.com/CKita/BeeFlow/pulls).

## Acknowledgments

We are deeply grateful to the authors of all primary studies included in our systematic review, whose empirical work made our synthesis possible. Special thanks go to Astrid Kleinert and Renata Muylaert for their invaluable insight and advice, which helped us see the bigger picture and put CAK’s Ph.D. project in perspective. Last but not least, we thank the Stack Overflow community (<https://stackoverflow.com/>), where we solve most of our coding dilemmas.

## Funding

CAK thanks the Coordination for the Improvement of Higher Education Personnel (CAPES, 8888.802356/2023-00), Graduate School in Ecology of the University of São Paulo (PPGE/IB-USP), and São Paulo Research Foundation (FAPESP, 2023/17728-9) for the Ph.D. scholarships. MARM was supported by grants, fellowships, and scholarships given to him and his team by the Alexander von Humboldt Foundation (AvH, 1134644), São Paulo Research Foundation (FAPESP, 2023/03083-6, 2023/02881-6, and 2023/17728-9), and Consulate General of France in São Paulo.

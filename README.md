# BeeFlow

Supplement to the manuscript:

*Kita CA, Alves-dos-Santos I, Hrncir M, Mello MAR. An ecological synthesis about the effects of floral plantings on crop pollination by bees. Submitted. (Check out the [preprint](https://doi.org/10.1101/2025.09.01.673359))*

This manuscript is part of the Ph.D. thesis of CA Kita, enrolled in the Graduate School in Ecology, Institute of Biosciences, University of São Paulo, Brazil.

[Ecological Synthesis Lab](https://marcomellolab.wordpress.com) (SintECO).

Authors: [Cristina A. Kita](https://orcid.org/0000-0002-4079-2677), [Isabel Alves-dos-Santos](https://orcid.org/0000-0003-2352-1290), [Michael Hrncir](https://orcid.org/0000-0003-4931-3924) & [Marco A. R. Mello](https://orcid.org/0000-0002-9098-9427).

E-mail: [c.akemikita\@gmail.com](mailto:c.akemikita@gmail.com){.email}.

Originally published on November 12th, 2024.

Run in R version 4.5.1 (2025-06-13) -- "Great Square Root".

## Disclaimer

### Purpose

This repository contains processed data, code, and additional information used in the analyses presented in the aforementioned manuscript. It is intended to provide transparency, reproducibility, and an educational resource for researchers interested in the methodologies described.

### Accuracy of contents

While every effort has been made to ensure that the materials provided are accurate and consistent with the findings reported in the paper, the authors do not guarantee the completeness or correctness of the repository contents. Users are encouraged to validate results independently.

### Usage and modifications

The contents are shared under a XXX License <!--# Temos que escolher a licença no final -->. Users are free to use, modify, and distribute the code, data, and information in accordance with this license. The authors bear no responsibility for outcomes arising from the use or misuse of these materials.

### Support and maintenance

This repository is provided "as is," without any commitment to ongoing maintenance or support. Questions or issues may be addressed through the GitHub Issues tab or a designated contact e-mail, but responses are not guaranteed.

### Third-party dependencies

The repository may rely on third-party software or libraries. Users are responsible for ensuring compatibility and proper installation of these dependencies. The authors do not endorse or provide guarantees for any third-party software.

### Ethical use

Users are expected to comply with all applicable ethical and legal standards when using this repository, especially regarding the handling of sensitive or proprietary data.

### Citation

If you use this repository in your work (software, paper, book, chapter, monograph, dissertation, thesis, report, poster, talk, keynote, lecture or similar), please cite the original paper and the DOI to this repository. By using this repository, you acknowledge and accept the terms of this disclaimer.

## Functionality

The data and scripts provided here aim at making our study reproducible. You will find code to reproduce both the analyses and the figures, as well as the main supplementary material.

## List of folders and files

### **Authors (folder)**

1.  Data (folder)

    a.  network_authors.csv -\> data frame with raw data on the authors of the selected studies.

2.  Figure (folder)

    a.  network_authors.png -\> coauthorship network.

3.  Code (folder)

    a.  network_authors.R -\> commented script to help reproduce the figure `network_authors.png`.

### **Bees (folder)**

1.  Data (folder)

    a.  crops effects and bees.csv -\> data frame with raw data on bee group per crop and the floral planting effect observed.

2.  Figure (folder)

    a.  crops effects and bees.png -\> floral planting effects per crop and bee group.

3.  Code (folder)

    a.  crops effects and bees.R -\> commented script to help reproduce the figure `crops effects and bees.png`.

### **Crops (folder)**

1.  Data (folder)

    a.  crops and effects.csv -\> data frame with raw data on the crop types and the floral planting effects assessed in each study.
    b.  studies and crops.csv -\> data frame with raw data on the crop types assessed in each study.

2.  Figure (folder)

    a.  crops and effects.png -\> percentage of floral planting effects per crop type assessed.
    b.  studies and crops.png -\> number of studies that assessed each crop type.

3.  Code (folder)

    a.  crops and effects.R -\> commented script to help reproduce the figure `crops and effects.png`.
    b.  studies and crops.R -\> commented script to help reproduce the figure `studies and crops.png`.

### **Floral plantings (folder)**

1.  Data (folder)

    a.  floral planting and effect.csv -\> data frame with floral planting composition assessed in the selected studies.

2.  Figure (folder)

    a.  floral planting and effect.png -\> floral planting composition dissimilarity per floral planting effect assessed.

3.  Code (folder)

    a.  floral planting and effect.R -\> commented script to help reproduce the figure `floral planting and effect.png`.

### **Litsearch (folder)**

1.  Data (folder)

    a.  records_scopus.csv -\> data frame with the list of studies imported from Scopus.

    b.  wos.csv -\> data frame with the list of studies imported from Web of Science.

    c.  scielo.csv -\> data frame with the list of studies imported from Scielo.

2.  Code (folder)

    a.  doc_keywords.R -\> commented script to help deduplicate the list of studies imported from the databases.

### **Sites (folder)**

1.  Data (folder)

    a.  studies and countries.csv -\> data frame with raw data on the sites where the selected studies were conducted.

2.  Figure (folder)

    a.  studies and countries.png -\> locations of the study sites on the world.

3.  Code (folder)

    a.  studies and countries.R -\> commented script to help reproduce the figure `studies and countries.png`.

### **Articles included in the review (file)**

List of articles included in our review (XLSX format).

### **Processed data (file)**

Processed data used in our quantitative and qualitative analyses (XLSX format).

## Instructions

1.  Choose the analysis you want to reproduce and go to the respective folder;

2.  Open the main script;

3.  Follow the instructions provided in the script.

## Feedback

If you have any questions, corrections, or suggestions, please feel free to open an [issue](https://github.com/CKita/BeeFlow/issues) or make a [pull request](https://github.com/CKita/BeeFlow/pulls).

## Acknowledgments <!--# Confira se estas duas últimas seções estão iguais às do artigo -->

We are deeply grateful to the authors of all primary studies included in our systematic review, whose empirical work made our synthesis possible. Special thanks go to Astrid Kleinert and [Renata Muylaert](https://renatamuy.github.io) for their invaluable insight and advice, which helped us see the bigger picture and put CAK’s Ph.D. project in perspective. Last but not least, we thank the Stack Overflow community (<https://stackoverflow.com/>), where we solve most of our coding dilemmas.

## Funding

CAK thanks the Coordination for the Improvement of Higher Education Personnel (CAPES, 8888.802356/2023-00), Graduate School in Ecology of the University of São Paulo (PPGE/IB-USP), and São Paulo Research Foundation (FAPESP, 2023/17728-9) for the Ph.D. scholarships. MARM was supported by grants, fellowships, and scholarships given to him and his team by the Alexander von Humboldt Foundation (AvH, 1134644), São Paulo Research Foundation (FAPESP, 2023/03083-6, 2023/02881-6, and 2023/17728-9), and Consulate General of France in São Paulo.

# Installing Wordpress

## Using Kubeapps

- Pre-requisite: Install kubeapps
- Set up user info
- Set storage class
- Set service type to ClusterIP
- Set storageClass to ceph-rbd

## Using repo directly

- Reference: <https://github.com/bitnami/charts/tree/main/bitnami/wordpress>
- Repo GitHub: <https://bitnami.com/stack/wordpress/helm>
- Clone values file to `motttt-values.yaml`
- Install with: `helm  install --namespace motttt --create-namespace motttt-01 --debug bitnami/wordpress --values motttt-values.yaml`

## Use cases

### Adam

- Biography

### Charles

- Project Toolkit
- Artist sites

### Martin

- MoTTTT
- biography
- SEO links

### Norma

- biography
- online questionaries

### UK Today

helm  install --namespace uktoday --create-namespace uktoday-01 --debug bitnami/wordpress --values uktodayblog-values.yaml

helm  install --namespace norma --create-namespace norma-01 --debug bitnami/wordpress --values normablog-values.yaml

## References

- <https://wordpress.org/plugins/html-forms/>
- <https://themeisle.com/blog/multi-author-wordpress-blog/>
- <https://ays-pro.com/wordpress/survey-maker>
- <https://ays-demo.com/demographic-survey-questionnaire/>
- <https://wordpress.org/plugins/survey-maker/>
- <https://quizandsurveymaster.com/best-free-wordpress-survey-plugins/>
- <https://kubiobuilder.com/wordpress-web-design/custom-html-css-wordpress/>
- <https://wordpress.com/support/wordpress-editor/blocks/custom-html-block/>
- <https://stackoverflow.com/questions/33727812/basic-questionnaire-input-how-to-style-questions-to-the-left-and-radios-to-the-r>
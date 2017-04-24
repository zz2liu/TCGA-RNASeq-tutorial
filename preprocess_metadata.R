#args = commandArgs(trailingOnly=T)
tmp = read.csv('metadata.cart.csv', check.names=F)
metaFeatures = c(
    file_id='file_id',
    barcode='associated_entities/0/entity_submitter_id',
    case_id='associated_entities/0/case_id',
    BMI='cases/0/exposures/0/bmi',
    weight='cases/0/exposures/0/weight',
    height='cases/0/exposures/0/height',
    year_of_birth='cases/0/demographic/year_of_birth',
    gender='cases/0/demographic/gender',
    race='cases/0/demographic/race',
    ethnicity='cases/0/demographic/ethnicity',
    tumor_stage='cases/0/diagnoses/0/tumor_stage',
    vital_status='cases/0/diagnoses/0/vital_status',
    days_to_death='cases/0/diagnoses/0/days_to_death',
    days_to_last_follow_up='cases/0/diagnoses/0/days_to_last_follow_up',
    days_to_birth='cases/0/diagnoses/0/days_to_birth',
    percent_tumor_cells='cases/0/samples/0/portions/0/slides/0/percent_tumor_cells',
    samples.sample_type='cases/0/samples/0/sample_type',
    annotation.category='annotations/0/category',
    annotation.notes='annotations/0/notes')
fileInfo = tmp[,metaFeatures]
colnames(fileInfo) = names(metaFeatures)
write.csv(fileInfo, 'fileInfo.csv', row.names=F)

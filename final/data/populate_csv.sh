cat part2_project/data/students.csv | psql -U dl4111 -d dl4111_db -c "COPY students from STDIN CSV HEADER" &&

cat part2_project/data/professors.csv | psql -U dl4111 -d dl4111_db -c "COPY professors from STDIN CSV HEADER" 

cat part2_project/data/departments.csv | psql -U dl4111 -d dl4111_db -c "COPY departments from STDIN CSV HEADER" &&

cat part2_project/data/classes_instructed.csv | psql -U dl4111 -d dl4111_db -c "COPY classes_instructed from STDIN CSV HEADER" 

cat part2_project/data/offer_by.csv | psql -U dl4111 -d dl4111_db -c "COPY offer_by from STDIN CSV HEADER" &&

cat part2_project/data/questions.csv | psql -U dl4111 -d dl4111_db -c "COPY questions from STDIN CSV HEADER" &&

cat part2_project/data/follow_constraints.csv | psql -U dl4111 -d dl4111_db -c "COPY follow_constraints from STDIN CSV HEADER" &&

cat part2_project/data/have_examples.csv | psql -U dl4111 -d dl4111_db -c "COPY have_examples from STDIN CSV HEADER" 

cat part2_project/data/language.csv | psql -U dl4111 -d dl4111_db -c "COPY language from STDIN CSV HEADER" &&

cat part2_project/data/comment.csv | psql -U dl4111 -d dl4111_db -c "COPY comment from STDIN CSV HEADER" 

cat part2_project/data/assigned.csv | psql -U dl4111 -d dl4111_db -c "COPY assigned from STDIN CSV HEADER" &&

cat part2_project/data/with_details.csv | psql -U dl4111 -d dl4111_db -c "COPY with_details from STDIN CSV HEADER"

import pandas as pd
import psycopg2
import streamlit as st
from configparser import ConfigParser

"# Online Interactice System for Coding Classes NYU"


@st.cache
def get_config(filename="database.ini", section="postgresql"):
    parser = ConfigParser()
    parser.read(filename)
    return {k: v for k, v in parser.items(section)}


@st.cache
def query_db(sql: str):
    # print(f"Running query_db(): {sql}")

    db_info = get_config()

    # Connect to an existing database
    conn = psycopg2.connect(**db_info)

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    cur.execute(sql)

    # Obtain data
    data = cur.fetchall()

    column_names = [desc[0] for desc in cur.description]

    # Make the changes to the database persistent
    conn.commit()

    # Close communication with the database
    cur.close()
    conn.close()

    df = pd.DataFrame(data=data, columns=column_names)

    return df


"## Read tables"

sql_all_table_names = "SELECT relname FROM pg_class WHERE relkind='r' AND relname !~ '^(pg_|sql_)';"
try:
    all_table_names = query_db(sql_all_table_names)["relname"].tolist()
    table_name = st.selectbox("Choose a table", all_table_names)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")

if table_name:
    f"Display the table"

    sql_table = f"SELECT * FROM {table_name};"
    try:
        df = query_db(sql_table)
        st.dataframe(df)
    except:
        st.write(
            "Sorry! Something went wrong with your query, please try again."
        )
        
        
        
        
"## 1. Given a leetcode question id, list the question difficulty level, question title, question content, input example and output example."

sql_questions_qids = "SELECT qid FROM questions;"
try:
    questions_qids = query_db(sql_questions_qids)["qid"].tolist()
    questions_qid = st.selectbox("Select the leetcode question number: ", questions_qids)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")

if questions_qid:
    sql_questions = f"""
                    SELECT q.qid, q.difficulty, q.title, q.question_content, h.input_content, h.output_content
                    FROM questions q, have_examples h
                    WHERE q.qid = '{questions_qid}'
                    AND q.qid = h.qid
                    ;"""
    try:
        questions_info = query_db(sql_questions).loc[0]
        q_qid,q_diff,q_title,q_content, q_inp, q_oup = (
            questions_info["qid"],
            questions_info["difficulty"],
            questions_info["title"],
            questions_info["question_content"],
            questions_info["input_content"],
            questions_info["output_content"],
        )
        st.write(
            f"Question #**_{q_qid}_** has difficulty level of {q_diff}.  \n  \n"
            f"**_Title_**: {q_title}  \n  \n"
            f"**_Question Asking_**:  \n  \n {q_content}  \n  \n"
            f"**_Input Example_**: {q_inp}  \n  \n"
            f"**_Output Example_**: {q_oup}"
            
        )
    except:
        st.write(
            "Sorry! Something went wrong with your query, please try again."
        )



"## 2. Given a student name, list the number of questions the student completed. For each question completed, show the question id, completion timestamp, grade received and language used. "

sql_students_names = "SELECT name FROM students;"
try:
    student_names = query_db(sql_students_names)["name"].tolist()
    student_name = st.selectbox("Select the student: ", student_names)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")

if student_name:
    sql_questions = f"""
                    SELECT s.name, count(*)
                    FROM students s, with_details w
                    WHERE s.name = '{student_name}'
                    AND s.sid = w.sid
                    group by s.name
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["name"],
            questions_info["count"],
        )

        st.write(
            f"According to our record, **_{a}_** completed **_{b}_** questions so far"
            
        )
    except:
        st.write(
            "Oops, according to our record, this student did not complete any questions so far"
        )



if student_name:
    sql_questions = f"""
                    SELECT s.name, w.qid, w.completion_date, w.grade, l.lname
                    FROM students s, with_details w, language l
                    WHERE s.name = '{student_name}'
                    AND s.sid = w.sid
                    AND w.lid = l.lid
                    ;"""
    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            q_sname, q_qid, q_date, q_grade, q_lname = (
                questions_info["name"],
                questions_info["qid"],
                questions_info["completion_date"],
                questions_info["grade"],
                questions_info["lname"],
            )
            
            st.write(
                f"Student **_{q_sname}_** completed question #**_{q_qid}_** at **_{q_date}_**  \n  \n"
                f"The grade received: **_{q_grade}_**  \n  \n"
                f"The language used: **_{q_lname}_**"
                
            )
    except:
        st.write(
            "Oops, according to our record, this student did not complete any questions so far  \n  \n"
        )


"## 3. Given a student name, list all the assigned leetcode questions as well as their ddl. "

if student_name:
    sql_questions = f"""
                    SELECT s.name, count(*)
                    FROM students s, assigned a
                    WHERE s.name = '{student_name}'
                    AND s.sid = a.sid
                    group by s.name
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["name"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, **_{a}_** completed **_{b}_** questions so far"
#
#        )
    except:
        st.write(
            "Oops, according to our record, this student were not assigned any leetcode problems"
        )



if student_name:
    sql_questions = f"""
                    SELECT s.name, a.qid, a.ddl
                    FROM students s, assigned a
                    WHERE s.name = '{student_name}'
                    AND s.sid = a.sid
                    ;"""
    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            q_sname, q_qid, q_date = (
                questions_info["name"],
                questions_info["qid"],
                questions_info["ddl"],
            )
            
            st.write(
                f"question #**_{q_qid}_** with ddl of **_{q_date}_**"
                
                
            )
    except:
        st.write(
            "Oops, according to our record, this student were not assigned any leetcode problems"
        )


"## 4. Given a student name, list all the questions that he/she commented on before, as well as the timestamp. "

if student_name:
    sql_questions = f"""
                    SELECT s.name, count(*)
                    FROM students s, comment c, questions q
                    WHERE s.name = '{student_name}'
                    AND s.sid = c.sid
                    AND q.qid = c.qid
                    group by s.name
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["name"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, **_{a}_** completed **_{b}_** questions so far"
#
#        )
    except:
        st.write(
            "Oops, according to our record, this student did not make any comments so far"
        )



if student_name:
    sql_questions = f"""
                    SELECT s.name, q.qid, q.title, c.time
                    FROM students s, comment c, questions q
                    WHERE s.name = '{student_name}'
                    AND s.sid = c.sid
                    AND q.qid = c.qid
                    ;"""
    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            q_sname, q_qid, q_title, q_time = (
                questions_info["name"],
                questions_info["qid"],
                questions_info["title"],
                questions_info["time"],
            )
            
            st.write(
                f"question #**_{q_qid}_** with a title of **_{q_title}_** at **_{q_time}_**"
                
                
            )
    except:
        st.write(
            "Oops, according to our record, this student did not make any comments so far"
        )




"## 5. Given a class name, list the number of students who took the class, as well as their names."

sql_class_names = "SELECT title FROM classes_instructed;"
try:
    class_names = query_db(sql_class_names)["title"].tolist()
    class_name = st.selectbox("Select the class: ", class_names)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")
    

if class_name:
    sql_questions = f"""
                    SELECT c.title, count(*)
                    FROM classes_instructed c, assigned a, students s
                    WHERE c.title = '{class_name}'
                    AND c.cid = a.cid
                    AND a.sid = s.sid
                    group by c.title
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["title"],
            questions_info["count"],
        )

        st.write(
            f"According to our record, **_{b}_** students took the class **_{a}_**  \n"
            
        )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )


if class_name:
    sql_questions = f"""
                    SELECT c.title, s.name sname
                    FROM classes_instructed c, assigned a, students s
                    WHERE c.title = '{class_name}'
                    AND c.cid = a.cid
                    AND a.sid = s.sid
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["title"],
                questions_info["sname"],
            )

            st.write(
                f"{b}  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )


"## 6. Given class name, list all students who attempted the leetcode problems.(may complete after ddl)"

if class_name:
    sql_questions = f"""
                    select a.cid, count(*)
                    from with_details w, assigned a, classes_instructed c
                    where w.sid = a.sid
                    and w.qid = a.qid
                    and c.cid = a.cid
                    and c.title = '{class_name}'
                    group by a.cid
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["cid"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, **_{b}_** students took the class **_{a}_**  \n"
#
#        )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )


if class_name:
    sql_questions = f"""
                    
                    select a.cid, s.name
                    from with_details w, assigned a, students s, classes_instructed c
                    where w.sid = a.sid
                    and w.qid = a.qid
                    and a.sid = s.sid
                    and c.cid = a.cid
                    and c.title = '{class_name}'
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["cid"],
                questions_info["name"],
            )

            st.write(
                f"{b}  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )




"## 7. Given class name, list all students who have finished their leetcode problems before ddl."

if class_name:
    sql_questions = f"""
                    select a.cid, count(*)
                    from with_details w, assigned a, classes_instructed c
                    where w.sid = a.sid
                    and w.qid = a.qid
                    and a.ddl > w.completion_date
                    and c.cid = a.cid
                    and c.title = '{class_name}'
                    group by a.cid
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["cid"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, **_{b}_** students took the class **_{a}_**  \n"
#
#        )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )


if class_name:
    sql_questions = f"""
                    
                    select a.cid, s.name
                    from with_details w, assigned a, students s, classes_instructed c
                    where w.sid = a.sid
                    and w.qid = a.qid
                    and a.ddl > w.completion_date
                    and a.sid = s.sid
                    and c.cid = a.cid
                    and c.title = '{class_name}'
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["cid"],
                questions_info["name"],
            )

            st.write(
                f"{b}  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )

"## 8. Given a class name, list the students’ performance(percentage of students completed the assigned problems before the ddl) in the class."

if class_name:
    sql_questions = f"""
                    SELECT c.title, count(*)
                    FROM assigned a, with_details w, classes_instructed c
                    WHERE c.title = '{class_name}'
                    AND a.qid = w.qid
                    AND a.sid = w.sid
                    AND a.cid = c.cid
                    group by c.title
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["title"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, **_{b}_** students took the class **_{a}_**  \n"
#
#        )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )


if class_name:
    sql_questions = f"""
                    select result.cid, result.rate
                    from (
                    select round((f.p_count+0.0) /( f.t_count+0.0)*100,0)  rate , f.cid
                    from (select f1.count p_count, f2.count t_count, f1.cid
                    from (select a.cid, count(*)
                    from with_details w, assigned a
                    where w.sid = a.sid
                    and w.qid = a.qid
                    and a.ddl > w.completion_date
                    group by a.cid) f1,
                     (select a.cid, count(*)
                    from assigned a
                    group by a.cid) f2
                    where f1.cid = f2.cid) f) result, classes_instructed c
                    
                    where c.title = '{class_name}'
                    and result.cid = c.cid
                    
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["cid"],
                questions_info["rate"],
            )

            st.write(
                f"The percentage of students completed the assigned problems before the ddl: **_{b}%_**  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, this class did not enroll in the online leetcode program right now. Maybe try the classes listed near the top of the list?"
        )


"## 9. Given a term, list the number of classes offered in that term as well as the class names."

sql_total = "SELECT distinct term FROM offer_by order by term;"
try:
    total = query_db(sql_total)["term"].tolist()
    one = st.selectbox("Select the term: ", total)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")
    

if one:
    sql_questions = f"""
                    SELECT o.term, count(*)
                    FROM offer_by o
                    WHERE o.term = '{one}'
                    group by o.term
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["term"],
            questions_info["count"],
        )

        st.write(
            f"According to our record, there were **_{b}_** classes offered in term **_{a}_**  \n"
            
        )
    except:
        st.write(
            "Oops, according to our record, no classes were offered in this term"
        )


if one:
    sql_questions = f"""
                    SELECT o.term, c.title
                    FROM offer_by o, classes_instructed c
                    WHERE o.term = '{one}'
                    AND o.cid = c.cid
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["term"],
                questions_info["title"],
            )

            st.write(
                f"{b}  \n"
                
            )
        st.write(f"(Note: Some classes' titles are all capital letters, it's due to instructors' preferences.)  \n  \n")
    
    except:
        st.write(
            "Oops, according to our record, no classes were offered in this term"
        )

"## 10. Given a term, list the names of professors who are teaching in that term."

if one:
    sql_questions = f"""
                    SELECT o.term, count(*)
                    FROM offer_by o, professors p, classes_instructed c
                    WHERE o.term = '{one}'
                    AND o.cid = c.cid
                    AND c.pid = p.pid
                    group by o.term
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["term"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, there were **_{b}_** classes offered in term **_{a}_**  \n"
#
#        )
    except:
        st.write(
            "Oops, according to our record, no professors are teaching in this term"
        )


if one:
    sql_questions = f"""
                    SELECT o.term, p.name
                    FROM offer_by o, professors p, classes_instructed c
                    WHERE o.term = '{one}'
                    AND o.cid = c.cid
                    AND c.pid = p.pid
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["term"],
                questions_info["name"],
            )

            st.write(
                f"{b}  \n"
                
            )
    
    except:
        st.write(
            "Oops, according to our record, no classes were offered in this term"
        )

"## 11. Given a term, list the names of departments that are offering classes in that term."

if one:
    sql_questions = f"""
                    SELECT o.term, count(*)
                    FROM offer_by o, departments d
                    WHERE o.term = '{one}'
                    AND o.did = d.did
                    group by o.term
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["term"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, there were **_{b}_** classes offered in term **_{a}_**  \n"
#
#        )
    except:
        st.write(
            "Oops, according to our record, no departmetns are offering classes in this term"
        )


if one:
    sql_questions = f"""
                    SELECT o.term, d.name
                    FROM offer_by o, departments d
                    WHERE o.term = '{one}'
                    AND o.did = d.did
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["term"],
                questions_info["name"],
            )

            st.write(
                f"{b}  \n"
                
            )
    
    except:
        st.write(
            "Oops, according to our record, no departmetns are offering classes in this term"
        )


"## 12. Given a department name, list all the classes they provided."

sql_total = "SELECT name FROM departments;"
try:
    total = query_db(sql_total)["name"].tolist()
    one = st.selectbox("Select the department: ", total)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")

if one:
    sql_questions = f"""
                    SELECT d.name, count(*)
                    FROM offer_by o, departments d, classes_instructed c
                    WHERE d.name = '{one}'
                    AND d.did = o.did
                    AND o.cid = c.cid
                    group by d.name
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["name"],
            questions_info["count"],
        )

        st.write(
            f"According to our record, department **_{a}_** has **_{b}_** classes offered  \n"
            
        )
    except:
        st.write(
            "Oops, according to our record, no classes were offered in this deparments. We mainly have CS & ECE classes. "
        )
    

if one:
    sql_questions = f"""
                    SELECT d.name, c.title
                    FROM offer_by o, departments d, classes_instructed c
                    WHERE d.name = '{one}'
                    AND d.did = o.did
                    AND o.cid = c.cid
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["name"],
                questions_info["title"],
            )

            st.write(
                f"{b}  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, no classes were offered in this deparments. We mainly have CS & ECE classes."
        )



"## 13. Given a professor name, list the names of classes that are instructed by that professor."

sql_total = "SELECT name FROM professors;"
try:
    total = query_db(sql_total)["name"].tolist()
    one = st.selectbox("Select the professor: ", total)
except:
    st.write("Sorry! Something went wrong with your query, please try again.")

if one:
    sql_questions = f"""
                    SELECT p.name, count(*)
                    FROM professors p, classes_instructed c
                    WHERE p.name = '{one}'
                    AND p.pid = c.pid
                    group by p.name
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["name"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, department **_{a}_** has **_{b}_** classes offered  \n"
            
#        )
    except:
        st.write(
            "Oops, according to our record, this professor is not teaching any classes "
        )
    

if one:
    sql_questions = f"""
                    SELECT p.name, c.title
                    FROM professors p, classes_instructed c
                    WHERE p.name = '{one}'
                    AND p.pid = c.pid
                    ;"""

    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b = (
                questions_info["name"],
                questions_info["title"],
            )

            st.write(
                f"{b}  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, this professor is not teaching any classes "
        )


"## 14. Given a professor name, list the questions that they assigned to their classes."

if one:
    sql_questions = f"""
                    SELECT p.name, count(*)
                    FROM professors p, classes_instructed c, assigned a, questions q
                    WHERE p.name = '{one}'
                    AND p.pid = c.pid
                    AND c.cid = a.cid
                    AND a.qid = q.qid
                    group by p.name
                    ;"""

    try:
        questions_info = query_db(sql_questions).loc[0]
        a,b = (
            questions_info["name"],
            questions_info["count"],
        )

#        st.write(
#            f"According to our record, department **_{a}_** has **_{b}_** classes offered  \n"
            
#        )
    except:
        st.write(
            "Oops, according to our record, this professor is not teaching any classes that involve online leetcode problems "
        )
    

if one:
    sql_questions = f"""
                    SELECT p.name, q.title, q.qid
                    FROM professors p, classes_instructed c, assigned a, questions q
                    WHERE p.name = '{one}'
                    AND p.pid = c.pid
                    AND c.cid = a.cid
                    AND a.qid = q.qid
                    ;"""
    try:
        for i in range(len(query_db(sql_questions))):
            questions_info = query_db(sql_questions).loc[i]
            a,b, c = (
                questions_info["name"],
                questions_info["title"],
                questions_info["qid"]
            )

            st.write(
                f"Question #**_{c}_** with title of **_{b}_**  \n"
                
            )
    except:
        st.write(
            "Oops, according to our record, this professor is not teaching any classes that involve online leetcode problems "
        )



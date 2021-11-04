--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assigned; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.assigned (
    ddl timestamp without time zone,
    sid integer NOT NULL,
    qid integer NOT NULL,
    cid integer NOT NULL
);


ALTER TABLE public.assigned OWNER TO dl4111;

--
-- Name: classes_instructed; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.classes_instructed (
    cid integer NOT NULL,
    title character varying(255),
    pid integer NOT NULL
);


ALTER TABLE public.classes_instructed OWNER TO dl4111;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.comment (
    sid integer NOT NULL,
    qid integer NOT NULL,
    "time" timestamp without time zone,
    number_of_likes integer,
    number_of_dislikes integer
);


ALTER TABLE public.comment OWNER TO dl4111;

--
-- Name: departments; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.departments (
    did integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.departments OWNER TO dl4111;

--
-- Name: follow_constraints; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.follow_constraints (
    cid integer NOT NULL,
    qid integer NOT NULL,
    constraints_content character varying(255)
);


ALTER TABLE public.follow_constraints OWNER TO dl4111;

--
-- Name: have_examples; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.have_examples (
    qid integer NOT NULL,
    eid integer NOT NULL,
    input_content character varying(255),
    output_content character varying(255)
);


ALTER TABLE public.have_examples OWNER TO dl4111;

--
-- Name: language; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.language (
    lid integer NOT NULL,
    lname character varying(255)
);


ALTER TABLE public.language OWNER TO dl4111;

--
-- Name: offer_by; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.offer_by (
    term character varying(255),
    cid integer NOT NULL,
    did integer NOT NULL
);


ALTER TABLE public.offer_by OWNER TO dl4111;

--
-- Name: professors; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.professors (
    pid integer NOT NULL,
    name character varying(255),
    pwd character varying(255)
);


ALTER TABLE public.professors OWNER TO dl4111;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.questions (
    qid integer NOT NULL,
    difficulty integer,
    title character varying(255),
    picture character varying(255),
    question_content character varying(1024)
);


ALTER TABLE public.questions OWNER TO dl4111;

--
-- Name: students; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.students (
    sid integer NOT NULL,
    name character varying(255),
    pwd character varying(255)
);


ALTER TABLE public.students OWNER TO dl4111;

--
-- Name: with_details; Type: TABLE; Schema: public; Owner: dl4111
--

CREATE TABLE public.with_details (
    lid integer NOT NULL,
    sid integer NOT NULL,
    qid integer NOT NULL,
    completion_date timestamp without time zone,
    grade character varying(255)
);


ALTER TABLE public.with_details OWNER TO dl4111;

--
-- Data for Name: assigned; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.assigned (ddl, sid, qid, cid) FROM stdin;
\.


--
-- Data for Name: classes_instructed; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.classes_instructed (cid, title, pid) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.comment (sid, qid, "time", number_of_likes, number_of_dislikes) FROM stdin;
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.departments (did, name) FROM stdin;
\.


--
-- Data for Name: follow_constraints; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.follow_constraints (cid, qid, constraints_content) FROM stdin;
\.


--
-- Data for Name: have_examples; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.have_examples (qid, eid, input_content, output_content) FROM stdin;
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.language (lid, lname) FROM stdin;
\.


--
-- Data for Name: offer_by; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.offer_by (term, cid, did) FROM stdin;
\.


--
-- Data for Name: professors; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.professors (pid, name, pwd) FROM stdin;
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.questions (qid, difficulty, title, picture, question_content) FROM stdin;
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.students (sid, name, pwd) FROM stdin;
\.


--
-- Data for Name: with_details; Type: TABLE DATA; Schema: public; Owner: dl4111
--

COPY public.with_details (lid, sid, qid, completion_date, grade) FROM stdin;
\.


--
-- Name: assigned assigned_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.assigned
    ADD CONSTRAINT assigned_pkey PRIMARY KEY (sid, qid, cid);


--
-- Name: classes_instructed classes_instructed_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.classes_instructed
    ADD CONSTRAINT classes_instructed_pkey PRIMARY KEY (cid);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (sid, qid);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (did);


--
-- Name: follow_constraints follow_constraints_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.follow_constraints
    ADD CONSTRAINT follow_constraints_pkey PRIMARY KEY (cid, qid);


--
-- Name: have_examples have_examples_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.have_examples
    ADD CONSTRAINT have_examples_pkey PRIMARY KEY (qid, eid);


--
-- Name: language languages_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT languages_pkey PRIMARY KEY (lid);


--
-- Name: offer_by offer_by_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.offer_by
    ADD CONSTRAINT offer_by_pkey PRIMARY KEY (cid, did);


--
-- Name: professors professors_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_pkey PRIMARY KEY (pid);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (qid);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (sid);


--
-- Name: with_details with_details_pkey; Type: CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.with_details
    ADD CONSTRAINT with_details_pkey PRIMARY KEY (sid, lid, qid);


--
-- Name: assigned assigned_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.assigned
    ADD CONSTRAINT assigned_cid_fkey FOREIGN KEY (cid) REFERENCES public.classes_instructed(cid);


--
-- Name: assigned assigned_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.assigned
    ADD CONSTRAINT assigned_qid_fkey FOREIGN KEY (qid) REFERENCES public.questions(qid);


--
-- Name: assigned assigned_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.assigned
    ADD CONSTRAINT assigned_sid_fkey FOREIGN KEY (sid) REFERENCES public.students(sid);


--
-- Name: classes_instructed classes_instructed_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.classes_instructed
    ADD CONSTRAINT classes_instructed_pid_fkey FOREIGN KEY (pid) REFERENCES public.professors(pid);


--
-- Name: comment comment_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_qid_fkey FOREIGN KEY (qid) REFERENCES public.questions(qid);


--
-- Name: comment comment_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_sid_fkey FOREIGN KEY (sid) REFERENCES public.students(sid);


--
-- Name: follow_constraints follow_constraints_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.follow_constraints
    ADD CONSTRAINT follow_constraints_qid_fkey FOREIGN KEY (qid) REFERENCES public.questions(qid) ON DELETE CASCADE;


--
-- Name: have_examples have_examples_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.have_examples
    ADD CONSTRAINT have_examples_qid_fkey FOREIGN KEY (qid) REFERENCES public.questions(qid) ON DELETE CASCADE;


--
-- Name: offer_by offer_by_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.offer_by
    ADD CONSTRAINT offer_by_cid_fkey FOREIGN KEY (cid) REFERENCES public.classes_instructed(cid);


--
-- Name: offer_by offer_by_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.offer_by
    ADD CONSTRAINT offer_by_did_fkey FOREIGN KEY (did) REFERENCES public.departments(did);


--
-- Name: with_details with_details_lid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.with_details
    ADD CONSTRAINT with_details_lid_fkey FOREIGN KEY (lid) REFERENCES public.language(lid);


--
-- Name: with_details with_details_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.with_details
    ADD CONSTRAINT with_details_qid_fkey FOREIGN KEY (qid) REFERENCES public.questions(qid);


--
-- Name: with_details with_details_sid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl4111
--

ALTER TABLE ONLY public.with_details
    ADD CONSTRAINT with_details_sid_fkey FOREIGN KEY (sid) REFERENCES public.students(sid);


--
-- PostgreSQL database dump complete
--


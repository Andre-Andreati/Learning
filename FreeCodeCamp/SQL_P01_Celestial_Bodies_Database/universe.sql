--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    size_in_meters numeric NOT NULL,
    shape character varying(30),
    age numeric NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    size integer NOT NULL,
    ecossystem text,
    inhabitable boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type character varying(30) NOT NULL,
    ecossystem text,
    inhabitable boolean,
    year_duration integer,
    day_duration integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: species; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.species (
    species_id integer NOT NULL,
    name character varying(30) NOT NULL,
    height numeric NOT NULL,
    weight numeric NOT NULL,
    sentient boolean
);


ALTER TABLE public.species OWNER TO freecodecamp;

--
-- Name: species_moons; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.species_moons (
    species_id integer NOT NULL,
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    species_moons_id integer NOT NULL
);


ALTER TABLE public.species_moons OWNER TO freecodecamp;

--
-- Name: species_moons_species_moons_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.species_moons_species_moons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.species_moons_species_moons_id_seq OWNER TO freecodecamp;

--
-- Name: species_moons_species_moons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.species_moons_species_moons_id_seq OWNED BY public.species_moons.species_moons_id;


--
-- Name: species_planets; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.species_planets (
    species_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    species_planets_id integer NOT NULL
);


ALTER TABLE public.species_planets OWNER TO freecodecamp;

--
-- Name: species_planets_species_planets_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.species_planets_species_planets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.species_planets_species_planets_id_seq OWNER TO freecodecamp;

--
-- Name: species_planets_species_planets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.species_planets_species_planets_id_seq OWNED BY public.species_planets.species_planets_id;


--
-- Name: species_species_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.species_species_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.species_species_id_seq OWNER TO freecodecamp;

--
-- Name: species_species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.species_species_id_seq OWNED BY public.species.species_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type character varying(30) NOT NULL,
    color character varying(30) NOT NULL,
    mass numeric NOT NULL,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: species species_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species ALTER COLUMN species_id SET DEFAULT nextval('public.species_species_id_seq'::regclass);


--
-- Name: species_moons species_moons_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_moons ALTER COLUMN species_moons_id SET DEFAULT nextval('public.species_moons_species_moons_id_seq'::regclass);


--
-- Name: species_planets species_planets_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_planets ALTER COLUMN species_planets_id SET DEFAULT nextval('public.species_planets_species_planets_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (316, 'G1', 123456789123456789123, 'Spiral', 1000000000000);
INSERT INTO public.galaxy VALUES (317, 'G2', 321654987321654987, 'Spherical', 1000000000000000);
INSERT INTO public.galaxy VALUES (318, 'G3', 741852963741852963741852963, 'Spiral', 5000000000000);
INSERT INTO public.galaxy VALUES (319, 'G4', 369258147369258147, 'Elliptical', 10000000000);
INSERT INTO public.galaxy VALUES (320, 'G5', 96385252741963852741, 'Irregular', 1000000000000000);
INSERT INTO public.galaxy VALUES (321, 'G6', 6546548754654644566, 'Triangular', 50000000000000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (222, 275, 'M1', 5, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (223, 275, 'M2', 500, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (224, 275, 'M3', 9000, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (225, 275, 'M4', 1, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (226, 275, 'M5', 324, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (227, 275, 'M6', 795, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (228, 279, 'M7', 6541, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (229, 279, 'M8', 13265, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (230, 279, 'M9', 7888, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (231, 279, 'M10', 954, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (232, 279, 'M11', 70230, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (233, 280, 'M12', 109, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (234, 282, 'M13', 90087, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (235, 282, 'M14', 452, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (236, 282, 'M15', 690, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (237, 282, 'M16', 98, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (238, 284, 'M17', 51, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (239, 289, 'M18', 1, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (240, 289, 'M19', 449, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (241, 294, 'M20', 1190, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (242, 294, 'M21', 3, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (243, 294, 'M22', 30, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (244, 294, 'M23', 56, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (245, 294, 'M24', 5, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (246, 294, 'M25', 79, 'Ipsum lorem ipsus lalala', true);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (275, 297, 'P1', 'Gas Giant', 'Ipsum lorem ipsus lalala', true, 100, 25);
INSERT INTO public.planet VALUES (276, 297, 'P2', 'Ice Giant', 'Ipsum lorem ipsus lalala', true, 500, 250);
INSERT INTO public.planet VALUES (277, 299, 'P3', 'Ocean Planet', 'Ipsum lorem ipsus lalala', true, 25, 2500);
INSERT INTO public.planet VALUES (278, 299, 'P4', 'Super Earth', 'Ipsum lorem ipsus lalala', true, 924, 25000);
INSERT INTO public.planet VALUES (279, 299, 'P5', 'Ice Planet', 'Ipsum lorem ipsus lalala', true, 18972, 94);
INSERT INTO public.planet VALUES (280, 301, 'P6', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', false, 23, 9);
INSERT INTO public.planet VALUES (281, 302, 'P7', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 445, 666);
INSERT INTO public.planet VALUES (282, 303, 'P8', 'Ocean Planet', 'Ipsum lorem ipsus lalala', false, 10, 584);
INSERT INTO public.planet VALUES (283, 303, 'P9', 'Gas Giant', 'Ipsum lorem ipsus lalala', true, 9888, 14);
INSERT INTO public.planet VALUES (284, 305, 'P10', 'Ice Planet', 'Ipsum lorem ipsus lalala', true, 7777, 736);
INSERT INTO public.planet VALUES (285, 305, 'P11', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', true, 1111, 932);
INSERT INTO public.planet VALUES (286, 305, 'P12', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 2222, 568);
INSERT INTO public.planet VALUES (287, 306, 'P13', 'Gas Giant', 'Ipsum lorem ipsus lalala', false, 5241, 7779);
INSERT INTO public.planet VALUES (288, 307, 'P14', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 23, 6652);
INSERT INTO public.planet VALUES (289, 308, 'P15', 'Ocean Planet', 'Ipsum lorem ipsus lalala', true, 6, 3214);
INSERT INTO public.planet VALUES (290, 310, 'P16', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', false, 8, 74);
INSERT INTO public.planet VALUES (291, 310, 'P17', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 90, 48);
INSERT INTO public.planet VALUES (292, 310, 'P18', 'Ocean Planet', 'Ipsum lorem ipsus lalala', true, 41, 9);
INSERT INTO public.planet VALUES (293, 312, 'P19', 'Gas Giant', 'Ipsum lorem ipsus lalala', true, 12, 5);
INSERT INTO public.planet VALUES (294, 312, 'P20', 'Ice Planet', 'Ipsum lorem ipsus lalala', false, 12, 1);
INSERT INTO public.planet VALUES (295, 312, 'P21', 'Super Earth', 'Ipsum lorem ipsus lalala', true, 4, 233);
INSERT INTO public.planet VALUES (296, 312, 'P22', 'Ice Planet', 'Ipsum lorem ipsus lalala', false, 4, 664);
INSERT INTO public.planet VALUES (297, 312, 'P23', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', true, 4, 78);
INSERT INTO public.planet VALUES (298, 312, 'P24', 'Ice Giant', 'Ipsum lorem ipsus lalala', true, 80, 995);
INSERT INTO public.planet VALUES (299, 312, 'P25', 'Ice Giant', 'Ipsum lorem ipsus lalala', true, 80, 2);


--
-- Data for Name: species; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species VALUES (76, 'SP1', 1.15, 150, true);
INSERT INTO public.species VALUES (77, 'SP2', 2.3, 100, false);
INSERT INTO public.species VALUES (78, 'SP3', 3.2, 500, true);
INSERT INTO public.species VALUES (79, 'SP4', 0.8, 100, false);
INSERT INTO public.species VALUES (80, 'SP5', 0.1, 200, false);
INSERT INTO public.species VALUES (81, 'SP6', 1.9, 10, true);
INSERT INTO public.species VALUES (82, 'SP7', 4, 50, true);
INSERT INTO public.species VALUES (83, 'SP8', 10, 50, true);
INSERT INTO public.species VALUES (84, 'SP9', 0.1, 80, false);
INSERT INTO public.species VALUES (85, 'SP10', 5, 9, false);
INSERT INTO public.species VALUES (86, 'SP11', 1, 400, true);
INSERT INTO public.species VALUES (87, 'SP12', 2, 15, false);
INSERT INTO public.species VALUES (88, 'SP13', 3, 160, true);
INSERT INTO public.species VALUES (89, 'SP14', 4, 40, false);
INSERT INTO public.species VALUES (90, 'SP15', 5, 5, true);


--
-- Data for Name: species_moons; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species_moons VALUES (76, 222, 'SP1 M1', 1);
INSERT INTO public.species_moons VALUES (76, 223, 'SP1 M2', 2);
INSERT INTO public.species_moons VALUES (76, 224, 'SP1 M3', 3);
INSERT INTO public.species_moons VALUES (76, 227, 'SP1 M6', 4);
INSERT INTO public.species_moons VALUES (77, 222, 'SP2 M1', 5);
INSERT INTO public.species_moons VALUES (77, 224, 'SP2 M3', 6);
INSERT INTO public.species_moons VALUES (77, 227, 'SP2 M6', 7);
INSERT INTO public.species_moons VALUES (78, 225, 'SP3 M4', 8);
INSERT INTO public.species_moons VALUES (78, 229, 'SP3 M8', 9);
INSERT INTO public.species_moons VALUES (78, 230, 'SP3 M9', 10);
INSERT INTO public.species_moons VALUES (78, 246, 'SP3 M25', 11);
INSERT INTO public.species_moons VALUES (79, 234, 'SP4 M13', 12);
INSERT INTO public.species_moons VALUES (80, 228, 'SP5 M7', 13);
INSERT INTO public.species_moons VALUES (80, 229, 'SP5 M8', 14);
INSERT INTO public.species_moons VALUES (80, 230, 'SP5 M9', 15);
INSERT INTO public.species_moons VALUES (80, 231, 'SP5 M10', 16);
INSERT INTO public.species_moons VALUES (82, 238, 'SP7 M17', 17);
INSERT INTO public.species_moons VALUES (83, 240, 'SP8 M19', 18);
INSERT INTO public.species_moons VALUES (84, 238, 'SP9 M17', 19);
INSERT INTO public.species_moons VALUES (85, 243, 'SP10 M22', 20);
INSERT INTO public.species_moons VALUES (85, 244, 'SP10 M23', 21);
INSERT INTO public.species_moons VALUES (86, 234, 'SP11 M13', 22);
INSERT INTO public.species_moons VALUES (86, 235, 'SP11 M14', 23);
INSERT INTO public.species_moons VALUES (88, 228, 'SP13 M7', 24);
INSERT INTO public.species_moons VALUES (88, 235, 'SP13 M14', 25);
INSERT INTO public.species_moons VALUES (88, 241, 'SP13 M20', 26);
INSERT INTO public.species_moons VALUES (88, 246, 'SP13 M25', 27);
INSERT INTO public.species_moons VALUES (89, 227, 'SP14 M6', 28);
INSERT INTO public.species_moons VALUES (90, 238, 'SP15 M17', 29);


--
-- Data for Name: species_planets; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species_planets VALUES (76, 275, 'SP1 P1', 1);
INSERT INTO public.species_planets VALUES (77, 275, 'SP2 P1', 2);
INSERT INTO public.species_planets VALUES (78, 275, 'SP3 P1', 3);
INSERT INTO public.species_planets VALUES (79, 277, 'SP4 P3', 4);
INSERT INTO public.species_planets VALUES (79, 282, 'SP4 P8', 5);
INSERT INTO public.species_planets VALUES (79, 289, 'SP4 P15', 6);
INSERT INTO public.species_planets VALUES (79, 292, 'SP4 P18', 7);
INSERT INTO public.species_planets VALUES (80, 279, 'SP5 P5', 8);
INSERT INTO public.species_planets VALUES (81, 299, 'SP6 P25', 9);
INSERT INTO public.species_planets VALUES (81, 298, 'SP6 P24', 10);
INSERT INTO public.species_planets VALUES (81, 296, 'SP6 P22', 11);
INSERT INTO public.species_planets VALUES (83, 295, 'SP8 P21', 12);
INSERT INTO public.species_planets VALUES (83, 289, 'SP8 P15', 13);
INSERT INTO public.species_planets VALUES (84, 284, 'SP9 P10', 14);
INSERT INTO public.species_planets VALUES (85, 293, 'SP10 P19', 15);
INSERT INTO public.species_planets VALUES (85, 283, 'SP10 P9', 16);
INSERT INTO public.species_planets VALUES (87, 285, 'SP12 P11', 17);
INSERT INTO public.species_planets VALUES (87, 289, 'SP12 P15', 18);
INSERT INTO public.species_planets VALUES (87, 293, 'SP12 P19', 19);
INSERT INTO public.species_planets VALUES (87, 292, 'SP12 P18', 20);
INSERT INTO public.species_planets VALUES (87, 279, 'SP12 P5', 21);
INSERT INTO public.species_planets VALUES (88, 295, 'SP13 P21', 22);
INSERT INTO public.species_planets VALUES (89, 275, 'SP14 P1', 23);
INSERT INTO public.species_planets VALUES (90, 284, 'SP15 P10', 24);
INSERT INTO public.species_planets VALUES (90, 276, 'SP15 P2', 25);
INSERT INTO public.species_planets VALUES (90, 279, 'SP15 P5', 26);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (297, 'S1', 'Red Dwarf', 'Red', 1000000, 316);
INSERT INTO public.star VALUES (298, 'S2', 'Brown Dwarf', 'Brown', 100000000, 316);
INSERT INTO public.star VALUES (299, 'S3', 'Neutron Star', 'White', 1000000, 317);
INSERT INTO public.star VALUES (300, 'S4', 'White Dwarf', 'White', 100000, 317);
INSERT INTO public.star VALUES (301, 'S5', 'Blue Giant', 'Blue', 10000000000, 317);
INSERT INTO public.star VALUES (302, 'S6', 'Red Giant', 'Red', 1000000000, 318);
INSERT INTO public.star VALUES (303, 'S7', 'Neutron Star', 'White', 100000000000000000000, 318);
INSERT INTO public.star VALUES (304, 'S8', 'Brown Dwarf', 'Brown', 100000000, 318);
INSERT INTO public.star VALUES (305, 'S9', 'Neutron Star', 'White', 1000000, 319);
INSERT INTO public.star VALUES (306, 'S10', 'White Dwarf', 'White', 1000000, 319);
INSERT INTO public.star VALUES (307, 'S11', 'White Dwarf', 'White', 10000, 319);
INSERT INTO public.star VALUES (308, 'S12', 'Blue Giant', 'Blue', 10000000000, 320);
INSERT INTO public.star VALUES (309, 'S13', 'Red Giant', 'Red', 1000000000000, 320);
INSERT INTO public.star VALUES (310, 'S14', 'Red Dwarf', 'Red', 10000000, 320);
INSERT INTO public.star VALUES (311, 'S15', 'Red Dwarf', 'Red', 10000000, 320);
INSERT INTO public.star VALUES (312, 'S16', 'Red Dwarf', 'Red', 100000, 320);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 321, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 246, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 299, true);


--
-- Name: species_moons_species_moons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.species_moons_species_moons_id_seq', 29, true);


--
-- Name: species_planets_species_planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.species_planets_species_planets_id_seq', 26, true);


--
-- Name: species_species_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.species_species_id_seq', 90, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 312, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: species_moons species_moons_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_moons
    ADD CONSTRAINT species_moons_name_key UNIQUE (name);


--
-- Name: species_moons species_moons_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_moons
    ADD CONSTRAINT species_moons_pkey PRIMARY KEY (species_moons_id);


--
-- Name: species species_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_name_key UNIQUE (name);


--
-- Name: species species_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pkey PRIMARY KEY (species_id);


--
-- Name: species_planets species_planets_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_planets
    ADD CONSTRAINT species_planets_name_key UNIQUE (name);


--
-- Name: species_planets species_planets_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_planets
    ADD CONSTRAINT species_planets_pkey PRIMARY KEY (species_planets_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: species_moons species_moons_moon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_moons
    ADD CONSTRAINT species_moons_moon_id_fkey FOREIGN KEY (moon_id) REFERENCES public.moon(moon_id);


--
-- Name: species_moons species_moons_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_moons
    ADD CONSTRAINT species_moons_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- Name: species_planets species_planets_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_planets
    ADD CONSTRAINT species_planets_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: species_planets species_planets_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_planets
    ADD CONSTRAINT species_planets_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(species_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--


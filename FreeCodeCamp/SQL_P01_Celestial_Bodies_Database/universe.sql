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
    moon_id integer NOT NULL
);


ALTER TABLE public.species_moons OWNER TO freecodecamp;

--
-- Name: species_planets; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.species_planets (
    species_id integer NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.species_planets OWNER TO freecodecamp;

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
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (311, 'G1', 123456789123456789123, 'Spiral', 1000000000000);
INSERT INTO public.galaxy VALUES (312, 'G2', 321654987321654987, 'Spherical', 1000000000000000);
INSERT INTO public.galaxy VALUES (313, 'G3', 741852963741852963741852963, 'Spiral', 5000000000000);
INSERT INTO public.galaxy VALUES (314, 'G4', 369258147369258147, 'Elliptical', 10000000000);
INSERT INTO public.galaxy VALUES (315, 'G5', 96385252741963852741, 'Irregular', 1000000000000000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (197, 250, 'M1', 5, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (198, 250, 'M2', 500, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (199, 250, 'M3', 9000, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (200, 250, 'M4', 1, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (201, 250, 'M5', 324, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (202, 250, 'M6', 795, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (203, 254, 'M7', 6541, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (204, 254, 'M8', 13265, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (205, 254, 'M9', 7888, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (206, 254, 'M10', 954, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (207, 254, 'M11', 70230, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (208, 255, 'M12', 109, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (209, 257, 'M13', 90087, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (210, 257, 'M14', 452, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (211, 257, 'M15', 690, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (212, 257, 'M16', 98, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (213, 259, 'M17', 51, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (214, 264, 'M18', 1, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (215, 264, 'M19', 449, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (216, 269, 'M20', 1190, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (217, 269, 'M21', 3, 'Ipsum lorem ipsus lalala', false);
INSERT INTO public.moon VALUES (218, 269, 'M22', 30, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (219, 269, 'M23', 56, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (220, 269, 'M24', 5, 'Ipsum lorem ipsus lalala', true);
INSERT INTO public.moon VALUES (221, 269, 'M25', 79, 'Ipsum lorem ipsus lalala', true);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (250, 281, 'P1', 'Gas Giant', 'Ipsum lorem ipsus lalala', true, 100, 25);
INSERT INTO public.planet VALUES (251, 281, 'P2', 'Ice Giant', 'Ipsum lorem ipsus lalala', true, 500, 250);
INSERT INTO public.planet VALUES (252, 283, 'P3', 'Ocean Planet', 'Ipsum lorem ipsus lalala', true, 25, 2500);
INSERT INTO public.planet VALUES (253, 283, 'P4', 'Super Earth', 'Ipsum lorem ipsus lalala', true, 924, 25000);
INSERT INTO public.planet VALUES (254, 283, 'P5', 'Ice Planet', 'Ipsum lorem ipsus lalala', true, 18972, 94);
INSERT INTO public.planet VALUES (255, 285, 'P6', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', false, 23, 9);
INSERT INTO public.planet VALUES (256, 286, 'P7', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 445, 666);
INSERT INTO public.planet VALUES (257, 287, 'P8', 'Ocean Planet', 'Ipsum lorem ipsus lalala', false, 10, 584);
INSERT INTO public.planet VALUES (258, 287, 'P9', 'Gas Giant', 'Ipsum lorem ipsus lalala', true, 9888, 14);
INSERT INTO public.planet VALUES (259, 289, 'P10', 'Ice Planet', 'Ipsum lorem ipsus lalala', true, 7777, 736);
INSERT INTO public.planet VALUES (260, 289, 'P11', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', true, 1111, 932);
INSERT INTO public.planet VALUES (261, 289, 'P12', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 2222, 568);
INSERT INTO public.planet VALUES (262, 290, 'P13', 'Gas Giant', 'Ipsum lorem ipsus lalala', false, 5241, 7779);
INSERT INTO public.planet VALUES (263, 291, 'P14', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 23, 6652);
INSERT INTO public.planet VALUES (264, 292, 'P15', 'Ocean Planet', 'Ipsum lorem ipsus lalala', true, 6, 3214);
INSERT INTO public.planet VALUES (265, 294, 'P16', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', false, 8, 74);
INSERT INTO public.planet VALUES (266, 294, 'P17', 'Ice Giant', 'Ipsum lorem ipsus lalala', false, 90, 48);
INSERT INTO public.planet VALUES (267, 294, 'P18', 'Ocean Planet', 'Ipsum lorem ipsus lalala', true, 41, 9);
INSERT INTO public.planet VALUES (268, 296, 'P19', 'Gas Giant', 'Ipsum lorem ipsus lalala', true, 12, 5);
INSERT INTO public.planet VALUES (269, 296, 'P20', 'Ice Planet', 'Ipsum lorem ipsus lalala', false, 12, 1);
INSERT INTO public.planet VALUES (270, 296, 'P21', 'Super Earth', 'Ipsum lorem ipsus lalala', true, 4, 233);
INSERT INTO public.planet VALUES (271, 296, 'P22', 'Ice Planet', 'Ipsum lorem ipsus lalala', false, 4, 664);
INSERT INTO public.planet VALUES (272, 296, 'P23', 'Dwarf Planet', 'Ipsum lorem ipsus lalala', true, 4, 78);
INSERT INTO public.planet VALUES (273, 296, 'P24', 'Ice Giant', 'Ipsum lorem ipsus lalala', true, 80, 995);
INSERT INTO public.planet VALUES (274, 296, 'P25', 'Ice Giant', 'Ipsum lorem ipsus lalala', true, 80, 2);


--
-- Data for Name: species; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species VALUES (61, 'SP1', 1.15, 150, true);
INSERT INTO public.species VALUES (62, 'SP2', 2.3, 100, false);
INSERT INTO public.species VALUES (63, 'SP3', 3.2, 500, true);
INSERT INTO public.species VALUES (64, 'SP4', 0.8, 100, false);
INSERT INTO public.species VALUES (65, 'SP5', 0.1, 200, false);
INSERT INTO public.species VALUES (66, 'SP6', 1.9, 10, true);
INSERT INTO public.species VALUES (67, 'SP7', 4, 50, true);
INSERT INTO public.species VALUES (68, 'SP8', 10, 50, true);
INSERT INTO public.species VALUES (69, 'SP9', 0.1, 80, false);
INSERT INTO public.species VALUES (70, 'SP10', 5, 9, false);
INSERT INTO public.species VALUES (71, 'SP11', 1, 400, true);
INSERT INTO public.species VALUES (72, 'SP12', 2, 15, false);
INSERT INTO public.species VALUES (73, 'SP13', 3, 160, true);
INSERT INTO public.species VALUES (74, 'SP14', 4, 40, false);
INSERT INTO public.species VALUES (75, 'SP15', 5, 5, true);


--
-- Data for Name: species_moons; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species_moons VALUES (61, 197);
INSERT INTO public.species_moons VALUES (61, 198);
INSERT INTO public.species_moons VALUES (61, 199);
INSERT INTO public.species_moons VALUES (61, 202);
INSERT INTO public.species_moons VALUES (62, 197);
INSERT INTO public.species_moons VALUES (62, 199);
INSERT INTO public.species_moons VALUES (62, 202);
INSERT INTO public.species_moons VALUES (63, 200);
INSERT INTO public.species_moons VALUES (63, 204);
INSERT INTO public.species_moons VALUES (63, 205);
INSERT INTO public.species_moons VALUES (63, 221);
INSERT INTO public.species_moons VALUES (64, 209);
INSERT INTO public.species_moons VALUES (65, 203);
INSERT INTO public.species_moons VALUES (65, 204);
INSERT INTO public.species_moons VALUES (65, 205);
INSERT INTO public.species_moons VALUES (65, 206);
INSERT INTO public.species_moons VALUES (67, 213);
INSERT INTO public.species_moons VALUES (68, 215);
INSERT INTO public.species_moons VALUES (69, 213);
INSERT INTO public.species_moons VALUES (70, 218);
INSERT INTO public.species_moons VALUES (70, 219);
INSERT INTO public.species_moons VALUES (71, 209);
INSERT INTO public.species_moons VALUES (71, 210);
INSERT INTO public.species_moons VALUES (73, 203);
INSERT INTO public.species_moons VALUES (73, 210);
INSERT INTO public.species_moons VALUES (73, 216);
INSERT INTO public.species_moons VALUES (73, 221);
INSERT INTO public.species_moons VALUES (74, 202);
INSERT INTO public.species_moons VALUES (75, 213);


--
-- Data for Name: species_planets; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species_planets VALUES (61, 250);
INSERT INTO public.species_planets VALUES (62, 250);
INSERT INTO public.species_planets VALUES (63, 250);
INSERT INTO public.species_planets VALUES (64, 252);
INSERT INTO public.species_planets VALUES (64, 257);
INSERT INTO public.species_planets VALUES (64, 264);
INSERT INTO public.species_planets VALUES (64, 267);
INSERT INTO public.species_planets VALUES (65, 254);
INSERT INTO public.species_planets VALUES (66, 274);
INSERT INTO public.species_planets VALUES (66, 273);
INSERT INTO public.species_planets VALUES (66, 271);
INSERT INTO public.species_planets VALUES (68, 270);
INSERT INTO public.species_planets VALUES (68, 264);
INSERT INTO public.species_planets VALUES (69, 259);
INSERT INTO public.species_planets VALUES (70, 268);
INSERT INTO public.species_planets VALUES (70, 258);
INSERT INTO public.species_planets VALUES (72, 260);
INSERT INTO public.species_planets VALUES (72, 264);
INSERT INTO public.species_planets VALUES (72, 268);
INSERT INTO public.species_planets VALUES (72, 267);
INSERT INTO public.species_planets VALUES (72, 254);
INSERT INTO public.species_planets VALUES (73, 270);
INSERT INTO public.species_planets VALUES (74, 250);
INSERT INTO public.species_planets VALUES (75, 259);
INSERT INTO public.species_planets VALUES (75, 251);
INSERT INTO public.species_planets VALUES (75, 254);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (281, 'S1', 'Red Dwarf', 'Red', 1000000, 311);
INSERT INTO public.star VALUES (282, 'S2', 'Brown Dwarf', 'Brown', 100000000, 311);
INSERT INTO public.star VALUES (283, 'S3', 'Neutron Star', 'White', 1000000, 312);
INSERT INTO public.star VALUES (284, 'S4', 'White Dwarf', 'White', 100000, 312);
INSERT INTO public.star VALUES (285, 'S5', 'Blue Giant', 'Blue', 10000000000, 312);
INSERT INTO public.star VALUES (286, 'S6', 'Red Giant', 'Red', 1000000000, 313);
INSERT INTO public.star VALUES (287, 'S7', 'Neutron Star', 'White', 100000000000000000000, 313);
INSERT INTO public.star VALUES (288, 'S8', 'Brown Dwarf', 'Brown', 100000000, 313);
INSERT INTO public.star VALUES (289, 'S9', 'Neutron Star', 'White', 1000000, 314);
INSERT INTO public.star VALUES (290, 'S10', 'White Dwarf', 'White', 1000000, 314);
INSERT INTO public.star VALUES (291, 'S11', 'White Dwarf', 'White', 10000, 314);
INSERT INTO public.star VALUES (292, 'S12', 'Blue Giant', 'Blue', 10000000000, 315);
INSERT INTO public.star VALUES (293, 'S13', 'Red Giant', 'Red', 1000000000000, 315);
INSERT INTO public.star VALUES (294, 'S14', 'Red Dwarf', 'Red', 10000000, 315);
INSERT INTO public.star VALUES (295, 'S15', 'Red Dwarf', 'Red', 10000000, 315);
INSERT INTO public.star VALUES (296, 'S16', 'Red Dwarf', 'Red', 100000, 315);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 315, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 221, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 274, true);


--
-- Name: species_species_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.species_species_id_seq', 75, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 296, true);


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
-- Name: species_moons species_moons_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_moons
    ADD CONSTRAINT species_moons_pkey PRIMARY KEY (species_id, moon_id);


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
-- Name: species_planets species_planets_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species_planets
    ADD CONSTRAINT species_planets_pkey PRIMARY KEY (species_id, planet_id);


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


--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2024-09-27 21:57:54

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

--
-- TOC entry 3357 (class 1262 OID 16441)
-- Name: hotelbooking; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE hotelbooking WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';


ALTER DATABASE hotelbooking OWNER TO postgres;

\connect hotelbooking

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
-- TOC entry 221 (class 1259 OID 16551)
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    no integer NOT NULL,
    username text,
    password text
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16550)
-- Name: admin_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_no_seq OWNER TO postgres;

--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_no_seq OWNED BY public.admin.no;


--
-- TOC entry 219 (class 1259 OID 16461)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    ono integer NOT NULL,
    sno integer,
    username text,
    rno integer,
    roomname text,
    date date,
    price bigint
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16460)
-- Name: orders_ono_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_ono_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_ono_seq OWNER TO postgres;

--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 218
-- Name: orders_ono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_ono_seq OWNED BY public.orders.ono;


--
-- TOC entry 215 (class 1259 OID 16443)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    rno integer NOT NULL,
    roomname text,
    shortdesc text,
    longdesc text,
    occupancy integer,
    price integer
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16442)
-- Name: rooms_rno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_rno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_rno_seq OWNER TO postgres;

--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 214
-- Name: rooms_rno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_rno_seq OWNED BY public.rooms.rno;


--
-- TOC entry 217 (class 1259 OID 16452)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    sno integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    name text,
    age integer,
    phoneno bigint
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16451)
-- Name: users_sno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_sno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_sno_seq OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_sno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_sno_seq OWNED BY public.users.sno;


--
-- TOC entry 3191 (class 2604 OID 16554)
-- Name: admin no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN no SET DEFAULT nextval('public.admin_no_seq'::regclass);


--
-- TOC entry 3190 (class 2604 OID 16464)
-- Name: orders ono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN ono SET DEFAULT nextval('public.orders_ono_seq'::regclass);


--
-- TOC entry 3188 (class 2604 OID 16446)
-- Name: rooms rno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN rno SET DEFAULT nextval('public.rooms_rno_seq'::regclass);


--
-- TOC entry 3189 (class 2604 OID 16455)
-- Name: users sno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN sno SET DEFAULT nextval('public.users_sno_seq'::regclass);


--
-- TOC entry 3351 (class 0 OID 16551)
-- Dependencies: 221
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admin VALUES (1, 'admin@apice', 'admin123');


--
-- TOC entry 3349 (class 0 OID 16461)
-- Dependencies: 219
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (114, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (115, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (116, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (117, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (118, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (119, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (120, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (121, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (122, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (123, 23, 'chris@gmail.com', 1, 'Deluxe room', '2024-09-18', 1200);
INSERT INTO public.orders VALUES (124, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (125, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (126, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (14, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (15, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (16, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (17, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (18, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (19, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (20, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (21, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (22, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (23, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (24, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (25, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (26, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (27, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (28, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (29, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (30, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (31, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (32, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (33, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (34, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (35, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (36, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (37, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (38, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (39, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (40, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (41, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (42, 16, 'technicalclipper@gmail.com', 3, 'Suite room', '2024-09-14', 4100);
INSERT INTO public.orders VALUES (43, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (44, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (45, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (46, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (47, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (48, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (49, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (50, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (51, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (52, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (53, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (127, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (128, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (129, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (130, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (131, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (132, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (133, 23, 'chris@gmail.com', 2, 'Super Deluxe room', '2024-09-18', 2300);
INSERT INTO public.orders VALUES (134, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (135, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (136, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (137, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (138, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (139, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (140, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (141, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (142, 23, 'chris@gmail.com', 3, 'Suite room', '2024-09-18', 4100);
INSERT INTO public.orders VALUES (143, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (144, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (145, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (146, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (147, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (148, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (149, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (150, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (151, 23, 'chris@gmail.com', 4, 'Lounge room', '2024-09-18', 6400);
INSERT INTO public.orders VALUES (152, 23, 'chris@gmail.com', 5, 'Beach view room', '2024-09-18', 8000);
INSERT INTO public.orders VALUES (153, 23, 'chris@gmail.com', 5, 'Beach view room', '2024-09-18', 8000);
INSERT INTO public.orders VALUES (155, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-27', 6400);
INSERT INTO public.orders VALUES (156, 26, 'beschi@gmail.com', 4, 'Lounge room', '2024-09-27', 6400);
INSERT INTO public.orders VALUES (157, 26, 'beschi@gmail.com', 4, 'Lounge room', '2024-09-27', 6400);
INSERT INTO public.orders VALUES (159, 26, 'beschi@gmail.com', 3, 'Suite room', '2024-09-27', 4100);
INSERT INTO public.orders VALUES (160, 26, 'beschi@gmail.com', 3, 'Suite room', '2024-09-27', 4100);
INSERT INTO public.orders VALUES (161, 26, 'beschi@gmail.com', 5, 'Beach view room', '2024-09-28', 8000);
INSERT INTO public.orders VALUES (104, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (105, 16, 'technicalclipper@gmail.com', 1, 'Deluxe room', '2024-09-14', 1200);
INSERT INTO public.orders VALUES (106, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (107, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-14', 2300);
INSERT INTO public.orders VALUES (108, 16, 'technicalclipper@gmail.com', 4, 'Lounge room', '2024-09-14', 6400);
INSERT INTO public.orders VALUES (109, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (110, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (111, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (112, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (113, 16, 'technicalclipper@gmail.com', 5, 'Beach view room', '2024-09-14', 8000);
INSERT INTO public.orders VALUES (154, 16, 'technicalclipper@gmail.com', 2, 'Super Deluxe room', '2024-09-13', 2300);
INSERT INTO public.orders VALUES (158, 26, 'beschi@gmail.com', 5, 'Beach view room', '2024-09-30', 8000);


--
-- TOC entry 3345 (class 0 OID 16443)
-- Dependencies: 215
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rooms VALUES (5, 'Beach view room', 'Experience the ultimate coastal retreat with our Beach View Room. Enjoy stunning ocean views through expansive windows and relax in a king-size bed with premium linens. ', 'Our Beach View Room offers a serene retreat with breathtaking views of the ocean, making it the perfect choice for guests who want to immerse themselves in the beauty of the seaside. This room is designed to maximize comfort while offering panoramic views of the beach from large floor-to-ceiling windows, filling the space with natural light and the soothing sounds of the waves.', 2, 8000);
INSERT INTO public.rooms VALUES (2, 'Super Deluxe room', 'A luxurious super deluxe room featuring premium furnishings, advanced amenities, a plush king-size bed, and a private balcony with stunning views.', 'Our Super Deluxe Room offers a truly luxurious experience for guests seeking an elevated stay. This spacious room is tastefully decorated with sophisticated, modern furnishings and a neutral color palette that exudes warmth and elegance. The room features a plush king-size bed with high-quality linens, ensuring maximum comfort and relaxation.', 3, 2300);
INSERT INTO public.rooms VALUES (3, 'Suite room', 'A spacious suite room featuring separate living areas, luxury furnishings, king-size bed, and modern amenities for ultimate comfort and privacy.', 'Experience the pinnacle of luxury in our elegantly designed Suite Room, offering an unparalleled stay with exceptional comfort and spacious living. Perfect for both leisure and business travelers, the suite spans across a generous floor plan, featuring a separate living area and bedroom for added privacy and convenience. The room’s modern décor, complemented by rich textures and warm tones, creates a soothing atmosphere that welcomes guests to relax and unwind.', 4, 4100);
INSERT INTO public.rooms VALUES (4, 'Lounge room', 'The lounge room offers a relaxing ambiance with plush seating, modern decor, and a calm atmosphere, perfect for unwinding.', 'Our Lounge Room is designed for guests seeking a perfect blend of relaxation and casual luxury. This spacious, open-concept room offers a versatile living area, ideal for socializing or simply unwinding after a long day. The room features plush seating, including a comfortable sofa and armchairs, perfect for lounging while watching the large flat-screen TV or enjoying some quiet time with a book. The contemporary décor, combined with soft lighting and neutral tones, creates a calming and welcoming ambiance.', 5, 6400);
INSERT INTO public.rooms VALUES (1, 'Deluxe room', 'A spacious deluxe room offering modern amenities, elegant decor, cozy seating, and a comfortable king-size bed for relaxation.', 'Our Super Deluxe Room offers a truly luxurious experience for guests seeking an elevated stay. This spacious room is tastefully decorated with sophisticated, modern furnishings and a neutral color palette that exudes warmth and elegance. The room features a plush king-size bed with high-quality linens, ensuring maximum comfort and relaxation.<', 2, 1200);


--
-- TOC entry 3347 (class 0 OID 16452)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (16, 'technicalclipper@gmail.com', '$2b$10$m9g3BkEZGxdTwWLTVRQxVuqh1rjcAWliyd4653h17YQpXtrngp1JC', 'beschi', 19, 6382029254);
INSERT INTO public.users VALUES (17, 'eff', '$2b$10$B4sLtEccE7Fhtn89nb.xTeqf/UodLKICutk3PZC9b/CXgk1TO3VDW', NULL, NULL, NULL);
INSERT INTO public.users VALUES (18, '', '$2b$10$mmgzQMsXrNs2fDXVf9i2BOC4614EnmNJuOLr6.gQplW3ZMyubiENC', NULL, NULL, NULL);
INSERT INTO public.users VALUES (19, 'jensen@gmail.com', '$2b$10$XaxIsyz.dV.Pe5x.cQwkoO4kjDN4LJZnGGDv07RHmnZze3cmodQvW', 'jensen', 18, 35475586979);
INSERT INTO public.users VALUES (20, 'fabian@gmail.com', '$2b$10$upRJ6KTa6LwtHKjxsOQtzOrLU4F9wIZWYDS2mKn31mf8uUK/.ISiu', 'agil fabian', 19, 24546437357);
INSERT INTO public.users VALUES (21, 'adaibes234@gmail.com', '$2b$10$lOFBAUVa0whbCD3RFTzQsuq3PollpLo7btje46ZAIGEG4oaea5hTC', 'adaikal', 18, 6382029254);
INSERT INTO public.users VALUES (22, 'ajaykumar@gmail.com', '$2b$10$RrNMre6YD5Far8bYZvkSUu8TAVlpjXmn/7eOC7rAx8KU5jGOe/OY6', 'ajay kumar', 19, 646447777453);
INSERT INTO public.users VALUES (23, 'chris@gmail.com', '$2b$10$JyrbfhGZtOYFL8n6pOUAPuE/z9F/WZh9HUMqvQ07aZQkdAr544Uwu', 'chris ananth', 19, 325475587768);
INSERT INTO public.users VALUES (24, 'herwin@gmail.com', '$2b$10$EeT12tcDNLVV7XCJFmGajOtlJy9XZx2k2CEyAe5TVe7Y5NlI1vJC2', 'herwin jacob', 20, 54857976954);
INSERT INTO public.users VALUES (25, 'jensen1@gmail.com', '$2b$10$3FuEIlYVckcsHNeydNR7su5slz/s5SY1GiU5SZE.MYs/e84x4.G6W', 'jensen benito', 19, 348657653457);
INSERT INTO public.users VALUES (26, 'beschi@gmail.com', '$2b$10$2LAHMkRDDQKE6v.4Yfg/i.XASQ5ejBpC2eg4067vWBYqflPle0twG', 'beschi', 19, 264675757443);


--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_no_seq', 1, true);


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 218
-- Name: orders_ono_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_ono_seq', 161, true);


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 214
-- Name: rooms_rno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_rno_seq', 1, false);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_sno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_sno_seq', 26, true);


--
-- TOC entry 3199 (class 2606 OID 16558)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (no);


--
-- TOC entry 3197 (class 2606 OID 16468)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (ono);


--
-- TOC entry 3193 (class 2606 OID 16450)
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (rno);


--
-- TOC entry 3195 (class 2606 OID 16459)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (sno);


--
-- TOC entry 3200 (class 2606 OID 16474)
-- Name: orders orders_rno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_rno_fkey FOREIGN KEY (rno) REFERENCES public.rooms(rno);


--
-- TOC entry 3201 (class 2606 OID 16469)
-- Name: orders orders_sno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_sno_fkey FOREIGN KEY (sno) REFERENCES public.users(sno);


-- Completed on 2024-09-27 21:57:54

--
-- PostgreSQL database dump complete
--


CREATE TABLE public.hat_defs (
    id integer PRIMARY KEY,
    name character varying(50) NOT NULL UNIQUE,
    description character varying(300) NOT NULL,
    author_id integer NOT NULL,
    price integer NOT NULL
);

CREATE SEQUENCE public.hat_defs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.hat_defs_id_seq OWNED BY public.hat_defs.id;

ALTER TABLE ONLY public.hat_defs ALTER COLUMN id SET DEFAULT nextval('public.hat_defs_id_seq'::regclass);

ALTER TABLE ONLY public.hat_defs
    ADD CONSTRAINT hat_defs_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);





CREATE TABLE public.hats (
    hat_id integer NOT NULL,
    user_id integer NOT NULL
);

ALTER TABLE ONLY public.hats
    ADD CONSTRAINT hats_pkey PRIMARY KEY (user_id, hat_id);

ALTER TABLE ONLY public.hats
    ADD CONSTRAINT hats_hat_id_fkey FOREIGN KEY (hat_id) REFERENCES public.hat_defs(id);

ALTER TABLE ONLY public.hats
    ADD CONSTRAINT hats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);

alter table users add column coins_spent_on_hats integer DEFAULT 0 NOT NULL;
alter table users add column equipped_hat_id integer;
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_equipped_hat_id_fkey FOREIGN KEY (equipped_hat_id) REFERENCES public.hat_defs(id);

insert into hat_defs (name, description, author_id, price) values
('Ushanka', 'The People''s Hat', 1, 500), 
('Fur Hat', 'The first step on your path to fursuit ownership', 1, 500), 
('Cat Ears I', 'Mew :3', 1, 500),
('Cat Ears II', 'Meow :3', 1, 500),
('Playboy Bunny', 'Will this bring daddy back?', 1, 500),
('Macaroni', 'Get it? Like the song lol', 1, 500),
('Pirate', 'BUTT pirate', 1, 500),
('Pirate Captain', 'Like a regular butt pirate, but for tops only', 1, 500),
('Dreads', 'Finally, an excuse for poor hygiene', 1, 500),
('The XXXTentacion', 'Pay homage to your favorite dead criminal!', 1, 500),
('the 6ix9ine', 'The finest piece of snitch couture on the market', 1, 500),
('The Elvis', 'Remember when this dude nailed a 13-year-old?', 1, 500),
('Gussy Hat', 'Let everyone know that you''re NOT a rapist. Honest.', 1, 500),
('Riveter', 'Can you do it? Really?', 1, 500),
('Top Hat (leprechaun)', 'LLM but Irish', 1, 500),
('Drinky Beer Hat', 'I actually didn''t know these were real things until I made this', 1, 500),
('Viking', 'Rape, pillage, never bathe. Live the dream.', 1, 500),
('Nonspecific Military Officer Hat', '[removed]', 1, 1000),
('Soviet Officer I', 'OUR hat', 1, 1000),
('Nonspecific Military Officer Hat II', '[removed]', 1, 1000),
('Soviet Officer II', 'High fashion war criminal chic', 1, 1000),
('Southern Gentleman', 'Slaveowner? Fried chicken chain founder? You decide!', 1, 500),
('Cowboy I', 'Make him wish he could quit you', 1, 500),
('Cowboy II', 'You''re my favorite deputy!', 1, 500),
('Halo', 'Dramamine criticized this one and now I''m too self-conscious about it to write a description', 1, 500),
('Fedora I', 'M''arsey', 1, 500),
('Bowler', 'Why would you need a hat to go bowling?', 1, 500),
('Du Rag (black)', 'Shitty bandana 1/6', 1, 500),
('Du Rag (red)', 'Shitty bandana 2/6', 1, 500),
('Du Rag (blue)', 'Shitty bandana 3/6', 1, 500),
('Du Rag (purple)', 'Shitty bandana 4/6', 1, 500),
('Du Rag (green)', 'Shitty bandana 5/6', 1, 500),
('Du Rag (yellow)', 'Shitty bandana 6/6', 1, 500),
('Ash Ketchum', 'You''re not so different, you and he', 1, 500),
('The Hotep', 'Traditional kangwear. POC ONLY.', 1, 500),
('Roman', 'Reddit delenda est', 1, 500),
('Confederate Soldier Cap', 'Basically the Gryffindor of American history', 1, 500),
('Northern Aggressor Soldier Cap', 'Slytherin irl', 1, 500),
('Rhodesian Light Infantry Beret', 'Rhodesians never die. Immortality guaranteed!', 1, 500),
('Magyar Headdress', 'Channel your inner QuadNarca and join Orban''s elite cavalry', 1, 500),
('The Senator Warren', 'heya heya heya heya heya heya heya heya heya heya heya', 1, 500),
('Please Be Patient I Have Autism', 'The OFFICIAL hat of rDrama.net', 1, 500),
('Samurai Helmet', 'Never be mistaken for a baka gaijin again', 1, 500),
('Watermelmet', 'Hydration and head protection all rolled into one stylish headpiece', 1, 500),
('Frankenstein', 'Akshually, Frankenstein was the scientist. The monster didn''t have a name.', 1, 500),
('The Drumpf', 'Orange hair bad', 1, 500),
('Tinfoil Hat', 'Keep Bill Gates'' 5G vaccine OUT of your precious brain!', 1, 500),
('Fez', 'Isn''t it CUTE?', 1, 500),
('Ching Chong', 'Me Chinese Me No Dumb Me Stick Finger In Daddy''s Bum', 1, 500),
('Octopus Friend', 'Awwwwwww!', 1, 500),
('In The Navy', 'It''s not gay', 1, 500),
('Seaman', 'semen lol', 1, 500),
('Flower Crown I', 'oh god i have to write descriptions for 15 flower crowns', 1, 500),
('Flower Crown II', 'A very cute flower crown', 1, 500),
('Flower Crown III', 'A super cute flower crown', 1, 500),
('Flower Crown IV', 'A really cute flower crown', 1, 500),
('Flower Crown V', 'The cutest flower crown?', 1, 500),
('Flower Crown VI', 'An extremely cute flower crown', 1, 500),
('Flower Crown VII', 'A flower crown that''s just so cute', 1, 500),
('Flower Crown VIII', 'A majorly cute flower crown', 1, 500),
('Flower Crown IX', 'A mega cute flower crown', 1, 500),
('Flower Crown X', 'An ultra cute flower crown', 1, 500),
('Flower Crown XI', 'Definitely the cutest flower crown', 1, 500),
('Flower Crown XII', 'A hella cute flower crown', 1, 500),
('Flower Crown XIII', 'An experimental anti-gravity cute flower crown', 1, 500),
('Flower Crown XIV', 'An adorably cute flower crown', 1, 500),
('Flower Crown XV', 'The final cute flower crown', 1, 500),
('Bow', 'What a cute little bow omg', 1, 500),
('BIPOCsmoke', 'It''s a Newport. You know it''s a Newport.', 1, 500),
('Gigachin', 'Aw yeah, this user definitely supports trans rights', 1, 500),
('Queensguard', 'A bear died for this', 1, 500),
('Queen Crown', 'Don''t be a drag', 1, 500),
('King Crown', 'King is like the n word, only racists and black people should be allowed to say it', 1, 500),
('Pope Hat', 'Matthew 16:18', 1, 500),
('Heebhead', 'Do NOT google the Lavon Affair', 1, 500),
('Zoomie Zoom Zoom', 'Underage user, do not interact', 1, 500),
('Sombrero I', 'El Autistico', 1, 500),
('Sombrero II', 'El Autistico Grandisimo', 1, 500),
('Crypto Billionaire', 'Sorry about the ice cream machine', 1, 500),
('Burger King Crown', 'I''m gonna say it', 1, 500),
('Burger King', 'You can have it your way and you still chose this', 1, 500),
('Wendys', 'Sassy social media intern', 1, 500),
('KFC', 'Popeyes is too far away', 1, 500),
('In-N-Out', 'Kill the commiefornian', 1, 500),
('Carls Jr', 'Purveyor of literally the finest food in the world', 1, 500),
('Whataburger', 'Texans don''t know any better', 1, 500),
('Five Guys', 'I love having 5 guys in my mouth', 1, 500),
('Taco Bell', 'Enabler of drunken mistakes', 1, 500),
('Marsey-In-A-Box', 'Awww you''re playing make-believe!', 1, 500),
('Orthodox Hood', 'User is a schismatic lunatic', 1, 500),
('Afro', 'Pool''s closed motherlover', 1, 500),
('Top Hat (black)', 'Traditional. Classy. Elegant.', 1, 500),
('Wizard I', 'Three decades a KHHV', 1, 500),
('Wizard II', 'Avada kedavra ✨', 1, 500),
('Witch I', 'Hex the patriarchy', 1, 500),
('Witch II', 'Bardfinn cosplay gear', 1, 500),
('Sun Hat', 'Tradwife simplicity', 1, 500),
('Obey Snapback', 'The timeless classic', 1, 500),
('Thug Life Snapback', 'User confirmed mayo', 1, 500),
('Supreme Snapback', 'Drip so  hard ong', 1, 500),
('Make America Great Again', 'The official headgear of stochastic terrorists everywhere', 1, 500),
('Born To Feel', 'Do you pee standing up?', 1, 500),
('Fortunate Son', 'BORN TO SHIT FORCED TO WIPE', 1, 500),
('WWI', 'How is this supposed to offer any meaningful protection??', 1, 500),
('Pickelhaube', 'Inarguably the most fashionable of all contemporary military headgear ', 1, 500),
('Wehrmacht', 'What a cool helmet, I bet the people who wore it were real classy folks ', 1, 500),
('Chair Force', 'Yeah I''m a combat veteran, I''ve seen shit you wouldn''t believe. One time the wifi was out for almost an hour. ', 1, 500),
('Helmet w Dog Tags', 'More like dog fags lol', 1, 500),
('Urban Camo Helmet', 'Man urban camo is cool', 1, 500),
('Nightvision Helmet', 'Four-eyed freak', 1, 500),
('Helmet w Mesh', 'Sexy fishnet stocking helmet', 1, 500),
('Tojo Helmet', 'Artifact from Weeb War II', 1, 500),
('Officers Cap', 'Get fragged bozo', 1, 500),
('Jailbird Cap', 'The apex of prison fashion. Why did we stop using this?', 1, 500),
('P-Hat (green)', 'Zezima fanboy', 1, 500),
('P-Hat (red)', 'おれはPigAmericanですおれはばか i am average american man i enjoy bad game runescape', 1, 500),
('P-Hat (yellow)', 'PISS HAT PISS HAT', 1, 500),
('P-Hat (blue)', 'Ughhhh coming up with different descriptions for RuneScape party hats', 1, 500),
('P-Hat (pink)', 'It''s pink.', 1, 500),
('P-Hat (rainbow)', 'LGBTscape 😍', 1, 500),
('Newsboy', 'Or newsgirl. It''s okay, the hat is actually gender-neutral.', 1, 500),
('Whirly Tard Hat I', 'Wouldn''t it be neat if they could make one that like uses body heat or whatever to keep the propeller in a state of constant motion', 1, 500),
('Dunce Cap', 'You retard. Imbecile. Utter buffoon. Oaf. Nincompoop. Idiot. Moron. CLOWN.', 1, 500),
('Beret', 'Literally the most basic possible hat choice. Please do better. ', 1, 500),
('Mario', 'BING BING WAHOO ', 1, 500),
('Luigi', 'LING LING LAHOO', 1, 500),
('Wing Cap', 'If the hat''s wings are what provide the thrust necessary for flight then how does it stay on and let YOU fly with it huh', 1, 500),
('Metal Mario', 'Mario hat but with yelling and lots of double bass and distorted guitars and shit heck yeah', 1, 500),
('Cappy', 'A sentient hat-creature that''s actually a pretty horrifying parasite if you think about it', 1, 500),
('Wario', 'For the fat, yellow, extremely flatulent dramautist (in loving memory of Bidpots)', 1, 500),
('Waluigi', 'Coming soon to Smash for sure', 1, 500),
('Top Hat (kek)', 'Technically a top hat, shut up', 1, 500),
('Top Hat (white)', 'Oh, how dignified', 1, 500),
('Top  Hat (striped)', 'Tim Burton''s take on the top hat', 1, 500),
('Top Hat (checkered)', 'Actually chessed, but that''s not really a word.', 1, 500),
('Top Hat (march hare)', 'April hare, May hare, June hare, July hare,', 1, 500),
('Top Hat (mad hatter)', 'Hatters mad [x24]', 1, 500),
('Top Hat', 'Top hat, menstrual edition', 1, 500),
('Top Hat (uncle sam)', 'THIS HAT WAS FACT-CHECKED BY TRUE AMERICAN PATRIOTS', 1, 500),
('Fireperson I', 'In loving memory of r/HateForFirefighters', 1, 500),
('Constable', 'Useless bong cop nonsense', 1, 500),
('NYPD Officer', 'This user is authorized to stop, frisk and cavity search you at any time for any reason', 1, 500),
('Crossing Guard', 'We love Officer Marsey!', 1, 500),
('Paper Sailor', 'As idle as a paper ship, upon a paper ocean. Paper, paper, everywhere.', 1, 500),
('FBI', 'Federal Bussy Inspector', 1, 500),
('CIA', 'Cisgender Incineration Agency', 1, 500),
('ATF', 'Ass-Tickling Faggot. HIDE YOUR DOG!', 1, 500),
('Graduate', 'This hat signifies that the bearer has completed four (4) years of pan-african gender studies coursework', 1, 500),
('Nurse', 'Minor TikTok celebrity, OnlyFans top 91%', 1, 500),
('Farmer', 'Feed & Seed shopper', 1, 500),
('Farmette', 'Feed & Seed shoppette', 1, 500),
('Kung Lao', 'Why did I make a Kung Lao hat', 1, 500),
('Top Hat (steampunk)', 'Like a regular top hat but with goggles and gears', 1, 500),
('Brain Hat', 'Peter Griffin''s dog', 1, 500),
('The TED_SIMP', 'Wear this hat to express your undying adoration for carp', 1, 500),
('The Brandon', 'Listen here fat', 1, 500),
('The Brandon II', 'LISTEN HRE FAT', 1, 500),
('The King George', 'Proto-drag if you think about it', 1, 500),
('The Mao', 'Our hair!', 1, 500),
('The Young Stalin', 'Pockmarks not included', 1, 500),
('The Ripe Stalin', 'An homage to the #1 most prolific killer of commies in world history', 1, 500),
('The Austrian Painter', 'For aficionados of mid-20th century fine artists slash authors', 1, 500),
('Kenny I', 'User''s life insurance claim was rejected', 1, 500),
('Modern Major General', 'For my military knowledge, though I''m plucky and adventury / Has only been brought down to the beginning of the century / But still, in matters vegetable, animal, and mineral / I am the very model of a modern Major-General', 1, 500),
('Red Star Cap', 'Cannon fodder', 1, 500),
('Cartman', 'Fat antisemite - the archetypal rDrama user', 1, 500),
('Cheesehead', 'For fans of the Green Gay Fudge Packers', 1, 500),
('Kyle', 'ngl I don''t watch South Park so idk the difference between this and Stan', 1, 500),
('Stan', 'ngl I don''t watch South Park so idk the difference between this and Kyle', 1, 500),
('Kenny II', 'Like Kenny I except it shows more of your ugly face', 1, 500),
('The Cleopatra', 'Did you know she was actually white?', 1, 500),
('Pimp Hat I', 'Women are objects', 1, 500),
('Devil Horns', 'Satan is so cool and quirky!!!', 1, 500),
('Nooticer', 'THIS USER IS ENGAGED IN THOUGHTCRIME. DO NOT INTERACT.', 1, 500),
('Airpods', 'oh god oh fuck he cant hear us', 1, 500),
('Maskmaxxer', 'Why aren''t there two? Are you trying to kill us?', 1, 500),
('The Tupac', 'dead nigger storage', 1, 500),
('Media Executive', 'despite making up just 2% of the population,', 1, 500),
('Surgeon', 'Lobotomize me daddy', 1, 500),
('Mouseketeer', 'please don''t sue please don''t sue please don''t sue please don''t sue please don''t sue', 1, 500),
('Karen', 'Let me speak to your manager', 1, 500),
('Badass Fighter Ace', ' Top Gun™ Maverick® Now Showing In Theaters!', 1, 500),
('Taqiyah', 'It''s not a yarmulke I swear', 1, 500),
('Cock', 'DM me yours!', 1, 500),
('Nervous, Sweating', '>mfw', 1, 500),
('The Cat', 'does this really need a description', 1, 500),
('Noose', 'Cope or rope', 1, 500),
('The Penny', 'This shower cap bonnet is perfect for hiding nappy, alopecia-ridden hair', 1, 500),
('Hard Hat (yellow)', 'A rock hard, throbbing, veiny hat. Check out the girth on this thing', 1, 500),
('Hard Hat (white)', 'The mayo variant of the hard hat, used to signify someone of importance, or a visitor, at a job site', 1, 500),
('Beret (TF2)', 'Stylish vidya-variant of the beret', 1, 500),
('Texas Ten Gallon', 'Yeehaw!', 1, 500),
('Demoman', 'KaBOOM', 1, 500),
('Fireperson II', 'For extinguishing hot threads', 1, 500),
('Miners Hat', 'Please don''t touch minors', 1, 500),
('Old Man Hat', 'AKA the Wizdumb', 1, 500),
('Pimp Hat II', 'Women are people and they deserve respect just kidding they should suck my penis', 1, 500),
('Whirly Tard Hat II', 'Propeller go brrrrrrrrrr', 1, 500),
('Family Man Free Hat', 'It''s a good show!', 1, 500),
('Engineer', 'Choo choo!', 1, 500),
('Vexillaurius Helmet', 'Degenerates like you belong on rDrama', 1, 500),
('Astronaut Helmet', 'See you, space marsey', 1, 500);
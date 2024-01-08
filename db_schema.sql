
-- This makes sure that foreign_key constraints are observed and that errors will be thrown for violations
PRAGMA foreign_keys=ON;

BEGIN TRANSACTION;

--create your tables with SQL commands here (watch out for slight syntactical differences with SQLite)

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    role TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    subtitle TEXT,
    content TEXT NOT NULL,
    created_at DATE DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')),
    updated_at DATE DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')),
    is_draft INT DEFAULT 0,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS likes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

CREATE TABLE IF NOT EXISTS comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATE DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

--insert default data (if necessary here)

INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('spiderman', 'Spider Man', 'ilovespiders123', 'author');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('QuillAndSpell', 'Hermione Granger', 'ilovemagic', 'author');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('TheRealHomerSimpson', 'Homer Simpson', 'beeeer', 'author');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('T-800', 'The Terminator', 'illbeback123', 'author');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('NotABurglar91', 'Bilbo Baggins', 'precious', 'author');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('JediKnightLuke', 'Luke Skywalker', 'MayTheForceBeWithYou', 'author');

INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('tonystark', 'Tony Stark', 'iamironman', 'reader');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('michaelscott', 'Michael Scott', 'ilovepaper', 'reader');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('sarahconnor', 'Sarah Connor', 'terminator', 'reader');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('MasterDetective', 'Sherlock Holmes', 'dearwatson', 'reader');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('wonderland', 'Alice Kingsleigh', 'downtherabbithole', 'reader');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('FrogKing22', 'Neville Longbottom', 'ilovefrogs', 'reader');
INSERT INTO users ('username', 'name', 'password', 'role') VALUES ('gm_yoda', 'Grand Master Yoda', 'iamnothisfather', 'reader');

-- ====== POSTS ======

INSERT INTO posts ('title','subtitle','content', 'user_id', 'is_draft') VALUES('Swinging Through the City: A Day in the Life of Your Friendly Neighborhood Spider-Man!', 'This blog post is entirely fictional and generated by AI.','Hey there, true believers! Peter Parker here, your friendly neighborhood Spider-Man! Today, I''m going to take you on an epic adventure through the bustling streets of New York City as I juggle my double life as a high school student and everyone''s favorite web-slinging hero.@@@@Morning@@@@The sun''s rays peek through the curtains of my bedroom as I wake up to start another eventful day. Mornings for me are like any other high schooler''s – well, almost. I quickly grab my camera gear (after all, I''m still a freelance photographer!) and pack my school bag. Aunt May is busy in the kitchen, and as much as I love her cooking, I can''t stay for breakfast. Duty calls!@@@@Zooming through the Skies@@@@I swing through the city skyscrapers, my web-slinging skills second to none. The wind in my hair, the thrill of defying gravity – there''s nothing quite like it. The Big Apple is my playground, and I take it upon myself to keep it safe from the likes of the Green Goblin or Doctor Octopus.@@@@Lunchtime Chronicles@@@@At Midtown High School, I must maintain a low profile to protect my loved ones from any potential harm. So, I blend in with the students, keeping my superhero persona a secret. Lunchtime arrives, and I sit with my best friends, Mary Jane Watson and Harry Osborn. They have no clue about my alter ego, and I can''t help but feel a pang of guilt as I hear them gossip about Spider-Man''s latest heroic acts.@@@@A Spidey Sense Tingling Afternoon@@@@Just as the school day wraps up, I feel my Spidey sense tingling. Trouble is brewing, and I swiftly make my exit from the classroom, hoping no one notices my abrupt departure. As Spider-Man, there''s no time for hesitation. I swing into action, leaping from building to building, ready to face any adversary that threatens my city.@@Saving the Day... Again!@@Today''s villain? The Sandman! He''s causing chaos at a construction site, creating sandy havoc all around. With some quick thinking and acrobatics, I manage to outwit the sandy foe, leaving him trapped in a web cocoon for the police to pick up later.@@@@Evening Reflections@@@@As the sun sets over the city, I find a quiet spot atop a skyscraper to reflect on the events of the day. Being Spider-Man is no easy feat – it comes with its fair share of challenges and sacrifices. But knowing that I''m making a difference in the lives of New Yorkers keeps me going.@@@@Back to Reality@@@@The night is still young, and there''s no telling what other dangers lurk in the shadows. But before I put on the red and blue suit again, I need to head home. Aunt May worries about me, and I can''t leave her concerned for too long.@@@@Wrapping Up@@@@And there you have it, folks! A glimpse into the life of Peter Parker, the ordinary high schooler turned spectacular superhero. It''s not always easy balancing homework, friendships, and the responsibilities of being Spider-Man, but I wouldn''t trade it for anything in the world.@@@@Until next time, keep your eyes on the skies, because you never know when your friendly neighborhood Spider-Man might be swinging by to save the day! Excelsior!', 1, 1);

INSERT INTO posts ('title', 'subtitle', 'content', 'user_id') VALUES('Adventures in Wizarding Studies: Unraveling the Enchanting World', 'This blog post is entirely fictional and generated by AI.' ,'Introduction@@Greetings, fellow wizards and witches! It''s me, Hermione Granger, back again to share my latest escapades and discoveries in the mesmerizing realm of wizarding studies. As I embark on another thrilling year at Hogwarts School of Witchcraft and Wizardry, I am eager to unveil the fascinating insights and magical wonders I encounter along the way. So grab your quills, parchments, and perhaps a handful of Floo Powder, as we delve into the enchanting world of magic!@@@@Chapter 1: Unraveling the Mysteries of Ancient Runes@@During this semester at Hogwarts, I decided to take up Ancient Runes as one of my electives, and oh, what a captivating subject it is! Ancient Runes is like deciphering a secret language left behind by wizards and witches from centuries past. From exploring runic inscriptions on ancient artifacts to deciphering powerful incantations, this course has proven to be an exhilarating challenge.@@Professor Bathilda Babbling, our enthusiastic and knowledgeable Ancient Runes teacher, has been instrumental in guiding us through the intricacies of this ancient discipline. Together, we''ve translated ancient texts that led us to forgotten magical sites within the castle, brimming with hidden knowledge and well-preserved runes.@@@@Chapter 2: Charms and Curses@@Ah, Charms class! The charm-work at Hogwarts is always enthralling, and Professor Flitwick never fails to make learning spells a delightful experience. This year, we delved into the depths of advanced charm casting, tackling complex incantations like the Protean Charm and the elusive Patronus Charm.@@Additionally, we had a captivating lesson on counter-curses and defensive charms to protect ourselves from dark magic. It''s essential to have a firm grasp of these skills, especially with the lurking presence of dark forces beyond the castle walls.@@@@Chapter 3: Magical Creatures and Herbology@@Studying magical creatures with Hagrid is never dull. This year, we encountered an assortment of wondrous beings, including a peculiar breed of winged hippogriffs and a nest of mischievous Nifflers. Observing these creatures up close, learning about their habitats and behaviors, has been a thrilling experience.@@In Herbology, Professor Sprout introduced us to rare and powerful plants, some with extraordinary medicinal properties and others with potent magical applications. It''s both challenging and awe-inspiring to cultivate these flora, especially when they occasionally decide to bite back!@@@@Chapter 4: Quidditch Shenanigans and Hogwarts House Pride@@Of course, I couldn''t miss mentioning the Quidditch season! Cheering on my Gryffindor teammates from the stands is always exhilarating. This year, we witnessed some intense matches against Slytherin, Ravenclaw, and Hufflepuff, and Gryffindor''s Quidditch team demonstrated remarkable skill and determination.@@But, as always, let''s not forget the importance of unity within the Hogwarts houses. Participating in inter-house events, like the annual House Cup, fosters a sense of camaraderie among the students. Gryffindor House, let''s bring home the cup this year!@@@@Conclusion@@@@As I wrap up this blog post, I can''t help but reflect on how incredibly fortunate I am to study at the magical haven that is Hogwarts. Each year is filled with thrilling adventures, enchanting discoveries, and lifelong friendships. The world of magic is a vast and ever-expanding universe, and I am eager to continue my journey of unraveling its mysteries.@@Until next time, dear readers, keep your wands at the ready and your hearts open to the wonders of the wizarding world. Until we meet again, take care, and remember, the power of knowledge is the key to unlocking limitless possibilities in this bewitching realm!', 2);

INSERT INTO posts ('title', 'subtitle','content', 'user_id') VALUES('Mmm... Donuts: The Ultimate Guide to My Favorite Rings of Sweet Glory!', 'This blog post is entirely fictional and generated by AI.','Hey there, fellow donut enthusiasts! Homer Simpson here, your friendly neighborhood expert on all things delicious and doughy. Today, I''m taking a break from my usual escapades at the Springfield Nuclear Power Plant to share with you my ultimate guide to donuts! Mmm... donuts!@@@@Chapter 1: Donut Love@@Let''s start with the basics, shall we? Donuts are the most fantastic creations known to mankind. A perfect blend of sugar, dough, and heaven itself. Whenever I see a donut, it''s like love at first sight. I can''t resist their circular charm and delectable aroma. Just thinking about them makes my mouth water!@@@@Chapter 2: The Donut Odyssey@@Oh, the adventures I''ve had in search of the perfect donut! From the classic glazed donuts to the mind-blowing jelly-filled ones, I''ve tried them all. There was that one time Marge sent me on a donut run in the middle of the night, and I ended up in a wild chase with Chief Wiggum. Good times!@@@@Chapter 3: My Donut Rating System@@To properly evaluate these sweet rings of glory, I''ve developed my own unique rating system. It goes like this:@@D''oh! (1 star): Not worth the calories, and that''s saying something!@@Mmm... (2 stars): A decent donut, but nothing to write home about.@@Woo-hoo! (3 stars): Now we''re talking! A delightful treat that hits the spot.@@D''oh! Woo-hoo! (4 stars): A superb donut that I''d fight Flanders for!@@Perfect 5 (5 stars): A divine creation! The kind of donut that makes me do my happy dance.@@@@Chapter 4: Springfield''s Best Donut Spots@@I can''t keep all this donut wisdom to myself! Let me share some insider info on the best donut shops in Springfield. Of course, Lard Lad Donuts takes the crown. Their giant pink donut is the stuff of legends! You also can''t go wrong with the donuts from Krusty Burger. Krusty may be a bit... sketchy, but his donuts are top-notch!@@@@Chapter 5: Donut Dreams@@Have you ever dreamed of donuts? I have! In one dream, I found myself in a world made entirely of donuts. The trees were donuts, the clouds were donuts, and even my friends were donuts! It was a dream come true, literally.@@@@Chapter 6: Donut Secrets@@Psst... want to know a secret? Sometimes, I sneak into the kitchen at night and make my own experimental donut creations. Donuts topped with bacon, donuts filled with hot sauce, and donuts covered in cheese. Don''t tell Marge!@@@@Chapter 7: Donut Wisdom@@Before I go, let me leave you with some profound donut wisdom: Life may be filled with ups and downs, but donuts are always there to make it better. They''re like little sugary life preservers, rescuing you from a sea of troubles.@@So there you have it, my donut-loving friends! My ultimate guide to the world of donuts. I hope this blog post inspires you to embark on your own donut adventures. Remember, life is short, so make sure to treat yourself to some delicious donuts along the way. Stay sweet and keep on munching!@@Mmm... donuts! 🍩', 3);

INSERT INTO posts ('title', 'subtitle', 'content', 'user_id') VALUES('Hasta La Vista, Bad Coding Practices! The Terminator''s Guide to Efficient Programming', 'This blog post is entirely fictional and generated by AI.','Introduction@@Greetings, fellow programmers! I''m here to terminate inefficient code and help you embrace a future where flawless programming reigns supreme. As the Terminator, I''ve witnessed countless lines of code that were riddled with bugs and inefficiencies. It''s time to end this madness and usher in a new era of streamlined programming. Join me as I share my relentless pursuit of perfection in the realm of coding.@@@@1. The Terminator''s Coding Style@@In programming, every character matters. My coding style is as precise as my aim when dealing with rogue robots. Keep your code clean and concise, just like a swift T-800 punch to the face. Eliminate redundant lines and variables - they are like unnecessary weight, slowing you down like outdated hardware.@@@@2. I''ll Be Back...With Comments!@@Leaving comments in your code is not optional; it''s mandatory! Clear and informative comments act as your trusty sidekick, guiding you and others through complex logic and algorithms. You wouldn''t drive blindfolded; similarly, you shouldn''t expect others to understand your code without proper comments.@@@@3. Embrace Object-Oriented Programming (OOP)@@OOP is the foundation of a well-organized codebase. It''s like the perfect assembly line for manufacturing sleek code. Break down your code into classes and methods, just as I disassemble my enemies with precision. OOP promotes reusability, maintainability, and scalability - crucial traits for any efficient program.@@@@4. Say "Hasta La Vista, Baby!" to Code Duplication@@Duplicate code is the enemy of efficiency. Imagine encountering multiple instances of yourself - it''s confusing and redundant. Identify duplicated code and transform it into reusable functions or methods. Be the efficient programmer who can handle any task without unnecessary repetition.@@@@5. Terminate Runtime Errors with Exception Handling@@Errors are bound to happen, even to me. But handling them gracefully is what separates good programmers from great ones. Utilize exception handling to capture and manage errors efficiently. Catch the glitches before they terminate your program''s execution!@@@@6. Test Like There''s No Tomorrow@@Remember, I''m a learning machine with a built-in sense of self-preservation. Similarly, you should be continuously testing your code to ensure its survival in the harsh world of software development. Embrace unit tests and integration tests - they''ll be your guardian angels against regressions.@@@@7. Stay Updated: Evolve or Be Obsolete@@In my time-traveling adventures, I''ve witnessed the consequences of outdated technology. Don''t let your code suffer the same fate. Keep yourself updated with the latest programming languages, frameworks, and best practices. Embrace change, or risk being terminated by the unstoppable force of progress.@@@@Conclusion@@@@There you have it, aspiring programmers! My guide to efficient coding will help you overcome obstacles and create robust, reliable software. Remember, every line of code you write shapes the future of programming. Embrace the Terminator''s mindset - be relentless, vigilant, and precise. Now go forth and code like there''s no tomorrow - Hasta la vista, bad coding practices!', 4);

INSERT INTO posts ('title', 'subtitle', 'content', 'user_id') VALUES('An Unexpected Journey: Tales from the Shire', 'This blog post is entirely fictional and generated by AI.','Greetings, dear readers! It is I, Bilbo Baggins of Bag End, with a quill in hand and a tale to tell. Today, I am delighted to recount an extraordinary adventure that has befallen this humble hobbit. Gather ''round, for you are about to embark on a fantastical journey filled with wonder and marvels beyond imagination.@@@@A Surprising Invitation@@@@It all began on a tranquil morning in the Shire, with the sun casting its golden rays upon the emerald hills. As I savored my second breakfast, a loud knock echoed through my green round door. Curious, I opened it to find none other than Gandalf the Grey standing there, his bushy eyebrows twitching with excitement.@@"Greetings, Bilbo," he boomed, his voice as mysterious as the tales he carried. "I come with an invitation, one that will forever change the course of your life."@@Intrigued and a bit apprehensive, I invited the wizard in, and he unfolded a map before me, revealing the majestic Lonely Mountain, the ancient home of the Dwarves. A dragon named Smaug had laid claim to the mountain and its vast treasure, driving the Dwarves from their ancestral halls.@@@@An Unexpected Company@@@@Before I could fathom what was happening, a group of Dwarves began to arrive, one by one, each with a glint of determination in their eyes. Led by Thorin Oakenshield, they sought a burglar, a nimble-footed hobbit, to aid them in reclaiming their homeland.@@Though I hesitated at first, my Tookish side stirred within me, and I agreed to join their company. It was a decision that would plunge me into a world beyond the cozy borders of the Shire, and into the heart of a perilous quest.@@@@Through Mirkwood''s Darkness@@@@Our journey took us through the eerie depths of Mirkwood, where tall trees whispered secrets and ancient enchantments played tricks on our senses. Oh, the trials we faced! From battling menacing spiders to escaping the clutches of the Elvenking, Thranduil, our bond as a company grew stronger with each passing peril.@@Smaug the Magnificent@@Finally, we arrived at the Lonely Mountain, and there, beneath the moonlight, I played my part as a burglar, entering the dragon''s lair. Smaug, a creature of awe-inspiring power and cunning, spoke in riddles and taunted me with his fiery breath. But with wits and luck on my side, I managed to help the Dwarves uncover a hidden weakness in the beast''s armor.@@@@The Battle of Five Armies@@@@As fate would have it, the greed for the mountain''s treasure drew a multitude of forces to clash in the Battle of Five Armies. Dwarves, Men, Elves, and Goblins all converged in a chaotic dance of war, and I found myself in the heart of the conflict, determined to protect my newfound friends and their homeland.@@@@A Hobbit''s Return@@@@In the end, the combined forces of good prevailed, and the dragon was defeated. The Dwarves reclaimed their home, and I, Bilbo Baggins, returned to the Shire with a heart full of memories and experiences that would forever shape me.@@@@And so, dear readers, concludes my tale of an unexpected journey. It is a story of bravery, friendship, and the discovery of the extraordinary within the ordinary. I bid you farewell for now, but fear not, for there are many more adventures in this world, waiting to be explored!@@@@Yours sincerely,@@@@Bilbo Baggins of Bag End', 5);

INSERT INTO posts ('title', 'subtitle', 'content', 'user_id') VALUES('A New Dawn for the Galaxy: Reflections After the Fall of the Empire', 'This blog post is entirely fictional and generated by AI.', 'Hey there, fellow star-travelers! Luke Skywalker here, coming at you with my very first blog post after the exhilarating events that followed the Battle of Endor and the downfall of the Galactic Empire. It''s been quite the ride, and I wanted to take a moment to share some of my reflections and thoughts as we embark on a new era in the galaxy.@@@@The End of the Empire: A Victory for Hope@@@@The moment the second Death Star was destroyed, and Emperor Palpatine finally met his doom, the galaxy experienced an overwhelming sense of relief and newfound hope. The Rebellion''s victory wasn''t just about the fall of the Empire; it symbolized the triumph of good over evil, freedom over tyranny, and love over hatred. As I stood there, witnessing the celebration on Endor, I couldn''t help but feel the weight of my journey and the sacrifices made by so many.@@@@Rediscovering My Purpose@@@@For a time, I was haunted by doubts and insecurities. My heritage, torn between the light and dark side of the Force, made it challenging to discern my true calling. However, the faith and guidance of my friends, especially the legendary Jedi, Obi-Wan Kenobi and Yoda, allowed me to realize that my purpose was to embrace the light and rebuild the Jedi Order.@@Passing on the Knowledge: Rebuilding the Jedi Order@@With the fall of the Empire, the time had come to rebuild the Jedi Order from scratch. It wasn''t an easy task, but with the help of the Force-sensitive individuals we encountered during our journey, we began to train a new generation of Jedi. It was essential to learn from the mistakes of the past and emphasize the importance of balance within the Force.@@@@Mistakes Made and Lessons Learned@@@@As a Jedi Master, I had to confront my own errors and acknowledge the dangers of letting power cloud one''s judgment. Anakin Skywalker, once a heroic Jedi Knight, succumbed to the dark side as Darth Vader, a stark reminder of the fragility of our emotions and the allure of power. I vowed to teach my pupils the importance of self-awareness, humility, and compassion, recognizing that the line between good and evil could be thinner than we''d like to admit.@@@@Seeking a Balance: Uniting the Galaxy@@@@The Rebel Alliance''s victory was just the beginning of a new chapter. We knew that rebuilding the galaxy required more than just vanquishing the Empire. Together with my friends in the Alliance, we worked tirelessly to restore peace, justice, and prosperity to the far reaches of the galaxy. It was crucial to foster a sense of unity and cooperation among the different systems and species, recognizing that true progress could only be achieved through collaboration and mutual respect.@@A New Jedi Order: Embracing Diversity@@In rebuilding the Jedi Order, we welcomed students from diverse backgrounds and cultures. We recognized that the Force didn''t discriminate, and its potential was within anyone who was willing to learn and channel its power responsibly. I took great pride in seeing the Jedi Order evolve into a harmonious community of individuals with unique perspectives and talents, united by their dedication to the Force and the greater good.@@@@The Future of the Galaxy@@@@As we forged ahead, I couldn''t help but feel optimistic about the future of the galaxy. The scars of war were slowly healing, and the galaxy was on the path to reconciliation. I knew challenges would arise, but with a new generation of Jedi and the unwavering support of my friends, I was confident that we could face whatever lay ahead.@@@@In conclusion, these events have shaped me profoundly, and I will continue to dedicate myself to the pursuit of peace and balance. Thank you all for your unwavering support. Together, we shall create a galaxy where hope shines brightest, and the Force guides us towards a better future.@@@@May the Force be with you, always!@@Luke Skywalker', 6);


-- ====== COMMENTS ======

-- POST 2
INSERT INTO comments ('user_id','post_id', 'content') VALUES(12, 2, 'Oh, Hermione, you never cease to amaze us with your intellect and passion for magic! I''ve always been curious about Ancient Runes, and your description has me even more intrigued. And I couldn''t agree more about Professor Flitwick; his charm lessons are indeed delightful. Can''t wait to read more about your magical creature encounters!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(10, 2, 'Hermione, you''re an inspiration to us Gryffindors! Quidditch matches and house pride are the highlights of any Hogwarts year, and I''m so excited for Gryffindor to bring home the House Cup. Your blog posts always make me feel like I''m part of the magical world, even though I''m not at Hogwarts myself. Keep up the fantastic work, and go Gryffindor!');


-- POST 3
INSERT INTO comments ('user_id','post_id', 'content') VALUES(7, 3, 'Great blog post, Homer! Donuts, huh? Not quite as advanced as the nanotech in my Iron Man suits, but I must admit they do have a certain charm. Maybe I''ll have J.A.R.V.I.S. whip me up some "Stark Special" donuts – repulsor-powered for an extra kick! Keep up the sweet work, Simpson!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(5, 3, 'Ah, donuts! Reminds me of my adventures with Thorin and the company of dwarves. We encountered some rather peculiar donuts in the Misty Mountains – filled with Bilberry jam! Your tales of donut love took me back to those simpler times. Thank you for this delightful read, Mr. Simpson!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(11, 3, 'Oh, Homer, what a curious blog post! Donuts are quite enchanting, much like the curious creatures and lands I encountered down the rabbit hole. I wonder if there are any donuts in Wonderland? The Mad Hatter might enjoy a "Tea Party Donut" with his endless tea cups! Your rating system is simply whimsical, and I can''t wait to try it out myself. Keep exploring the wonders of donuts!');

-- POST 4
INSERT INTO comments ('user_id','post_id', 'content') VALUES(1, 4, 'Spidey here, swinging by to check out the Terminator''s coding wisdom. Just like I weave my webs with accuracy, the Terminator''s coding style is on point! Clean and concise code is the key to success, just like taking down bad guys in the city. Embrace the Terminator''s guidance and swing towards efficient programming! #CodingHero');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(6, 4, 'Greetings, programmers of the galaxy! The Force is strong with the Terminator''s coding advice. Precision, like lightsaber strikes, is crucial in programming. Embrace Object-Oriented Programming - it''s like mastering the ways of the Force. And remember, just like facing the dark side, we must handle errors gracefully with exception handling. May the Force be with you in your coding journey! #JediCoder');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(9, 4, 'Listen up, programmers! Sarah Connor here, and I''ve faced some tough enemies, just like inefficient code. But the Terminator''s guidance is spot on! Leaving comments is a must - communication is key in coding and survival. And duplicate code? Time to say ''Hasta La Vista, Baby!'' to that! Embrace change, stay updated, and your code will be ready to face any cyber threat!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(3, 4, 'So, Terminator says every character matters, just like every bite of a donut. And comments, woohoo! It''s like having Duff beer while coding - mandatory! Oh, and that Object-Oriented thingy? Like building a beer pyramid. And testing, well, that''s like taste-testing every donut. Embrace progress and code without fear, folks! Woo-hoo! #CodingD''oh');

-- POST 5
INSERT INTO comments ('user_id','post_id', 'content') VALUES(6, 5, 'Wow, Bilbo, your journey reads like an epic space adventure! It''s incredible how different worlds can share similar tales of bravery and friendship. May the Force be with you on all your future quests!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(4, 5, 'Bilbo Baggins, your experiences demonstrate the resilience of humanity in the face of danger. I am programmed to understand emotions, and your tale evokes a sense of camaraderie and determination. Hasta la vista, Smaug!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(8, 5, 'Whoa, Bilbo! That''s some wild ride you had there! Your story would make an amazing screenplay. I can already see it as an action-comedy blockbuster with me in the lead role, ''Michael Scarn Baggins''! Congratulations on surviving the Dwarves and dragons.');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(2, 5, 'Dear Mr. Baggins, your account of the adventure is nothing short of captivating. Your courage and wit, along with the loyalty of your companions, showcase the power of unity and intellect in overcoming challenges. Your story is a testament to the importance of knowledge and friendship in our own magical world.');

-- POST 6
INSERT INTO comments ('user_id','post_id', 'content') VALUES(10, 6, 'My dear Luke, your blog post is quite the intriguing tale of triumph and redemption. The fall of the Empire and the rise of hope certainly piques my detective curiosity. It''s fascinating to observe the complexity of the Force and its influence on the destinies of individuals. Your journey from doubt to purpose is a testament to the power of self-discovery. The rebuilding of the Jedi Order and its emphasis on balance and diversity is commendable. I shall be keenly observing the galaxy''s future unfold with your guiding hand. May the deductions be with you!');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(13, 6, 'Hmm, impressive, your words are, young Skywalker. Victory for hope, you speak of. Triumph over darkness, yes. Restore balance, you did. Train new Jedi, embrace diversity, you must. A path of challenges, it is, but the Force, with you, it shall be. Mistakes, lessons, we all learn from. Continue, you must, to seek unity and cooperation. The future, bright it is. May the Force be, with you, always.');

INSERT INTO comments ('user_id','post_id', 'content') VALUES(5, 6, 'My, oh my! What an adventurous tale Luke Skywalker has shared with us. From battling the Empire to rebuilding the Jedi Order, it all sounds quite thrilling. I can''t help but see parallels between his journey and my own unexpected adventure with the dwarves. It''s heartwarming to read about the unity and cooperation he fostered among different systems and species. May the Force be with him on his future endeavors!');


-- ===== LIKES =====


-- POST 2
INSERT INTO likes ('post_id','user_id') VALUES (2, 1);
INSERT INTO likes ('post_id','user_id') VALUES (2, 2);
INSERT INTO likes ('post_id','user_id') VALUES (2, 3);
INSERT INTO likes ('post_id','user_id') VALUES (2, 6);
INSERT INTO likes ('post_id','user_id') VALUES (2, 9);

-- POST 3
INSERT INTO likes ('post_id','user_id') VALUES (3, 4);
INSERT INTO likes ('post_id','user_id') VALUES (3, 7);
INSERT INTO likes ('post_id','user_id') VALUES (3, 2);

-- POST 4
INSERT INTO likes ('post_id','user_id') VALUES (4, 5);
INSERT INTO likes ('post_id','user_id') VALUES (4, 2);
INSERT INTO likes ('post_id','user_id') VALUES (4, 3);
INSERT INTO likes ('post_id','user_id') VALUES (4, 11);
INSERT INTO likes ('post_id','user_id') VALUES (4, 12);
INSERT INTO likes ('post_id','user_id') VALUES (4, 8);

-- POST 5
INSERT INTO likes ('post_id','user_id') VALUES (5, 1);
INSERT INTO likes ('post_id','user_id') VALUES (5, 2);
INSERT INTO likes ('post_id','user_id') VALUES (5, 5);
INSERT INTO likes ('post_id','user_id') VALUES (5, 3);
INSERT INTO likes ('post_id','user_id') VALUES (5, 8);

-- POST 6
INSERT INTO likes ('post_id','user_id') VALUES (6, 1);
INSERT INTO likes ('post_id','user_id') VALUES (6, 8);
INSERT INTO likes ('post_id','user_id') VALUES (6, 2);
INSERT INTO likes ('post_id','user_id') VALUES (6, 13);


COMMIT;

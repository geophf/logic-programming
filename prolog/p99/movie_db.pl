/*
SPARQL query against wikidata run on 2020-05-13.

Query is:

SELECT DISTINCT ?item ?itemLabel ?genre ?genreLabel WHERE {
  ?item wdt:P31 wd:Q11424.
  ?item wdt:P577 ?pubdate.
  ?item wdt:P495 wd:Q30.
  ?item wdt:P364 wd:Q1860.
  ?item wdt:P136 ?genre. 
  FILTER((?pubdate >= "2020-01-01T00:00:00Z"^^xsd:dateTime) && (?pubdate <= "2020-12-31T00:00:00Z"^^xsd:dateTime))
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
}

JSON result translated to Prolog facts with:

https://github.com/geophf/logic-programming/blob/master/prolog/things/02_jsonin.pl

*/

movie(title('Scoob!'),genre('adventure film'),published(2020)).
movie(title('Germans & Jews'),genre('documentary film'),published(2020)).
movie(title('Underwater'),genre('action thriller'),published(2020)).
movie(title('Artemis Fowl'),genre('action film'),published(2020)).
movie(title('Trolls World Tour'),genre('computer-animated film'),published(2020)).
movie(title('Chaos Walking'),genre('science fiction film'),published(2020)).
movie(title('Bad Boys for Life'),genre('comedy film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('science fiction film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('comedy film'),published(2020)).
movie(title('Scoob!'),genre('animated film'),published(2020)).
movie(title('Chaos Walking'),genre('dystopian film'),published(2020)).
movie(title('Friend of the World'),genre('science fiction film'),published(2020)).
movie(title('Mulan'),genre('action film'),published(2020)).
movie(title('Duck Duck Goose'),genre('animated film'),published(2020)).
movie(title('Spies in Disguise'),genre('family film'),published(2020)).
movie(title('Trolls World Tour'),genre('family film'),published(2020)).
movie(title('The Lodge'),genre('thriller film'),published(2020)).
movie(title('Underwater'),genre('drama film'),published(2020)).
movie(title('Stockholm'),genre('crime film'),published(2020)).
movie(title('The New Mutants'),genre('horror film'),published(2020)).
movie(title('The Lodge'),genre('psychological thriller'),published(2020)).
movie(title('The Godmother'),genre('crime film'),published(2020)).
movie(title('Awake: The Life of Yogananda'),genre('documentary film'),published(2020)).
movie(title('A Hidden Life'),genre('biographical film'),published(2020)).
movie(title('The New Mutants'),genre('speculative fiction film'),published(2020)).
movie(title('Trolls World Tour'),genre('adventure film'),published(2020)).
movie(title('The Lodge'),genre('drama film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('family film'),published(2020)).
movie(title('Mulan'),genre('war film'),published(2020)).
movie(title('The Jesus Rolls'),genre('comedy film'),published(2020)).
movie(title('Top Gun: Maverick'),genre('action film'),published(2020)).
movie(title('The New Mutants'),genre('action film'),published(2020)).
movie(title('Jacob''s Ladder'),genre('horror film'),published(2020)).
movie(title('Stockholm'),genre('biographical film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('buddy film'),published(2020)).
movie(title('A Hidden Life'),genre('war film'),published(2020)).
movie(title('The Godmother'),genre('biographical film'),published(2020)).
movie(title('Underwater'),genre('adventure film'),published(2020)).
movie(title('No Time to Die'),genre('action film'),published(2020)).
movie(title('Spies in Disguise'),genre('animated film'),published(2020)).
movie(title('Scoob!'),genre('comedy film'),published(2020)).
movie(title('Trolls World Tour'),genre('animated film'),published(2020)).
movie(title('Duck Duck Goose'),genre('children''s film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('adventure film'),published(2020)).
movie(title('Stockholm'),genre('thriller film'),published(2020)).
movie(title('Duck Duck Goose'),genre('comedy film'),published(2020)).
movie(title('Mulan'),genre('drama film'),published(2020)).
movie(title('The New Mutants'),genre('science fiction film'),published(2020)).
movie(title('The Jesus Rolls'),genre('drama film'),published(2020)).
movie(title('A Hidden Life'),genre('drama film'),published(2020)).
movie(title('Underwater'),genre('horror film'),published(2020)).
movie(title('The War with Grandpa'),genre('comedy-drama'),published(2020)).
movie(title('A Hidden Life'),genre('romance film'),published(2020)).
movie(title('No Time to Die'),genre('spy film'),published(2020)).
movie(title('Artemis Fowl'),genre('adventure film'),published(2020)).
movie(title('Artemis Fowl'),genre('science fantasy'),published(2020)).
movie(title('Spies in Disguise'),genre('action film'),published(2020)).
movie(title('Scoob!'),genre('mystery film'),published(2020)).
movie(title('No Time to Die'),genre('thriller film'),published(2020)).
movie(title('Bad Boys for Life'),genre('crime film'),published(2020)).
movie(title('The War with Grandpa'),genre('family film'),published(2020)).
movie(title('The Godmother'),genre('drama film'),published(2020)).
movie(title('The Lodge'),genre('horror film'),published(2020)).
movie(title('Mulan'),genre('adventure film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('fantasy film'),published(2020)).
movie(title('Chaos Walking'),genre('action film'),published(2020)).
movie(title('Bad Boys for Life'),genre('action film'),published(2020)).
movie(title('Trolls World Tour'),genre('musical film'),published(2020)).
movie(title('Bad Boys for Life'),genre('buddy cop film'),published(2020)).
movie(title('Top Gun: Maverick'),genre(drama),published(2020)).
movie(title('Spies in Disguise'),genre('spy film'),published(2020)).
movie(title('Sonic the Hedgehog'),genre('action film'),published(2020)).
movie(title('Goitaca'),genre('drama film'),published(2020)).
movie(title('Trolls World Tour'),genre('comedy film'),published(2020)).
movie(title('Impractical Jokers: The Movie'),genre('comedy film'),published(2020)).
movie(title('The One and Only Ivan'),genre('fantasy film'),published(2020)).
movie(title('Charlie''s Angels'),genre('adventure film'),published(2020)).
movie(title('A Quiet Place: Part II'),genre('post-apocalyptic film'),published(2020)).
movie(title('Daniel Isn''t Real'),genre('horror film'),published(2020)).
movie(title('The Gools'),genre('adventure film'),published(2020)).
movie(title('The Last Thing He Wanted'),genre('thriller film'),published(2020)).
movie(title('Missing Link'),genre('comedy film'),published(2020)).
movie(title('Honey Boy'),genre('biographical film'),published(2020)).
movie(title('The Lighthouse'),genre('drama film'),published(2020)).
movie(title('The Grudge'),genre('horror film'),published(2020)).
movie(title('Bloodshot'),genre('science fiction film'),published(2020)).
movie(title('The Rhythm Section'),genre('action film'),published(2020)).
movie(title('A Beautiful Day in the Neighborhood'),genre('biographical film'),published(2020)).
movie(title('The Informer'),genre('crime film'),published(2020)).
movie(title('Harley Quinn: Birds of Prey'),genre('crime film'),published(2020)).
movie(title('Timmy Failure: Mistakes Were Made'),genre('fantasy film'),published(2020)).
movie(title('The Informer'),genre('action film'),published(2020)).
movie(title('Dolittle'),genre('comedy film'),published(2020)).
movie(title('The Public'),genre('drama film'),published(2020)).
movie(title('Boss Level'),genre('action film'),published(2020)).
movie(title('Harley Quinn: Birds of Prey'),genre('action film'),published(2020)).
movie(title('Broken Diamonds'),genre('drama film'),published(2020)).
movie(title('Bloodshot'),genre('superhero film'),published(2020)).
movie(title('Bios'),genre('science fiction film'),published(2020)).
movie(title('Death on the Nile'),genre('crime film'),published(2020)).
movie(title('Bloodshot'),genre('drama film'),published(2020)).
movie(title('The Rhythm Section'),genre('thriller film'),published(2020)).
movie(title('The Gools'),genre('fantasy film'),published(2020)).
movie(title('Thanks. And Sorry: The Chuck Mosley Movie'),genre('documentary film'),published(2020)).
movie(title('Charlie''s Angels'),genre('action film'),published(2020)).
movie(title('A Quiet Place: Part II'),genre('horror film'),published(2020)).
movie(title('Official Secrets'),genre('drama film'),published(2020)).
movie(title('The Empty Man'),genre('drama film'),published(2020)).
movie(title('Honey Boy'),genre('drama film'),published(2020)).
movie(title('A Beautiful Day in the Neighborhood'),genre('drama film'),published(2020)).
movie(title('Timmy Failure: Mistakes Were Made'),genre('comedy film'),published(2020)).
movie(title('Seberg'),genre('biographical film'),published(2020)).
movie(title('Boss Level'),genre('science fiction film'),published(2020)).
movie(title('The Last Full Measure'),genre('war film'),published(2020)).
movie(title('The Informer'),genre('thriller film'),published(2020)).
movie(title('Daniel Isn''t Real'),genre('thriller film'),published(2020)).
movie(title('Inherit the Viper'),genre('crime film'),published(2020)).
movie(title('Official Secrets'),genre('political thriller'),published(2020)).
movie(title('A Quiet Place: Part II'),genre('speculative fiction film'),published(2020)).
movie(title('Bios'),genre('drama film'),published(2020)).
movie(title('The Lighthouse'),genre('horror film'),published(2020)).
movie(title('Dolittle'),genre('family film'),published(2020)).
movie(title('Missing Link'),genre('adventure film'),published(2020)).
movie(title('Charlie''s Angels'),genre('comedy film'),published(2020)).
movie(title('Harley Quinn: Birds of Prey'),genre('superhero film'),published(2020)).
movie(title('Followed'),genre('found footage'),published(2020)).
movie(title('The Turning'),genre('supernatural horror'),published(2020)).
movie(title('The Last Full Measure'),genre('drama film'),published(2020)).
movie(title('Capone'),genre('biographical film'),published(2020)).
movie(title('The Lighthouse'),genre('fantasy film'),published(2020)).
movie(title('Monster Hunter'),genre('fantasy film'),published(2020)).
movie(title('Dolittle'),genre('adventure film'),published(2020)).
movie(title('Seberg'),genre('drama film'),published(2020)).
movie(title('A Quiet Place: Part II'),genre('science fiction film'),published(2020)).
movie(title('Free Guy'),genre('action film'),published(2020)).
movie(title('Monster Hunter'),genre('action film'),published(2020)).
movie(title('Connected'),genre('animated film'),published(2020)).
movie(title('Inherit the Viper'),genre('thriller film'),published(2020)).
movie(title('Jojo Rabbit'),genre('comedy-drama'),published(2020)).
movie(title('Death on the Nile'),genre('drama film'),published(2020)).
movie(title('Death on the Nile'),genre('mystery film'),published(2020)).
movie(title('3100: Run and Become'),genre('documentary film'),published(2020)).
movie(title('Followed'),genre('horror film'),published(2020)).
movie(title('Death on the Nile'),genre('film based on literature'),published(2020)).
movie(title('Kajillionaire'),genre('crime film'),published(2020)).
movie(title('The One and Only Ivan'),genre('animated film'),published(2020)).
movie(title('Bloodshot'),genre('fantasy film'),published(2020)).
movie(title('The Empty Man'),genre('crime film'),published(2020)).
movie(title('The Grudge'),genre('supernatural horror'),published(2020)).
movie(title('Capone'),genre('drama film'),published(2020)).
movie(title('Harley Quinn: Birds of Prey'),genre('adventure film'),published(2020)).
movie(title('Bloodshot'),genre('action film'),published(2020)).
movie(title('Free Guy'),genre('comedy film'),published(2020)).
movie(title('The Personal History of David Copperfield'),genre('drama film'),published(2020)).
movie(title('Capone'),genre('gangster film'),published(2020)).
movie(title('Inherit the Viper'),genre('drama film'),published(2020)).
movie(title('A Quiet Place: Part II'),genre(thriller),published(2020)).
movie(title('Monster Hunter'),genre('thriller film'),published(2020)).
movie(title('Greyhound'),genre('war film'),published(2020)).
movie(title('Dolittle'),genre('fantasy film'),published(2020)).
movie(title('The Peanut Butter Falcon'),genre('drama film'),published(2020)).
movie(title('Downhill'),genre('comedy film'),published(2020)).
movie(title('Queen & Slim'),genre('drama film'),published(2020)).
movie(title('Downhill'),genre('drama film'),published(2020)).
movie(title('Run'),genre('horror film'),published(2020)).
movie(title('Resistance'),genre('biographical film'),published(2020)).
movie(title('Dark Waters'),genre('biographical film'),published(2020)).
movie(title('Fantasy Island'),genre('supernatural horror'),published(2020)).
movie(title('Resistance'),genre('war film'),published(2020)).
movie(title('The Farewell'),genre('comedy-drama'),published(2020)).
movie(title('Fantasy Island'),genre('adventure film'),published(2020)).
movie(title('The Farewell'),genre('drama film'),published(2020)).
movie(title('The Gentlemen'),genre('crime film'),published(2020)).
movie(title('Uncorked'),genre('drama film'),published(2020)).
movie(title('Run'),genre('thriller film'),published(2020)).
movie(title('Resistance'),genre('comedy-drama'),published(2020)).
movie(title('Dark Waters'),genre('drama film'),published(2020)).
movie(title('Fantasy Island'),genre('horror film'),published(2020)).
movie(title('Dark Waters'),genre(drama),published(2020)).
movie(title('Resistance'),genre('historical film'),published(2020)).
movie(title('Dark Waters'),genre('historical film'),published(2020)).
movie(title('Happiest Season'),genre('comedy film'),published(2020)).
movie(title('Honest Thief'),genre('crime thriller'),published(2020)).
movie(title('Red Notice'),genre('action thriller'),published(2020)).
movie(title('Fruitful Mold'),genre('crime film'),published(2020)).
movie(title('The Way Back'),genre('sport film'),published(2020)).
movie(title('Color Out of Space'),genre('science fiction film'),published(2020)).
movie(title('Extraction'),genre('action film'),published(2020)).
movie(title('Red Notice'),genre('thriller film'),published(2020)).
movie(title('My Spy'),genre('action comedy film'),published(2020)).
movie(title('Cats'),genre('musical film'),published(2020)).
movie(title('Just Mercy'),genre('biographical film'),published(2020)).
movie(title('Onward'),genre('computer-animated film'),published(2020)).
movie(title('Jexi'),genre('comedy film'),published(2020)).
movie(title('Judy'),genre('musical film'),published(2020)).
movie(title('Peter Rabbit 2: The Runaway'),genre('adventure film'),published(2020)).
movie(title('Run Sweetheart Run'),genre('horror film'),published(2020)).
movie(title('Playing with Fire'),genre('family film'),published(2020)).
movie(title('Bombshell'),genre('drama film'),published(2020)).
movie(title('Cats'),genre('comedy-drama'),published(2020)).
movie(title('Cats'),genre('drama film'),published(2020)).
movie(title('Fruitful Mold'),genre('thriller film'),published(2020)).
movie(title('Spenser Confidential'),genre('drama film'),published(2020)).
movie(title('Dune'),genre('adventure film'),published(2020)).
movie(title('Hustlers'),genre('comedy-drama'),published(2020)).
movie(title('Like a Boss'),genre('comedy film'),published(2020)).
movie(title('Hustlers'),genre('drama film'),published(2020)).
movie(title('The Devil All the Time'),genre('thriller film'),published(2020)).
movie(title('Happiest Season'),genre('LGBT-related film'),published(2020)).
movie(title('Continuance'),genre('horror film'),published(2020)).
movie(title('Ghostbusters: Afterlife'),genre('speculative fiction film'),published(2020)).
movie(title('Just Mercy'),genre('drama film'),published(2020)).
movie(title('Kung Fury 2'),genre('kung fu film'),published(2020)).
movie(title('Judy'),genre('drama film'),published(2020)).
movie(title('The Call of the Wild'),genre('drama film'),published(2020)).
movie(title('The Call of the Wild'),genre('film based on literature'),published(2020)).
movie(title('Kung Fury 2'),genre('action film'),published(2020)).
movie(title('The Boys in the Band'),genre('drama film'),published(2020)).
movie(title('The Rental'),genre('horror film'),published(2020)).
movie(title('The Call of the Wild'),genre('family film'),published(2020)).
movie(title('Waves'),genre('drama film'),published(2020)).
movie(title('Bella!'),genre('documentary film'),published(2020)).
movie(title('The Devil All the Time'),genre('drama film'),published(2020)).
movie(title('Dune'),genre('film based on novels'),published(2020)).
movie(title('Fatale'),genre('thriller film'),published(2020)).
movie(title('21 Bridges'),genre('action film'),published(2020)).
movie(title('The Lovebirds'),genre('comedy film'),published(2020)).
movie(title('Shirley'),genre('thriller film'),published(2020)).
movie(title('Waldo'),genre('action film'),published(2020)).
movie(title('Lost Girls'),genre('drama film'),published(2020)).
movie(title('Lost Girls'),genre('mystery film'),published(2020)).
movie(title('Dune'),genre('speculative fiction film'),published(2020)).
movie(title('Ghostbusters: Afterlife'),genre('science fiction film'),published(2020)).
movie(title('Tigertail'),genre('drama film'),published(2020)).
movie(title('Ghostbusters: Afterlife'),genre('comedy film'),published(2020)).
movie(title('Color Out of Space'),genre('horror film'),published(2020)).
movie(title('Kung Fury 2'),genre('science fiction film'),published(2020)).
movie(title('The Call of the Wild'),genre('adventure film'),published(2020)).
movie(title('Kung Fury 2'),genre('comedy film'),published(2020)).
movie(title('The Boys in the Band'),genre('LGBT-related film'),published(2020)).
movie(title('Dune'),genre('action film'),published(2020)).
movie(title('The Roads Not Taken'),genre('drama film'),published(2020)).
movie(title('The Way Back'),genre('drama film'),published(2020)).
movie(title('Lucy in the Sky'),genre('drama film'),published(2020)).
movie(title('Peter Rabbit 2: The Runaway'),genre('comedy film'),published(2020)).
movie(title('Zola'),genre('drama film'),published(2020)).
movie(title('Onward'),genre('fantasy film'),published(2020)).
movie(title('American Pickle'),genre('comedy film'),published(2020)).
movie(title('21 Bridges'),genre('thriller film'),published(2020)).
movie(title('Waldo'),genre('thriller film'),published(2020)).
movie(title('All the Bright Places'),genre('drama film'),published(2020)).
movie(title('The Lovebirds'),genre('romance film'),published(2020)).
movie(title('Cats'),genre('fantasy film'),published(2020)).
movie(title('Hustlers'),genre('crime film'),published(2020)).
movie(title('Dune'),genre('science fiction film'),published(2020)).
movie(title('All the Bright Places'),genre('romance film'),published(2020)).
movie(title('The French Dispatch of the Liberty, Kansas Evening Sun'),genre('comedy-drama'),published(2020)).
movie(title('The French Dispatch of the Liberty, Kansas Evening Sun'),genre('drama film'),published(2020)).
movie(title('Never Rarely Sometimes Always'),genre('drama film'),published(2020)).
movie(title('Spenser Confidential'),genre('action film'),published(2020)).
movie(title('The French Dispatch of the Liberty, Kansas Evening Sun'),genre('romance film'),published(2020)).
movie(title('The Devil All the Time'),genre('horror film'),published(2020)).
movie(title('Playing with Fire'),genre('comedy film'),published(2020)).
movie(title('First Cow'),genre('fantasy film'),published(2020)).
movie(title('I Still Believe'),genre('drama film'),published(2020)).
movie(title('The Half of It'),genre('romantic comedy'),published(2020)).
movie(title('The Witches'),genre('comedy film'),published(2020)).
movie(title('Fatherhood'),genre('drama film'),published(2020)).
movie(title('Soul'),genre('adventure film'),published(2020)).
movie(title('The High Note'),genre('drama film'),published(2020)).
movie(title('Enola Holmes'),genre('mystery film'),published(2020)).
movie(title('Zombies 2'),genre('musical film'),published(2020)).
movie(title('The Tomorrow War'),genre('war film'),published(2020)).
movie(title('Emma.'),genre('comedy film'),published(2020)).
movie(title('Let Him Go'),genre(thriller),published(2020)).
movie(title('Drunk Bus'),genre('comedy-drama'),published(2020)).
movie(title('Mike & Fred vs the Dead'),genre('comedy film'),published(2020)).
movie(title('The SpongeBob Movie: Sponge on the Run'),genre('comedy film'),published(2020)).
movie(title('The Many Saints of Newark'),genre('drama film'),published(2020)).
movie(title('Poor Innocence'),genre('drama film'),published(2020)).
movie(title('Brahms: The Boy II'),genre('thriller film'),published(2020)).
movie(title('Tom & Jerry'),genre('live-action animated film'),published(2020)).
movie(title('The Photograph'),genre('romantic comedy'),published(2020)).
movie(title('West Side Story'),genre('musical film'),published(2020)).
movie(title('The Secrets We Keep'),genre('thriller film'),published(2020)).
movie(title('Soul'),genre('fantasy film'),published(2020)).
movie(title('Emma.'),genre('drama film'),published(2020)).
movie(title('Those Who Wish Me Dead'),genre('drama film'),published(2020)).
movie(title('Graduation Afternoon'),genre('science fiction film'),published(2020)).
movie(title('Wendy'),genre('drama film'),published(2020)).
movie(title('Emma.'),genre('film based on literature'),published(2020)).
movie(title('The King''s Man'),genre('adventure film'),published(2020)).
movie(title('Chemical Hearts'),genre('romance film'),published(2020)).
movie(title('The Dream'),genre(comedy),published(2020)).
movie(title('The Half of It'),genre('LGBT-related film'),published(2020)).
movie(title('Brahms: The Boy II'),genre('mystery film'),published(2020)).
movie(title('Minari'),genre('drama film'),published(2020)).
movie(title('The Secrets We Keep'),genre('drama film'),published(2020)).
movie(title('Tenet'),genre('spy film'),published(2020)).
movie(title('Let Them All Talk'),genre('adventure film'),published(2020)).
movie(title('The Photograph'),genre('drama film'),published(2020)).
movie(title('Tenet'),genre('thriller film'),published(2020)).
movie(title('Barb and Star Go to Vista Del Mar'),genre('comedy film'),published(2020)).
movie(title('The Photograph'),genre('romance film'),published(2020)).
movie(title('West Side Story'),genre('romance film'),published(2020)).
movie(title('The Witches'),genre('horror film'),published(2020)).
movie(title('I Still Believe'),genre('biographical film'),published(2020)).
movie(title('The King''s Man'),genre('action film'),published(2020)).
movie(title('Hubie Halloween'),genre('comedy film'),published(2020)).
movie(title('Plus One'),genre('romantic comedy'),published(2020)).
movie(title('Tom & Jerry'),genre('comedy film'),published(2020)).
movie(title('Soul'),genre('comedy-drama'),published(2020)).
movie(title('Valley Girl'),genre('musical film'),published(2020)).
movie(title('The Many Saints of Newark'),genre('crime film'),published(2020)).
movie(title('The Witches'),genre('fantasy film'),published(2020)).
movie(title('Antebellum'),genre('thriller film'),published(2020)).
movie(title('The SpongeBob Movie: Sponge on the Run'),genre('animated film'),published(2020)).
movie(title('Mike & Fred vs the Dead'),genre('horror film'),published(2020)).
movie(title('Bliss'),genre('horror film'),published(2020)).
movie(title('Fear Street'),genre('horror film'),published(2020)).
movie(title('The Many Saints of Newark'),genre('action film'),published(2020)).
movie(title('The Green Knight'),genre('speculative fiction film'),published(2020)).
movie(title('Brahms: The Boy II'),genre('horror film'),published(2020)).
movie(title('Bill & Ted Face the Music'),genre('science fiction film'),published(2020)).
movie(title('Bill & Ted Face the Music'),genre('comedy film'),published(2020)).
movie(title('Rifkin''s Festival'),genre('comedy film'),published(2020)).
movie(title('Wendy'),genre('fantasy film'),published(2020)).
movie(title('I Used to Go Here'),genre('comedy film'),published(2020)).
movie(title('Antebellum'),genre('drama film'),published(2020)).
movie(title('Sergio'),genre('drama film'),published(2020)).
movie(title('Crip Camp'),genre('documentary film'),published(2020)).
movie(title('TFW NO GF'),genre('documentary film'),published(2020)).
movie(title('Anal Crush'),genre('pornographic film'),published(2020)).
movie(title('Seven Stages to Achieve Eternal Bliss'),genre('comedy film'),published(2020)).
movie(title('The Main Event'),genre(comedy),published(2020)).
movie(title('TFW NO GF'),genre('independent film'),published(2020)).
movie(title('Vaxxed II: The People''s Truth'),genre('documentary film'),published(2020)).
movie(title('Sergio'),genre('biographical film'),published(2020)).
movie(title('Becoming Nobody'),genre('documentary film'),published(2020)).
movie(title('C''mon, C''mon'),genre('drama film'),published(2020)).
movie(title('Arkansas'),genre('crime film'),published(2020)).
movie(title('The Georgetown Project'),genre('thriller film'),published(2020)).
movie(title('The Conjuring: The Devil Made Me Do It'),genre('mystery film'),published(2020)).
movie(title('The Nowhere Inn'),genre('drama film'),published(2020)).
movie(title('Cunningham'),genre('biographical film'),published(2020)).
movie(title('Hamilton'),genre('musical film'),published(2020)).
movie(title('Miss Juneteenth'),genre('drama film'),published(2020)).
movie(title('The King of Staten Island'),genre('comedy film'),published(2020)).
movie(title('Snake Eyes'),genre('science fiction film'),published(2020)).
movie(title('Cunningham'),genre('musical film'),published(2020)).
movie(title('Violence of Action'),genre('thriller film'),published(2020)).
movie(title('She Dies Tomorrow'),genre('thriller film'),published(2020)).
movie(title('The Invisible Man'),genre('science fiction film'),published(2020)).
movie(title('Romantic Warriors IV: Krautrock (Part I)'),genre('musical film'),published(2020)).
movie(title('The Night House'),genre('thriller film'),published(2020)).
movie(title('Mank'),genre('drama film'),published(2020)).
movie(title('Disclosure: Trans Lives on Screen'),genre('LGBT-related film'),published(2020)).
movie(title('The Invisible Man'),genre('thriller film'),published(2020)).
movie(title('Respect'),genre('biographical film'),published(2020)).
movie(title('News of the World'),genre('drama film'),published(2020)).
movie(title('Gretel and Hansel'),genre('horror film'),published(2020)).
movie(title('Disclosure: Trans Lives on Screen'),genre('documentary film'),published(2020)).
movie(title('Octopus Pot'),genre('drama film'),published(2020)).
movie(title('Respect'),genre('musical film'),published(2020)).
movie(title('Countdown'),genre('horror film'),published(2020)).
movie(title('The Hunt'),genre('action film'),published(2020)).
movie(title('Jesus Was My Homeboy'),genre('biographical film'),published(2020)).
movie(title('Dick Johnson Is Dead'),genre('documentary film'),published(2020)).
movie(title('The King of Staten Island'),genre('drama film'),published(2020)).
movie(title('To All the Boys: P.S. I Still Love You'),genre('teen film'),published(2020)).
movie(title('Aquarela'),genre('documentary film'),published(2020)).
movie(title('Miles Davis: Birth of the Cool'),genre('musical film'),published(2020)).
movie(title('Escape Room 2'),genre('mystery film'),published(2020)).
movie(title('The Invisible Man'),genre('drama film'),published(2020)).
movie(title('Violet'),genre('drama film'),published(2020)).
movie(title('Pinocchio'),genre('fantasy film'),published(2020)).
movie(title('Gretel and Hansel'),genre('fantasy film'),published(2020)).
movie(title('A Fall from Grace'),genre('thriller film'),published(2020)).
movie(title('Infinite'),genre('science fiction film'),published(2020)).
movie(title('Promising Young Woman'),genre('drama film'),published(2020)).
movie(title('The Invisible Man'),genre('film based on literature'),published(2020)).
movie(title('To All the Boys: P.S. I Still Love You'),genre('romantic comedy'),published(2020)).
movie(title('Welcome to Chechnya'),genre('LGBT-related film'),published(2020)).
movie(title('Black Bear'),genre('drama film'),published(2020)).
movie(title('The Hunt'),genre('action thriller'),published(2020)).
movie(title('After We Collided'),genre('romance film'),published(2020)).
movie(title('Have a Good Trip: Adventures in Psychedelics'),genre('documentary film'),published(2020)).
movie(title('Coming 2 America'),genre('comedy film'),published(2020)).
movie(title('The Conjuring: The Devil Made Me Do It'),genre('horror film'),published(2020)).
movie(title('Without Remorse'),genre('action film'),published(2020)).
movie(title('Welcome to Chechnya'),genre('documentary film'),published(2020)).
movie(title('Respect'),genre('drama film'),published(2020)).
movie(title('The World Before Your Feet'),genre('documentary film'),published(2020)).
movie(title('Above the Shadows'),genre('romance film'),published(2020)).
movie(title('What is Life Worth'),genre('biographical film'),published(2020)).
movie(title('The Little Things (upcoming film)'),genre('crime film'),published(2020)).
movie(title('The Purge 5'),genre('horror film'),published(2020)).
movie(title('Malignant'),genre('horror film'),published(2020)).
movie(title('Horse Girl'),genre('psychological novel'),published(2020)).
movie(title('Scare Me'),genre('horror film'),published(2020)).
movie(title('Spree'),genre('independent film'),published(2020)).
movie(title('Mortal Kombat Legends: Scorpion''s Revenge'),genre('action film'),published(2020)).
movie(title('Cunningham'),genre('documentary film'),published(2020)).
movie(title('Gretel and Hansel'),genre('thriller film'),published(2020)).
movie(title('Romantic Warriors IV: Krautrock (Part I)'),genre('documentary film'),published(2020)).
movie(title('American Underdog: The Kurt Warner Story'),genre('biographical film'),published(2020)).
movie(title('Phineas and Ferb The Movie: Candace Against the Universe'),genre('comedy film'),published(2020)).
movie(title('Guest House: the movie'),genre('comedy film'),published(2020)).
movie(title(1917),genre('war film'),published(2020)).
movie(title('Stillwater'),genre('drama film'),published(2020)).
movie(title('The Invisible Man'),genre('horror film'),published(2020)).
movie(title('Stillwater'),genre(thriller),published(2020)).
movie(title('What is Life Worth'),genre('drama film'),published(2020)).
movie(title('Miles Davis: Birth of the Cool'),genre('documentary film'),published(2020)).
movie(title('Candyman'),genre('horror film'),published(2020)).
movie(title('Stillwater'),genre(drama),published(2020)).
movie(title('Miss Americana'),genre('documentary film'),published(2020)).
movie(title('The Conjuring: The Devil Made Me Do It'),genre('thriller film'),published(2020)).
movie(title('Deep Water'),genre('thriller film'),published(2020)).
movie(title('Escape Room 2'),genre('psychological horror'),published(2020)).
movie(title('Feels Good Man'),genre('documentary film'),published(2020)).
movie(title('Eurovision'),genre(musical),published(2020)).
movie(title('Picture a Scientist'),genre('biographical film'),published(2020)).
movie(title(1917),genre('drama film'),published(2020)).
movie(title('The Last Shift'),genre('comedy film'),published(2020)).
movie(title('Snake Eyes'),genre('action film'),published(2020)).
movie(title('Horse Girl'),genre('drama film'),published(2020)).
movie(title('Marianne & Leonard: Words of Love'),genre('documentary film'),published(2020)).
movie(title('The 40-Year-Old Version'),genre('comedy film'),published(2020)).
movie(title('Dinner in America'),genre('comedy-drama'),published(2020)).
movie(title('I Am Fear'),genre('thriller film'),published(2020)).

% ------------------------------------------------------- 2019 -----

movie(title('Shazam!'),genre('superhero film'),published(2019)).
movie(title('The Favourite'),genre('drama film'),published(2019)).
movie(title('The Escort'),genre('romance film'),published(2019)).
movie(title('Godzilla: King of the Monsters'),genre('action film'),published(2019)).
movie(title('Let It Snow'),genre('LGBT-related film'),published(2019)).
movie(title('Dumbo'),genre('fantasy film'),published(2019)).
movie(title('The King''s Daughter'),genre('action film'),published(2019)).
movie(title('Alita: Battle Angel'),genre(cyberpunk),published(2019)).
movie(title('Apocalypse Now'),genre('drama film'),published(2019)).
movie(title('Animal Crackers'),genre('fantasy film'),published(2019)).
movie(title('Motherless Brooklyn'),genre('crime film'),published(2019)).
movie(title('The Long Home'),genre('drama film'),published(2019)).
movie(title('Where Is Kyra?'),genre('independent film'),published(2019)).
movie(title('The Favourite'),genre('LGBT-related film'),published(2019)).
movie(title('Godzilla: King of the Monsters'),genre('science fiction film'),published(2019)).
movie(title('Bolden'),genre('drama film'),published(2019)).
movie(title('The Angry Birds Movie 2'),genre('comedy film'),published(2019)).
movie(title('Shazam!'),genre('Christmas film'),published(2019)).
movie(title('Animal Crackers'),genre('children''s film'),published(2019)).
movie(title('Aardvark'),genre('drama film'),published(2019)).
movie(title('Zeroville'),genre('comedy-drama'),published(2019)).
movie(title('The Angry Birds Movie 2'),genre('computer-animated film'),published(2019)).
movie(title('Mary Shelley'),genre('historical fiction'),published(2019)).
movie(title('Star Wars Episode IX: The Rise of Skywalker'),genre('space opera'),published(2019)).
movie(title('Alita: Battle Angel'),genre('action film'),published(2019)).
movie(title('Apocalypse Now'),genre('film based on books'),published(2019)).
movie(title('Mary Shelley'),genre('biographical film'),published(2019)).
movie(title('Dumbo'),genre('family film'),published(2019)).
movie(title('Shazam!'),genre('fantasy film'),published(2019)).
movie(title('Spring Break ''83'),genre('comedy film'),published(2019)).
movie(title('Let It Snow'),genre('romantic comedy'),published(2019)).
movie(title('Star Wars Episode IX: The Rise of Skywalker'),genre('adventure film'),published(2019)).
movie(title('Motherless Brooklyn'),genre('drama film'),published(2019)).
movie(title('Motherless Brooklyn'),genre('mystery film'),published(2019)).
movie(title('Shazam!'),genre('action film'),published(2019)).
movie(title('Alita: Battle Angel'),genre('science fiction film'),published(2019)).
movie(title('Motherless Brooklyn'),genre('film based on literature'),published(2019)).
movie(title('Where Is Kyra?'),genre('drama film'),published(2019)).
movie(title('Apocalypse Now'),genre('action film'),published(2019)).
movie(title('The Favourite'),genre('biographical film'),published(2019)).
movie(title('The King''s Daughter'),genre('adventure film'),published(2019)).
movie(title('The Escort'),genre('romantic comedy'),published(2019)).
movie(title('Dumbo'),genre('adventure film'),published(2019)).
movie(title('Alita: Battle Angel'),genre('dystopian film'),published(2019)).
movie(title('Shazam!'),genre('comedy film'),published(2019)).
movie(title('Mary Shelley'),genre('drama film'),published(2019)).
movie(title('Mary Shelley'),genre('romance film'),published(2019)).
movie(title('Star Wars Episode IX: The Rise of Skywalker'),genre('fantasy film'),published(2019)).
movie(title('Apocalypse Now'),genre('war film'),published(2019)).
movie(title('Star Wars Episode IX: The Rise of Skywalker'),genre('action film'),published(2019)).
movie(title('Godzilla: King of the Monsters'),genre('Kaiju'),published(2019)).
movie(title('The Escort'),genre('comedy-drama'),published(2019)).
movie(title('Under the Silver Lake'),genre('neo-noir'),published(2019)).
movie(title('The Possession of Hannah Grace'),genre('supernatural horror'),published(2019)).
movie(title('Cold Pursuit'),genre('action comedy film'),published(2019)).
movie(title('Captain Marvel'),genre('science fiction film'),published(2019)).
movie(title('Drunk Parents'),genre('comedy film'),published(2019)).
movie(title('Mercy'),genre('LGBT-related film'),published(2019)).
movie(title('Avengers: Endgame'),genre('superhero film'),published(2019)).
movie(title('The Irishman'),genre('drama film'),published(2019)).
movie(title('White Boy Rick'),genre('crime film'),published(2019)).
movie(title('Captain Marvel'),genre('superhero film'),published(2019)).
movie(title('Night Hunter'),genre('psychological thriller'),published(2019)).
movie(title('The Current War'),genre('drama film'),published(2019)).
movie(title('The Professor and the Madman'),genre('drama film'),published(2019)).
movie(title('Hotel Mumbai'),genre('biographical film'),published(2019)).
movie(title('Mercy'),genre(melodrama),published(2019)).
movie(title('The New Mutants'),genre('horror film'),published(2019)).
movie(title('We Have Always Lived in the Castle'),genre('thriller film'),published(2019)).
movie(title('White Boy Rick'),genre('biographical film'),published(2019)).
movie(title('Hotel Mumbai'),genre('thriller film'),published(2019)).
movie(title('Beautiful Boy'),genre('biographical film'),published(2019)).
movie(title('The New Mutants'),genre('speculative fiction film'),published(2019)).
movie(title('Under the Silver Lake'),genre('thriller film'),published(2019)).
movie(title('Avengers: Endgame'),genre('adventure film'),published(2019)).
movie(title('The Jesus Rolls'),genre('comedy film'),published(2019)).
movie(title('The New Mutants'),genre('action film'),published(2019)).
movie(title('What They Had'),genre('drama film'),published(2019)).
movie(title('We Have Always Lived in the Castle'),genre('mystery film'),published(2019)).
movie(title('Finding Steve McQueen'),genre('thriller film'),published(2019)).
movie(title('Captain Marvel'),genre('adventure film'),published(2019)).
movie(title('Hotel Mumbai'),genre('drama film'),published(2019)).
movie(title('Under the Silver Lake'),genre('drama film'),published(2019)).
movie(title('Under the Silver Lake'),genre('mystery film'),published(2019)).
movie(title('The Possession of Hannah Grace'),genre('thriller film'),published(2019)).
movie(title('The Irishman'),genre('crime film'),published(2019)).
movie(title('White Boy Rick'),genre('drama film'),published(2019)).
movie(title('The New Mutants'),genre('science fiction film'),published(2019)).
movie(title('The Old Man and the Gun'),genre('biographical film'),published(2019)).
movie(title('The Jesus Rolls'),genre('drama film'),published(2019)).
movie(title('Beautiful Boy'),genre('drama film'),published(2019)).
movie(title('Perfect'),genre('thriller film'),published(2019)).
movie(title('Avengers: Endgame'),genre('speculative fiction film'),published(2019)).
movie(title('Cold Pursuit'),genre('thriller film'),published(2019)).
movie(title('Avengers: Endgame'),genre('action film'),published(2019)).
movie(title('The Current War'),genre('historical period drama'),published(2019)).
movie(title('The Old Man and the Gun'),genre('crime-comedy film'),published(2019)).
movie(title('The Irishman'),genre('biographical film'),published(2019)).
movie(title('Night Hunter'),genre('crime film'),published(2019)).
movie(title('Captain Marvel'),genre('action film'),published(2019)).
movie(title('Mercy'),genre('drama film'),published(2019)).
movie(title('Night Hunter'),genre('action film'),published(2019)).
movie(title('The Current War'),genre('biographical film'),published(2019)).
movie(title('The Professor and the Madman'),genre('biographical film'),published(2019)).
movie(title('The Wife'),genre('drama film'),published(2019)).
movie(title('The Old Man and the Gun'),genre('drama film'),published(2019)).
movie(title('The Secret Life of Pets 2'),genre('comedy film'),published(2019)).
movie(title('Aladdin'),genre('musical film'),published(2019)).
movie(title('The Aftermath'),genre('drama film'),published(2019)).
movie(title('South of 8'),genre('crime thriller'),published(2019)).
movie(title('First Timers'),genre('thriller film'),published(2019)).
movie(title('Spider-Man: Far from Home'),genre('superhero film'),published(2019)).
movie(title('The Upside'),genre('comedy-drama'),published(2019)).
movie(title('Fighting with My Family'),genre('biographical film'),published(2019)).
movie(title('Holmes & Watson'),genre('comedy film'),published(2019)).
movie(title('Can You Ever Forgive Me?'),genre('comedy-drama'),published(2019)).
movie(title('Can You Ever Forgive Me?'),genre('drama film'),published(2019)).
movie(title('Colette'),genre('drama film'),published(2019)).
movie(title('Aladdin'),genre('romance film'),published(2019)).
movie(title('Aladdin'),genre('family film'),published(2019)).
movie(title('Robin Hood'),genre('adventure film'),published(2019)).
movie(title('Holmes & Watson'),genre('mystery film'),published(2019)).
movie(title('Untogether'),genre('drama film'),published(2019)).
movie(title('Captive State'),genre('science fiction film'),published(2019)).
movie(title('A Hidden Life'),genre('biographical film'),published(2019)).
movie(title('Can You Ever Forgive Me?'),genre('LGBT-related film'),published(2019)).
movie(title('Fighting with My Family'),genre('comedy-drama'),published(2019)).
movie(title('Spider-Man: Far from Home'),genre('adventure film'),published(2019)).
movie(title('Fighting with My Family'),genre('drama film'),published(2019)).
movie(title('Captive State'),genre('thriller film'),published(2019)).
movie(title('Colette'),genre('LGBT-related film'),published(2019)).
movie(title('Jacob''s Ladder'),genre('horror film'),published(2019)).
movie(title('A Hidden Life'),genre('war film'),published(2019)).
movie(title('Aladdin'),genre('adventure film'),published(2019)).
movie(title('A Hidden Life'),genre('drama film'),published(2019)).
movie(title('Robin Hood'),genre('action film'),published(2019)).
movie(title('A Hidden Life'),genre('romance film'),published(2019)).
movie(title('Fighting with My Family'),genre('sport film'),published(2019)).
movie(title('Spider-Man: Far from Home'),genre('action film'),published(2019)).
movie(title('The Lion King'),genre('computer-animated film'),published(2019)).
movie(title('Aladdin'),genre('speculative fiction film'),published(2019)).
movie(title('Aladdin'),genre('fantasy film'),published(2019)).
movie(title('South of 8'),genre('action film'),published(2019)).
movie(title('Aladdin'),genre('action film'),published(2019)).
movie(title('Fahrenheit 11/9'),genre('documentary film'),published(2019)).
movie(title('Can You Ever Forgive Me?'),genre('biographical film'),published(2019)).
movie(title('Ophelia'),genre('drama film'),published(2019)).
movie(title('Love After Love'),genre('drama film'),published(2019)).
movie(title('Spider-Man: Far from Home'),genre('science fiction film'),published(2019)).
movie(title('Colette'),genre('biographical film'),published(2019)).
movie(title('Holmes & Watson'),genre('action film'),published(2019)).
movie(title('If Beale Street Could Talk'),genre('romance film'),published(2019)).
movie(title('Teen Spirit'),genre('drama film'),published(2019)).
movie(title('Ad Astra'),genre('epic film'),published(2019)).
movie(title('Destination Wedding'),genre('romantic comedy'),published(2019)).
movie(title('Ad Astra'),genre('science fiction film'),published(2019)).
movie(title('Ad Astra'),genre('thriller film'),published(2019)).
movie(title('Teen Spirit'),genre('musical film'),published(2019)).
movie(title('Escape Plan: The Extractors'),genre('thriller film'),published(2019)).
movie(title('If Beale Street Could Talk'),genre('drama film'),published(2019)).
movie(title('The Peanut Butter Falcon'),genre('drama film'),published(2019)).
movie(title('Sweetheart'),genre('thriller film'),published(2019)).
movie(title('The Front Runner'),genre('drama film'),published(2019)).
movie(title('Boy Erased'),genre('LGBT-related film'),published(2019)).
movie(title('Terminator: Dark Fate'),genre('science fiction film'),published(2019)).
movie(title('Vice'),genre('biographical film'),published(2019)).
movie(title('Noelle'),genre('adventure film'),published(2019)).
movie(title('Noelle'),genre('Christmas film'),published(2019)).
movie(title('Close'),genre('action film'),published(2019)).
movie(title('Boy Erased'),genre('coming-of-age story'),published(2019)).
movie(title('Dumplin'''),genre('musical film'),published(2019)).
movie(title('Vice'),genre('comedy-drama'),published(2019)).
movie(title('Vice'),genre('drama film'),published(2019)).
movie(title('Dumplin'''),genre('comedy film'),published(2019)).
movie(title('Noelle'),genre('fantasy film'),published(2019)).
movie(title('Strange But True'),genre('thriller film'),published(2019)).
movie(title('Boy Erased'),genre('biographical film'),published(2019)).
movie(title('Submission'),genre('drama film'),published(2019)).
movie(title('Submission'),genre('film based on literature'),published(2019)).
movie(title('Vice'),genre('LGBT-related film'),published(2019)).
movie(title('Noelle'),genre('comedy film'),published(2019)).
movie(title('The Front Runner'),genre('biographical film'),published(2019)).
movie(title('Terminator: Dark Fate'),genre('speculative fiction film'),published(2019)).
movie(title('Boy Erased'),genre('drama film'),published(2019)).
movie(title('Terminator: Dark Fate'),genre('action film'),published(2019)).
movie(title('Prey'),genre('thriller film'),published(2019)).
movie(title('Long Shot'),genre('romantic comedy'),published(2019)).
movie(title('The Rising Hawk'),genre('film adaptation'),published(2019)).
movie(title('Green Book'),genre('comedy film'),published(2019)).
movie(title('Harriet'),genre('drama film'),published(2019)).
movie(title('Long Shot'),genre('comedy film'),published(2019)).
movie(title('Underwater'),genre('action thriller'),published(2019)).
movie(title('Detective Pikachu'),genre('fantasy film'),published(2019)).
movie(title('The Kindergarten Teacher'),genre('drama film'),published(2019)).
movie(title('Ben Is Back'),genre('drama film'),published(2019)).
movie(title('Detective Pikachu'),genre('action film'),published(2019)).
movie(title('At Eternity''s Gate'),genre('drama film'),published(2019)).
movie(title('The Informer'),genre('crime film'),published(2019)).
movie(title('55 Steps'),genre('drama film'),published(2019)).
movie(title('Mandy'),genre('drama film'),published(2019)).
movie(title('Harriet'),genre('historical film'),published(2019)).
movie(title('The Rising Hawk'),genre('drama film'),published(2019)).
movie(title('Rocko''s Modern Life: Static Cling'),genre('LGBT-related film'),published(2019)).
movie(title('The Informer'),genre('action film'),published(2019)).
movie(title('The Public'),genre('drama film'),published(2019)).
movie(title('Green Book'),genre('comedy-drama'),published(2019)).
movie(title('Green Book'),genre('drama film'),published(2019)).
movie(title('Trading Paint'),genre('action film'),published(2019)).
movie(title('Detective Pikachu'),genre('science fiction film'),published(2019)).
movie(title('The Art of Self-Defense'),genre('black comedy film'),published(2019)).
movie(title('Once Upon a Time in Hollywood'),genre('comedy-drama'),published(2019)).
movie(title('Underwater'),genre('drama film'),published(2019)).
movie(title('Welcome to Marwen'),genre('fantasy film'),published(2019)).
movie(title('Once Upon a Time in Hollywood'),genre('drama film'),published(2019)).
movie(title('The Parts You Lose'),genre('thriller film'),published(2019)).
movie(title('Mary Queen of Scots'),genre('historical period drama'),published(2019)).
movie(title('Serenity'),genre('science fiction film'),published(2019)).
movie(title('Isn''t It Romantic'),genre('fantasy film'),published(2019)).
movie(title('The Rising Hawk'),genre('adventure film'),published(2019)).
movie(title('Serenity'),genre('thriller film'),published(2019)).
movie(title('Rocko''s Modern Life: Static Cling'),genre('animated film with LGBT character(s)'),published(2019)).
movie(title('The Informer'),genre('thriller film'),published(2019)).
movie(title('Green Book'),genre('LGBT-related film'),published(2019)).
movie(title('Changeland'),genre('comedy-drama'),published(2019)).
movie(title('Welcome to Marwen'),genre('biographical film'),published(2019)).
movie(title('Mary Queen of Scots'),genre('biographical film'),published(2019)).
movie(title('The Red Sea Diving Resort'),genre('historical film'),published(2019)).
movie(title('Detective Pikachu'),genre('mystery film'),published(2019)).
movie(title('Mandy'),genre('horror film'),published(2019)).
movie(title('Underwater'),genre('adventure film'),published(2019)).
movie(title('Serenity'),genre('drama film'),published(2019)).
movie(title('Isn''t It Romantic'),genre('romantic comedy'),published(2019)).
movie(title('Gloria Bell'),genre('comedy-drama'),published(2019)).
movie(title('Once Upon a Time in Hollywood'),genre('alternate history film'),published(2019)).
movie(title('Gloria Bell'),genre('romance film'),published(2019)).
movie(title('Where''d You Go, Bernadette'),genre('comedy-drama'),published(2019)).
movie(title('Where''d You Go, Bernadette'),genre('drama film'),published(2019)).
movie(title('The Art of Self-Defense'),genre('comedy film'),published(2019)).
movie(title('Mandy'),genre('fantasy film'),published(2019)).
movie(title('Trading Paint'),genre('drama film'),published(2019)).
movie(title('Mandy'),genre('action film'),published(2019)).
movie(title('Underwater'),genre('horror film'),published(2019)).
movie(title('Once Upon a Time in Hollywood'),genre('black comedy film'),published(2019)).
movie(title('Welcome to Marwen'),genre('drama film'),published(2019)).
movie(title('Rocko''s Modern Life: Static Cling'),genre('comedy film'),published(2019)).
movie(title('Detective Pikachu'),genre('adventure film'),published(2019)).
movie(title('At Eternity''s Gate'),genre('biographical film'),published(2019)).
movie(title('Once Upon a Time in Hollywood'),genre('crime film'),published(2019)).
movie(title('Detective Pikachu'),genre('live-action animated film'),published(2019)).
movie(title('Welcome to Marwen'),genre('LGBT-related film'),published(2019)).
movie(title('Mandy'),genre('thriller film'),published(2019)).
movie(title('Green Book'),genre('biographical film'),published(2019)).
movie(title('Polaroid'),genre('horror film'),published(2019)).
movie(title('Glass'),genre('horror film'),published(2019)).
movie(title('Dark Phoenix'),genre('adventure film'),published(2019)).
movie(title('Hellboy'),genre('adventure film'),published(2019)).
movie(title('Anything'),genre('drama film'),published(2019)).
movie(title('Anything'),genre('romance film'),published(2019)).
movie(title('Spies in Disguise'),genre('family film'),published(2019)).
movie(title('Hellboy'),genre('horror film'),published(2019)).
movie(title('Anything'),genre('LGBT-related film'),published(2019)).
movie(title('Glass'),genre('science fiction film'),published(2019)).
movie(title('Dark Phoenix'),genre('action film'),published(2019)).
movie(title('Glass'),genre('thriller film'),published(2019)).
movie(title('Hellboy'),genre('fantasy film'),published(2019)).
movie(title('Hellboy'),genre('action film'),published(2019)).
movie(title('Louisiana Caviar'),genre('drama film'),published(2019)).
movie(title('Glass'),genre('superhero film'),published(2019)).
movie(title('Spies in Disguise'),genre('animated film'),published(2019)).
movie(title('Dark Phoenix'),genre('science fiction film'),published(2019)).
movie(title('Hellboy'),genre('science fiction film'),published(2019)).
movie(title('Dark Phoenix'),genre('superhero film'),published(2019)).
movie(title('Spies in Disguise'),genre('action film'),published(2019)).
movie(title('Spies in Disguise'),genre('spy film'),published(2019)).
movie(title('A Rainy Day in New York'),genre('romance film'),published(2019)).
movie(title('Second Act'),genre('romance film'),published(2019)).
movie(title('Descendants 3'),genre('action film'),published(2019)).
movie(title('It: Chapter Two'),genre('horror film'),published(2019)).
movie(title('Joker'),genre('crime film'),published(2019)).
movie(title('Super Size Me 2: Holy Chicken!'),genre('documentary film'),published(2019)).
movie(title('On the Basis of Sex'),genre('biographical film'),published(2019)).
movie(title('Gemini Man'),genre('action film'),published(2019)).
movie(title('Descendants 3'),genre('musical film'),published(2019)).
movie(title('Tolkien'),genre('biographical film'),published(2019)).
movie(title('Juanita'),genre('drama film'),published(2019)).
movie(title('The Lodge'),genre('thriller film'),published(2019)).
movie(title('The Lodge'),genre('psychological thriller'),published(2019)).
movie(title('Extremely Wicked, Shockingly Evil and Vile'),genre('biographical film'),published(2019)).
movie(title('When I''m a Moth'),genre('drama film'),published(2019)).
movie(title('Destroyer'),genre('drama film'),published(2019)).
movie(title('Marriage Story'),genre('comedy-drama'),published(2019)).
movie(title('Creed II'),genre('drama film'),published(2019)).
movie(title('Gemini Man'),genre('science fiction film'),published(2019)).
movie(title('Second Act'),genre(melodrama),published(2019)).
movie(title('Shaft'),genre('crime film'),published(2019)).
movie(title('The Goldfinch'),genre('drama film'),published(2019)).
movie(title('Inherit the Viper'),genre('crime film'),published(2019)).
movie(title('Marriage Story'),genre('romance film'),published(2019)).
movie(title('The Highwaymen'),genre('crime film'),published(2019)).
movie(title('The Lodge'),genre('drama film'),published(2019)).
movie(title('Escape Room'),genre('horror film'),published(2019)).
movie(title('On the Basis of Sex'),genre('drama film'),published(2019)).
movie(title('Extremely Wicked, Shockingly Evil and Vile'),genre('crime thriller'),published(2019)).
movie(title('Joker'),genre('thriller film'),published(2019)).
movie(title('Tolkien'),genre('drama film'),published(2019)).
movie(title('It: Chapter Two'),genre('thriller film'),published(2019)).
movie(title('The Curse of La Llorona'),genre('supernatural horror'),published(2019)).
movie(title('Gemini Man'),genre('drama film'),published(2019)).
movie(title('Vox Lux'),genre('musical film'),published(2019)).
movie(title('Good Posture'),genre('comedy-drama'),published(2019)).
movie(title('A Million Little Pieces'),genre('drama film'),published(2019)).
movie(title('Extremely Wicked, Shockingly Evil and Vile'),genre('drama film'),published(2019)).
movie(title('A Million Little Pieces'),genre(thriller),published(2019)).
movie(title('Joker'),genre('drama film'),published(2019)).
movie(title('Creed II'),genre('sport film'),published(2019)).
movie(title('Juanita'),genre('independent film'),published(2019)).
movie(title('Inherit the Viper'),genre('thriller film'),published(2019)).
movie(title('A Rainy Day in New York'),genre('comedy film'),published(2019)).
movie(title('Second Act'),genre('comedy film'),published(2019)).
movie(title('The Highwaymen'),genre('costume drama'),published(2019)).
movie(title('When I''m a Moth'),genre('independent film'),published(2019)).
movie(title('The Lodge'),genre('horror film'),published(2019)).
movie(title('Vox Lux'),genre('drama film'),published(2019)).
movie(title('Destroyer'),genre('crime film'),published(2019)).
movie(title('The Gallows Act II'),genre('horror film'),published(2019)).
movie(title('It: Chapter Two'),genre('LGBT-related film'),published(2019)).
movie(title('The Beach Bum'),genre('comedy film'),published(2019)).
movie(title('The Hustle'),genre('comedy film'),published(2019)).
movie(title('Inherit the Viper'),genre('drama film'),published(2019)).
movie(title('Escape Room'),genre('psychological thriller'),published(2019)).
movie(title('Shaft'),genre('action comedy film'),published(2019)).
movie(title('A Violent Separation'),genre('crime thriller'),published(2019)).
movie(title('Ford v Ferrari'),genre('action film'),published(2019)).
movie(title('Lost Transmissions'),genre('independent film'),published(2019)).
movie(title('Ford v Ferrari'),genre('biographical film'),published(2019)).
movie(title('Sword of Trust'),genre('comedy film'),published(2019)).
movie(title('What Men Want'),genre('fantasy film'),published(2019)).
movie(title('Native Son'),genre('drama film'),published(2019)).
movie(title('Ford v Ferrari'),genre('drama film'),published(2019)).
movie(title('What Men Want'),genre('romantic comedy'),published(2019)).
movie(title('Jay and Silent Bob Reboot'),genre('comedy film'),published(2019)).
movie(title('Five Feet Apart'),genre('drama film'),published(2019)).
movie(title('Rim of the World'),genre('science fiction film'),published(2019)).
movie(title('Lost Transmissions'),genre('drama film'),published(2019)).
movie(title('Five Feet Apart'),genre('romance film'),published(2019)).
movie(title('Five Feet Apart'),genre('romantic drama'),published(2019)).
movie(title('Pet Sematary'),genre('supernatural horror'),published(2019)).
movie(title('The Report'),genre('drama film'),published(2019)).
movie(title('The Sun Is Also a Star'),genre('drama film'),published(2019)).
movie(title('Missing Link'),genre('comedy film'),published(2019)).
movie(title('Murder Mystery'),genre('action film'),published(2019)).
movie(title('The Lighthouse'),genre('drama film'),published(2019)).
movie(title('Men in Black: International'),genre('science fiction film'),published(2019)).
movie(title('Men in Black: International'),genre('comedy film'),published(2019)).
movie(title('The Dead Don''t Die'),genre('zombie film'),published(2019)).
movie(title('The Poison Rose'),genre('crime thriller'),published(2019)).
movie(title('Murder Mystery'),genre('comedy film'),published(2019)).
movie(title('The Last Summer'),genre('comedy film'),published(2019)).
movie(title('Christmas in the Wild'),genre('romantic comedy'),published(2019)).
movie(title('Murder Mystery'),genre('mystery film'),published(2019)).
movie(title('How to Build a Girl'),genre('comedy film'),published(2019)).
movie(title('The Dead Don''t Die'),genre('comedy horror'),published(2019)).
movie(title('The Lighthouse'),genre('horror film'),published(2019)).
movie(title('Missing Link'),genre('adventure film'),published(2019)).
movie(title('An Interview with God'),genre('drama film'),published(2019)).
movie(title('An Interview with God'),genre('mystery film'),published(2019)).
movie(title('A Madea Family Funeral'),genre('comedy film'),published(2019)).
movie(title('The Lighthouse'),genre('fantasy film'),published(2019)).
movie(title('Greta'),genre('thriller film'),published(2019)).
movie(title('Greta'),genre('drama film'),published(2019)).
movie(title('Christmas in the Wild'),genre('Christmas film'),published(2019)).
movie(title('Men in Black: International'),genre('action film'),published(2019)).
movie(title('Always Be My Maybe'),genre('romantic comedy'),published(2019)).
movie(title('Honey Boy'),genre('biographical film'),published(2019)).
movie(title('Ma'),genre('psychological horror'),published(2019)).
movie(title('Lyrebird'),genre('drama film'),published(2019)).
movie(title('In the Shadow of the Moon'),genre('crime film'),published(2019)).
movie(title('Jonathan'),genre('science fiction film'),published(2019)).
movie(title('Judy'),genre('musical film'),published(2019)).
movie(title('Beats'),genre('coming-of-age story'),published(2019)).
movie(title('Late Night'),genre('comedy film'),published(2019)).
movie(title('Crypto'),genre('crime thriller'),published(2019)).
movie(title('Honey Boy'),genre('drama film'),published(2019)).
movie(title('Gully'),genre('drama film'),published(2019)).
movie(title('Seberg'),genre('biographical film'),published(2019)).
movie(title('Jonathan'),genre('drama film'),published(2019)).
movie(title('Judy'),genre('drama film'),published(2019)).
movie(title('Late Night'),genre('drama film'),published(2019)).
movie(title('Crypto'),genre('drama film'),published(2019)).
movie(title('Booksmart'),genre('comedy film'),published(2019)).
movie(title('After the Wedding'),genre('drama film'),published(2019)).
movie(title('Io'),genre('science fiction film'),published(2019)).
movie(title('Seberg'),genre('drama film'),published(2019)).
movie(title('Io'),genre('drama film'),published(2019)).
movie(title('Blow the Man Down'),genre('thriller film'),published(2019)).
movie(title('Booksmart'),genre('LGBT-related film'),published(2019)).
movie(title('Ma'),genre('horror film'),published(2019)).
movie(title('A Private War'),genre('biographical film'),published(2019)).
movie(title('The Cleaners'),genre('documentary film'),published(2019)).
movie(title('John Wick: Chapter 3 – Parabellum'),genre('action film'),published(2019)).
movie(title('Paddleton'),genre('road movie'),published(2019)).
movie(title('Instant Family'),genre('drama film'),published(2019)).
movie(title('The Wedding Year'),genre('romantic comedy'),published(2019)).
movie(title('Miss Bala'),genre('thriller film'),published(2019)).
movie(title('Velvet Buzzsaw'),genre('mystery film'),published(2019)).
movie(title('Polar'),genre('crime film'),published(2019)).
movie(title('End of Sentence'),genre('drama film'),published(2019)).
movie(title('Crawl'),genre('horror film'),published(2019)).
movie(title('3 from Hell'),genre('splatter film'),published(2019)).
movie(title('Polar'),genre('action film'),published(2019)).
movie(title('Happy Death Day 2U'),genre('slasher film'),published(2019)).
movie(title('John Wick: Chapter 3 – Parabellum'),genre('thriller film'),published(2019)).
movie(title('A Private War'),genre('drama film'),published(2019)).
movie(title('Miss Bala'),genre('drama film'),published(2019)).
movie(title('Velvet Buzzsaw'),genre('LGBT-related film'),published(2019)).
movie(title('Wounds'),genre('horror film'),published(2019)).
movie(title('Official Secrets'),genre('drama film'),published(2019)).
movie(title('High Flying Bird'),genre('drama film'),published(2019)).
movie(title('Uncut Gems'),genre('comedy-drama'),published(2019)).
movie(title('Uncut Gems'),genre('drama film'),published(2019)).
movie(title('Uncut Gems'),genre(thriller),published(2019)).
movie(title('Overcomer'),genre('drama film'),published(2019)).
movie(title('Good Boys'),genre('comedy film'),published(2019)).
movie(title('Wounds'),genre('psychological horror'),published(2019)).
movie(title('Official Secrets'),genre('political thriller'),published(2019)).
movie(title('Polar'),genre('thriller film'),published(2019)).
movie(title('Eli'),genre('horror film'),published(2019)).
movie(title('Scary Stories to Tell in the Dark'),genre('horror film'),published(2019)).
movie(title('Waves'),genre('drama film'),published(2019)).
movie(title('Velvet Buzzsaw'),genre('horror film'),published(2019)).
movie(title('The Cat and the Moon'),genre('teen film'),published(2019)).
movie(title('The Turning'),genre('supernatural horror'),published(2019)).
movie(title('Brittany Runs a Marathon'),genre('drama film'),published(2019)).
movie(title('Driven'),genre('independent film'),published(2019)).
movie(title('The Silence'),genre('horror film'),published(2019)).
movie(title('Triple Frontier'),genre('crime film'),published(2019)).
movie(title('Polar'),genre('drama film'),published(2019)).
movie(title('Running with the Devil'),genre('action thriller'),published(2019)).
movie(title('Madeline''s Madeline'),genre('drama film'),published(2019)).
movie(title('Paddleton'),genre('comedy-drama'),published(2019)).
movie(title('Triple Frontier'),genre('action film'),published(2019)).
movie(title('The Good Liar'),genre('thriller film'),published(2019)).
movie(title('Hale County This Morning, This Evening'),genre('documentary film'),published(2019)).
movie(title('Driven'),genre('biographical film'),published(2019)).
movie(title('John Wick: Chapter 3 – Parabellum'),genre('neo-noir'),published(2019)).
movie(title('Miss Bala'),genre('crime film'),published(2019)).
movie(title('Triple Frontier'),genre('action thriller'),published(2019)).
movie(title('Happy Death Day 2U'),genre('mystery film'),published(2019)).
movie(title('Abruptio'),genre('horror film'),published(2019)).
movie(title('The Good Liar'),genre('drama film'),published(2019)).
movie(title('Uncut Gems'),genre('crime film'),published(2019)).
movie(title('Polar'),genre('adventure film'),published(2019)).
movie(title('Instant Family'),genre('comedy film'),published(2019)).
movie(title('Miss Bala'),genre('action film'),published(2019)).
movie(title('Greyhound'),genre('war film'),published(2019)).
movie(title('Skin'),genre('biographical film'),published(2019)).
movie(title('The Mule'),genre('crime film'),published(2019)).
movie(title('Maleficent: Mistress of Evil'),genre(melodrama),published(2019)).
movie(title('The Two Popes'),genre('drama film'),published(2019)).
movie(title('The Mule'),genre('biographical film'),published(2019)).
movie(title('The Two Popes'),genre('historical film'),published(2019)).
movie(title('Boss Level'),genre('action film'),published(2019)).
movie(title('Maleficent: Mistress of Evil'),genre('fantasy film'),published(2019)).
movie(title('Rambo: Last Blood'),genre('splatter film'),published(2019)).
movie(title('Maleficent: Mistress of Evil'),genre('action film'),published(2019)).
movie(title('The Dirt'),genre('biographical film'),published(2019)).
movie(title('Skin'),genre('drama film'),published(2019)).
movie(title('Zombieland: Double Tap'),genre('zombie comedy'),published(2019)).
movie(title('Someone Great'),genre('LGBT-related film'),published(2019)).
movie(title('The Dirt'),genre('musical film'),published(2019)).
movie(title('Primal'),genre('action film'),published(2019)).
movie(title('Zombieland: Double Tap'),genre('post-apocalyptic film'),published(2019)).
movie(title('Nancy Drew and the Hidden Staircase'),genre('crime film'),published(2019)).
movie(title('Nobody''s Fool'),genre('comedy film'),published(2019)).
movie(title('Boss Level'),genre('science fiction film'),published(2019)).
movie(title('The Last Full Measure'),genre('war film'),published(2019)).
movie(title('Rambo: Last Blood'),genre('action film'),published(2019)).
movie(title('The Last Black Man in San Francisco'),genre('drama film'),published(2019)).
movie(title('Otherhood'),genre('comedy film'),published(2019)).
movie(title('The Intruder'),genre('psychological thriller'),published(2019)).
movie(title('The Mule'),genre('drama film'),published(2019)).
movie(title('Poms'),genre('dance film'),published(2019)).
movie(title('Poms'),genre('comedy film'),published(2019)).
movie(title('Nancy Drew and the Hidden Staircase'),genre('teen film'),published(2019)).
movie(title('The Last Full Measure'),genre('drama film'),published(2019)).
movie(title('Rambo: Last Blood'),genre('action thriller'),published(2019)).
movie(title('Nobody''s Fool'),genre('drama film'),published(2019)).
movie(title('Zombieland: Double Tap'),genre('zombie film'),published(2019)).
movie(title('RBG'),genre('documentary film'),published(2019)).
movie(title('Maleficent: Mistress of Evil'),genre('drama film'),published(2019)).
movie(title('Zombieland: Double Tap'),genre('horror film'),published(2019)).
movie(title('Earthquake Bird'),genre('drama film'),published(2019)).
movie(title('Earthquake Bird'),genre('mystery film'),published(2019)).
movie(title('Lady and the Tramp'),genre('children''s film'),published(2019)).
movie(title('Share'),genre('drama film'),published(2019)).
movie(title('Jojo Rabbit'),genre('comedy-drama'),published(2019)).
movie(title('Earthquake Bird'),genre(thriller),published(2019)).
movie(title('Maleficent: Mistress of Evil'),genre('family film'),published(2019)).
movie(title('Stuber'),genre('action film'),published(2019)).
movie(title('The Fanatic'),genre('drama film'),published(2019)).
movie(title('Nancy Drew and the Hidden Staircase'),genre('mystery film'),published(2019)).
movie(title('The Personal History of David Copperfield'),genre('drama film'),published(2019)).
movie(title('Someone Great'),genre('comedy film'),published(2019)).
movie(title('Maleficent: Mistress of Evil'),genre('adventure film'),published(2019)).
movie(title('Piercing'),genre('comedy horror'),published(2019)).
movie(title('Once Upon a Time in Staten Island'),genre('drama film'),published(2019)).
movie(title('Stuber'),genre('comedy film'),published(2019)).
movie(title('Charlie''s Angels'),genre('adventure film'),published(2019)).
movie(title('Daniel Isn''t Real'),genre('horror film'),published(2019)).
movie(title('Cats'),genre('musical film'),published(2019)).
movie(title('A Beautiful Day in the Neighborhood'),genre('biographical film'),published(2019)).
movie(title('The Prodigy'),genre('thriller film'),published(2019)).
movie(title('Just Mercy'),genre('biographical film'),published(2019)).
movie(title('UglyDolls'),genre('musical film'),published(2019)).
movie(title('After'),genre('drama film'),published(2019)).
movie(title('Midway 2019 Film'),genre('action film'),published(2019)).
movie(title('UglyDolls'),genre('comedy film'),published(2019)).
movie(title('After'),genre('romance film'),published(2019)).
movie(title('Knives Out'),genre('crime film'),published(2019)).
movie(title('Scooby-Doo! and the Curse of the 13th Ghost'),genre('mystery film'),published(2019)).
movie(title('The Biggest Little Farm'),genre('documentary film'),published(2019)).
movie(title('UglyDolls'),genre('computer-animated film'),published(2019)).
movie(title('Cliffs of Freedom'),genre('independent film'),published(2019)).
movie(title('UglyDolls'),genre('jukebox musical'),published(2019)).
movie(title('Love is Blind'),genre('comedy-drama'),published(2019)).
movie(title('Cats'),genre('comedy-drama'),published(2019)).
movie(title('Cats'),genre('drama film'),published(2019)).
movie(title('Charlie''s Angels'),genre('action film'),published(2019)).
movie(title('An Acceptable Loss'),genre('political thriller'),published(2019)).
movie(title('Generation Wealth'),genre('documentary film'),published(2019)).
movie(title('Midway 2019 Film'),genre('war film'),published(2019)).
movie(title('A Beautiful Day in the Neighborhood'),genre('drama film'),published(2019)).
movie(title('Just Mercy'),genre('drama film'),published(2019)).
movie(title('Daniel Isn''t Real'),genre('thriller film'),published(2019)).
movie(title('Knives Out'),genre('comedy film'),published(2019)).
movie(title('Knives Out'),genre('thriller film'),published(2019)).
movie(title('I Am Mother'),genre('science fiction film'),published(2019)).
movie(title('Midway 2019 Film'),genre('drama film'),published(2019)).
movie(title('Charlie''s Angels'),genre('comedy film'),published(2019)).
movie(title('Hobbs & Shaw'),genre('action film'),published(2019)).
movie(title('I Am Mother'),genre('thriller film'),published(2019)).
movie(title('Midway 2019 Film'),genre('historical film'),published(2019)).
movie(title('21 Bridges'),genre('action film'),published(2019)).
movie(title('Walk Ride Rodeo'),genre('biographical film'),published(2019)).
movie(title('Troupe Zero'),genre('drama film'),published(2019)).
movie(title('Prospect'),genre('science fiction film'),published(2019)).
movie(title('Knives Out'),genre('drama film'),published(2019)).
movie(title('Knives Out'),genre('mystery film'),published(2019)).
movie(title('John Henry'),genre('thriller film'),published(2019)).
movie(title('The Prodigy'),genre('horror film'),published(2019)).
movie(title('Hobbs & Shaw'),genre('action thriller'),published(2019)).
movie(title('Hobbs & Shaw'),genre('thriller film'),published(2019)).
movie(title('Cliffs of Freedom'),genre('drama film'),published(2019)).
movie(title('21 Bridges'),genre('thriller film'),published(2019)).
movie(title('John Henry'),genre('drama film'),published(2019)).
movie(title('John Henry'),genre('hood film'),published(2019)).
movie(title('Cats'),genre('fantasy film'),published(2019)).
movie(title('Cliffs of Freedom'),genre('historical film'),published(2019)).
movie(title('Walk Ride Rodeo'),genre('comedy-drama'),published(2019)).
movie(title('Walk Ride Rodeo'),genre('drama film'),published(2019)).
movie(title('The Perfect Date'),genre('comedy film'),published(2019)).
movie(title('Us'),genre('thriller film'),published(2019)).
movie(title('The Kitchen'),genre('crime film'),published(2019)).
movie(title('To the Stars'),genre('independent film'),published(2019)).
movie(title('Doctor Sleep'),genre('horror film'),published(2019)).
movie(title('Spenser Confidential'),genre('drama film'),published(2019)).
movie(title('Ready or Not'),genre('thriller film'),published(2019)).
movie(title('Black and Blue'),genre('crime film'),published(2019)).
movie(title('Breakthrough'),genre('drama film'),published(2019)).
movie(title('The Art of Racing in the Rain'),genre('comedy-drama'),published(2019)).
movie(title('Dora and the Lost City of Gold'),genre('family film'),published(2019)).
movie(title('The Price of Everything'),genre('documentary film'),published(2019)).
movie(title('Super Intelligence'),genre('action comedy film'),published(2019)).
movie(title('Little Women'),genre('drama film'),published(2019)).
movie(title('The Art of Racing in the Rain'),genre('romance film'),published(2019)).
movie(title('The Kid'),genre('action film'),published(2019)).
movie(title('Rust Creek'),genre('thriller film'),published(2019)).
movie(title('Nicole & O.J.'),genre('crime thriller'),published(2019)).
movie(title('Midsommar'),genre('thriller film'),published(2019)).
movie(title('Only'),genre('drama film'),published(2019)).
movie(title('The Kid'),genre('biographical film'),published(2019)).
movie(title('Reign of the Supermen'),genre('adventure film'),published(2019)).
movie(title('Spawn'),genre('horror film'),published(2019)).
movie(title('Bombshell'),genre('drama film'),published(2019)).
movie(title('Cities of Last Things'),genre('drama film'),published(2019)).
movie(title('Togo'),genre('drama film'),published(2019)).
movie(title('Yes, God, Yes'),genre('drama film'),published(2019)).
movie(title('Midsommar'),genre('drama film'),published(2019)).
movie(title('Black and Blue'),genre('thriller film'),published(2019)).
movie(title('All-Star Weekend'),genre('comedy-drama'),published(2019)).
movie(title('The Aeronauts'),genre('action film'),published(2019)).
movie(title('All-Star Weekend'),genre('drama film'),published(2019)).
movie(title('The Kill Team'),genre('action film'),published(2019)).
movie(title('Embody the Homicide'),genre('slasher film'),published(2019)).
movie(title('Spawn'),genre('action film'),published(2019)).
movie(title('The Tax Collector'),genre('crime film'),published(2019)).
movie(title('Big Time Adolescence'),genre('comedy film'),published(2019)).
movie(title('The Kitchen'),genre('comedy-drama'),published(2019)).
movie(title('The Aeronauts'),genre('biographical film'),published(2019)).
movie(title('The Kitchen'),genre('drama film'),published(2019)).
movie(title('Wine Country'),genre('comedy film'),published(2019)).
movie(title('The Tax Collector'),genre('action film'),published(2019)).
movie(title('The Kid'),genre('drama film'),published(2019)).
movie(title('To the Stars'),genre('drama film'),published(2019)).
movie(title('Black and Blue'),genre('drama film'),published(2019)).
movie(title('Low Tide'),genre('drama film'),published(2019)).
movie(title('Free Solo'),genre('documentary film'),published(2019)).
movie(title('93 Queen'),genre(documentary),published(2019)).
movie(title('Us'),genre('horror film'),published(2019)).
movie(title('Them That Follow'),genre('thriller film'),published(2019)).
movie(title('Adopt a Highway'),genre('drama film'),published(2019)).
movie(title('Spenser Confidential'),genre('action film'),published(2019)).
movie(title('The Kill Team'),genre('war film'),published(2019)).
movie(title('Ready or Not'),genre('black comedy film'),published(2019)).
movie(title('Us'),genre('psychological horror'),published(2019)).
movie(title('Bad Education'),genre('comedy-drama'),published(2019)).
movie(title('Us'),genre('action film'),published(2019)).
movie(title('The Kid'),genre('Western film'),published(2019)).
movie(title('The Tax Collector'),genre('thriller film'),published(2019)).
movie(title('Breakthrough'),genre('biographical film'),published(2019)).
movie(title('Midsommar'),genre('horror film'),published(2019)).
movie(title('The Aeronauts'),genre('drama film'),published(2019)).
movie(title('Villains'),genre('thriller film'),published(2019)).
movie(title('The Aeronauts'),genre(adventure),published(2019)).
movie(title('The Kill Team'),genre('drama film'),published(2019)).
movie(title('Roe v. Wade'),genre('legal drama'),published(2019)).
movie(title('Three Identical Strangers'),genre('documentary film'),published(2019)).
movie(title('Spawn'),genre(thriller),published(2019)).
movie(title('The Aeronauts'),genre(biography),published(2019)).
movie(title('The Souvenir'),genre('drama film'),published(2019)).
movie(title('Us'),genre('science fiction film'),published(2019)).
movie(title('The Perfect Date'),genre('romantic comedy'),published(2019)).
movie(title('Fyre Fraud'),genre('documentary film'),published(2019)).
movie(title('A Dog''s Journey'),genre('family film'),published(2019)).
movie(title('The Black Godfather'),genre('biographical film'),published(2019)).
movie(title('Jexi'),genre('comedy film'),published(2019)).
movie(title('Apollo 11'),genre('documentary film'),published(2019)).
movie(title('Incoming'),genre('thriller film'),published(2019)).
movie(title('Critters Attack!'),genre('comedy horror'),published(2019)).
movie(title('Life Like'),genre('thriller film'),published(2019)).
movie(title('Running with Beto'),genre('documentary film'),published(2019)).
movie(title('Color Out of Space'),genre('science fiction film'),published(2019)).
movie(title('47 Meters Down: Uncaged'),genre('horror film'),published(2019)).
movie(title('Dance Night Obsession'),genre('dance film'),published(2019)).
movie(title('Game of Thrones: The Last Watch'),genre('documentary film'),published(2019)).
movie(title('The Laundromat'),genre('drama film'),published(2019)).
movie(title('The Great Hack'),genre('documentary film'),published(2019)).
movie(title('Knives and Skin'),genre('LGBT-related film'),published(2019)).
movie(title('Come As You Are'),genre('drama film'),published(2019)).
movie(title('At the Heart of Gold: Inside the USA Gymnastics Scandal'),genre('documentary film'),published(2019)).
movie(title('A Dog''s Way Home'),genre('drama film'),published(2019)).
movie(title('Backdraft 2'),genre('drama film'),published(2019)).
movie(title('A Dog''s Journey'),genre('adventure film'),published(2019)).
movie(title('Echo In the Canyon'),genre('documentary film'),published(2019)).
movie(title('El Camino: A Breaking Bad Movie'),genre('drama film'),published(2019)).
movie(title('Tall Girl'),genre('romantic comedy'),published(2019)).
movie(title('Falling Inn Love'),genre('romantic comedy'),published(2019)).
movie(title('Love You to Death'),genre('drama film'),published(2019)).
movie(title('The Best of Enemies'),genre('biographical film'),published(2019)).
movie(title('Doom: Annihilation'),genre('horror film'),published(2019)).
movie(title('The Inventor: Out for Blood in Silicon Valley'),genre('documentary film'),published(2019)).
movie(title('A Score to Settle'),genre('action thriller'),published(2019)).
movie(title('Killers Anonymous'),genre('crime thriller'),published(2019)).
movie(title('Hail Satan?'),genre('documentary film'),published(2019)).
movie(title('A Dog''s Way Home'),genre('family film'),published(2019)).
movie(title('Brightburn'),genre('horror film'),published(2019)).
movie(title('Dreamland'),genre('thriller film'),published(2019)).
movie(title('Unplanned'),genre('drama film'),published(2019)).
movie(title('Christmas Coupon'),genre('drama film'),published(2019)).
movie(title('The Devil We Know'),genre('documentary film'),published(2019)).
movie(title('Don''t Let Go'),genre('thriller film'),published(2019)).
movie(title('Kill Chain'),genre('thriller film'),published(2019)).
movie(title('Armstrong'),genre('documentary film'),published(2019)).
movie(title('Doom: Annihilation'),genre('action film'),published(2019)).
movie(title('I Love You, Now Die: The Commonwealth Vs. Michelle Carter'),genre('documentary film'),published(2019)).
movie(title('Where Two Streets Meet'),genre('short film'),published(2019)).
movie(title('Neverland Firsthand: Investigating the Michael Jackson Documentary'),genre('documentary film'),published(2019)).
movie(title('Slasher Party'),genre('horror film'),published(2019)).
movie(title('Dreamland'),genre('drama film'),published(2019)).
movie(title('Project X-Traction'),genre('action film'),published(2019)).
movie(title('The Outpost'),genre('drama film'),published(2019)).
movie(title('From Zero to I Love You'),genre('romantic comedy'),published(2019)).
movie(title('Black Ruby'),genre('drama film'),published(2019)).
movie(title('Kitbull'),genre('animated film'),published(2019)).
movie(title('Fractured'),genre('thriller film'),published(2019)).
movie(title('Shooting the Mafia'),genre('documentary film'),published(2019)).
movie(title('Killing Kate'),genre(thriller),published(2019)).
movie(title('Surfer Dan'),genre('documentary film'),published(2019)).
movie(title('Satanic Panic'),genre('comedy horror'),published(2019)).
movie(title('The Day Shall Come'),genre('thriller film'),published(2019)).
movie(title('The Best of Enemies'),genre('drama film'),published(2019)).
movie(title('Loqueesha'),genre('comedy film'),published(2019)).
movie(title('Above the Shadows'),genre('romance film'),published(2019)).
movie(title('Ringside'),genre('documentary film'),published(2019)).
movie(title('Knock Down the House'),genre('documentary film'),published(2019)).
movie(title('The Banana Splits Movie'),genre('horror film'),published(2019)).
movie(title('Good Sam'),genre('drama film'),published(2019)).
movie(title('The Black Godfather'),genre('documentary film'),published(2019)).
movie(title('Doom: Annihilation'),genre('science fiction film'),published(2019)).
movie(title('I Trapped the Devil'),genre('independent film'),published(2019)).
movie(title('47 Meters Down: Uncaged'),genre('survival film'),published(2019)).
movie(title('Project X-Traction'),genre('thriller film'),published(2019)).
movie(title('Color Out of Space'),genre('horror film'),published(2019)).
movie(title('Echo In the Canyon'),genre('musical film'),published(2019)).
movie(title('Princess Rita'),genre('drama film'),published(2019)).
movie(title('Pavarotti'),genre('documentary film'),published(2019)).
movie(title('El Camino: A Breaking Bad Movie'),genre('crime film'),published(2019)).
movie(title('Lucy in the Sky'),genre('drama film'),published(2019)).
movie(title('David Crosby: Remember My Name'),genre('documentary film'),published(2019)).
movie(title('Brightburn'),genre('superhero film'),published(2019)).
movie(title('Scooby-Doo! Return to Zombie Island'),genre('comedy horror'),published(2019)).
movie(title('Sunrise in Heaven'),genre('drama film'),published(2019)).
movie(title('Knives and Skin'),genre('thriller film'),published(2019)).
movie(title('To the Night'),genre('drama film'),published(2019)).
movie(title('Incoming'),genre('action film'),published(2019)).
movie(title('Sunrise in Heaven'),genre('romance film'),published(2019)).
movie(title('From Zero to I Love You'),genre('LGBT-related film'),published(2019)).
movie(title('Bliss'),genre('horror film'),published(2019)).
movie(title('Katherine Ryan: Glitter Room'),genre('stand-up comedy'),published(2019)).
movie(title('A Dog''s Journey'),genre('comedy-drama'),published(2019)).
movie(title('Shooting the Mafia'),genre('biographical film'),published(2019)).
movie(title('The Mustang'),genre('drama film'),published(2019)).
movie(title('Black Ruby'),genre('independent film'),published(2019)).
movie(title('Come As You Are'),genre('comedy film'),published(2019)).
movie(title('Marianne & Leonard: Words of Love'),genre('documentary film'),published(2019)).
movie(title('Love, Antosha'),genre('documentary film'),published(2019)).
movie(title('Incoming'),genre('science fiction film'),published(2019)).
movie(title('Walking on Water'),genre('documentary film'),published(2019)).
movie(title('Justice League vs. the Fatal Five'),genre('superhero film'),published(2019)).
movie(title('The Nest'),genre('thriller film'),published(2019)).
movie(title('Untitled Drake Doremus film'),genre('drama film'),published(2019)).
movie(title('Let the Bell Ring'),genre('documentary film'),published(2019)).
movie(title('Sextuplets'),genre('comedy film'),published(2019)).
movie(title('Danger Close: The Battle of Long Tan'),genre('war film'),published(2019)).
movie(title('Jumanji: The Next Level'),genre('comedy film'),published(2019)).
movie(title('Fyre: The Greatest Party That Never Happened'),genre('documentary film'),published(2019)).
movie(title('The Nest'),genre('drama film'),published(2019)).
movie(title('Danger Close: The Battle of Long Tan'),genre('drama film'),published(2019)).
movie(title('Queen & Slim'),genre('drama film'),published(2019)).
movie(title('Little'),genre('fantasy film'),published(2019)).
movie(title('Adam'),genre('LGBT-related film'),published(2019)).
movie(title('Luce'),genre('drama film'),published(2019)).
movie(title('Before You Know It'),genre('LGBT-related film'),published(2019)).
movie(title('Jumanji: The Next Level'),genre('action comedy film'),published(2019)).
movie(title('Dark Waters'),genre('biographical film'),published(2019)).
movie(title('Little'),genre('comedy film'),published(2019)).
movie(title('Last Christmas'),genre('romantic comedy'),published(2019)).
movie(title('The Sound of Silence'),genre('drama film'),published(2019)).
movie(title('Jumanji: The Next Level'),genre('adventure film'),published(2019)).
movie(title('The Operative'),genre('drama film'),published(2019)).
movie(title('The Farewell'),genre('comedy-drama'),published(2019)).
movie(title('The Farewell'),genre('drama film'),published(2019)).
movie(title('The Haunting of Sharon Tate'),genre('horror film'),published(2019)).
movie(title('Blackbird'),genre('drama film'),published(2019)).
movie(title('The Gentlemen'),genre('crime film'),published(2019)).
movie(title('Dark Waters'),genre('drama film'),published(2019)).
movie(title('Blush'),genre('drama film'),published(2019)).
movie(title('Dark Waters'),genre(drama),published(2019)).
movie(title('Clemency'),genre('drama film'),published(2019)).
movie(title('Dark Waters'),genre('historical film'),published(2019)).
movie(title('Hala'),genre('drama film'),published(2019)).
movie(title('Ms. Purple'),genre('drama film'),published(2019)).
movie(title('Before You Know It'),genre('comedy film'),published(2019)).
movie(title('Black Christmas'),genre('horror film'),published(2019)).
movie(title('Memory Games'),genre('documentary film'),published(2019)).
movie(title('Making Waves: The Art of Cinematic Sound'),genre('documentary film'),published(2019)).
movie(title('Playing with Fire'),genre('comedy film'),published(2019)).
movie(title('First Cow'),genre('fantasy film'),published(2019)).
movie(title('Screwball'),genre('documentary film'),published(2019)).
movie(title('Linda Ronstadt: The Sound of My Voice'),genre('biographical film'),published(2019)).
movie(title('Capsized: Blood in the Water'),genre('action thriller'),published(2019)).
movie(title('Synchronic'),genre('drama film'),published(2019)).
movie(title('Greener Grass'),genre('comedy film'),published(2019)).
movie(title('Alien Warfare'),genre('science fiction film'),published(2019)).
movie(title('Homecoming'),genre('concert film'),published(2019)).
movie(title('Marisol'),genre('drama film'),published(2019)).
movie(title('The Wrong Tutor'),genre('fiction film'),published(2019)).
movie(title('A Cinderella Story: Christmas Wish'),genre('Christmas film'),published(2019)).
movie(title('Amazing Grace'),genre('musical film'),published(2019)).
movie(title('Dick Move'),genre('comedy film'),published(2019)).
movie(title('Light from Light'),genre('drama film'),published(2019)).
movie(title('The Other Lamb'),genre('horror film'),published(2019)).
movie(title('Notes from Melanie'),genre('comedy film'),published(2019)).
movie(title('Richard Jewell'),genre('crime film'),published(2019)).
movie(title('Bottom Of The 9th'),genre('sport film'),published(2019)).
movie(title('After Midnight'),genre('horror film'),published(2019)).
movie(title('Mickey and the Bear'),genre('independent film'),published(2019)).
movie(title('Body at Brighton Rock'),genre('thriller film'),published(2019)).
movie(title('This Mountain Life'),genre('documentary film'),published(2019)).
movie(title('Léa & I'),genre('documentary film'),published(2019)).
movie(title('American Factory'),genre('documentary film'),published(2019)).
movie(title('Playing with Fire'),genre('family film'),published(2019)).
movie(title('American Exit'),genre('drama film'),published(2019)).
movie(title('Michael Jackson: Chase the Truth'),genre('documentary film'),published(2019)).
movie(title('Cut Throat City'),genre('action film'),published(2019)).
movie(title('Trixie Mattel: Moving Parts'),genre('LGBT-related film'),published(2019)).
movie(title('The Last Whistle'),genre('sport film'),published(2019)).
movie(title('Very Senior - Attitude is everything'),genre('documentary film'),published(2019)).
movie(title('Secret Obsession'),genre('psychological thriller'),published(2019)).
movie(title('A Room Full of Nothing'),genre('drama film'),published(2019)).
movie(title('Lucky'),genre('comedy film'),published(2019)).
movie(title('Nickelodeon''s Lucky'),genre('fantasy film'),published(2019)).
movie(title('Big Shark'),genre('drama film'),published(2019)).
movie(title('Mary'),genre('horror film'),published(2019)).
movie(title('Hustlers'),genre('comedy-drama'),published(2019)).
movie(title('Black Christmas'),genre('thriller film'),published(2019)).
movie(title('Bad Trip'),genre('comedy film'),published(2019)).
movie(title('Hustlers'),genre('drama film'),published(2019)).
movie(title('Lying and Stealing'),genre('crime film'),published(2019)).
movie(title('Trixie Mattel: Moving Parts'),genre('documentary film'),published(2019)).
movie(title('Human Nature'),genre('documentary film'),published(2019)).
movie(title('Cut Throat City'),genre('heist film'),published(2019)).
movie(title('Zuzana: Music is Life'),genre('documentary film'),published(2019)).
movie(title('Burning Cane'),genre('drama film'),published(2019)).
movie(title('Richard Jewell'),genre('biographical film'),published(2019)).
movie(title('The Russian Bride'),genre('horror film'),published(2019)).
movie(title('American Woman'),genre('drama film'),published(2019)).
movie(title('We Are the Radical Monarchs'),genre('LGBT-related film'),published(2019)).
movie(title('Vault'),genre('mafia film'),published(2019)).
movie(title('We Are the Radical Monarchs'),genre('documentary film'),published(2019)).
movie(title('Black Christmas'),genre('mystery film'),published(2019)).
movie(title('Mike Wallace Is Here'),genre('documentary film'),published(2019)).
movie(title('Richard Jewell'),genre('thriller film'),published(2019)).
movie(title('Hello Privilege. It''s Me, Chelsea'),genre('documentary film'),published(2019)).
movie(title('Can You Keep a Secret?'),genre('comedy film'),published(2019)).
movie(title('Linda Ronstadt: The Sound of My Voice'),genre('documentary film'),published(2019)).
movie(title('Ham on Rye'),genre('independent film'),published(2019)).
movie(title('Aziz Ansari: Right Now'),genre('stand-up comedy'),published(2019)).
movie(title('Mayday'),genre('horror film'),published(2019)).
movie(title('Ode to Joy'),genre('comedy film'),published(2019)).
movie(title('Ladyworld'),genre('thriller film'),published(2019)).
movie(title('Chimera Strain'),genre('drama film'),published(2019)).
movie(title('Amazing Grace'),genre('documentary film'),published(2019)).
movie(title('Angel of Mine'),genre('drama film'),published(2019)).
movie(title('Cut Throat City'),genre('drama film'),published(2019)).
movie(title('Richard Jewell'),genre('drama film'),published(2019)).
movie(title('The Short History of the Long Road'),genre('drama film'),published(2019)).
movie(title('Plus One'),genre('romantic comedy'),published(2019)).
movie(title('Mercy Black'),genre('horror film'),published(2019)).
movie(title(1917),genre('war film'),published(2019)).
movie(title('Mickey and the Bear'),genre('drama film'),published(2019)).
movie(title('Big Shark'),genre('horror film'),published(2019)).
movie(title('Black Christmas'),genre('Christmas film'),published(2019)).
movie(title('The Death of Dick Long'),genre('comedy film'),published(2019)).
movie(title('Hot Air'),genre('drama film'),published(2019)).
movie(title('See You Yesterday'),genre('teen film'),published(2019)).
movie(title('Barstow, California'),genre('documentary film'),published(2019)).
movie(title('Body at Brighton Rock'),genre('horror film'),published(2019)).
movie(title('Lying and Stealing'),genre('drama film'),published(2019)).
movie(title('Slay the Dragon'),genre('documentary film'),published(2019)).
movie(title('Wonder Woman: Bloodlines'),genre('action film'),published(2019)).
movie(title('Mike Epps: Only One Mike'),genre('stand-up comedy'),published(2019)).
movie(title('Hustlers'),genre('crime film'),published(2019)).
movie(title('Adam DeVine: Best Time of Our Lives'),genre('stand-up comedy'),published(2019)).
movie(title('Homecoming'),genre('documentary film'),published(2019)).
movie(title('Carbon'),genre('thriller film'),published(2019)).
movie(title('Burn'),genre('thriller film'),published(2019)).
movie(title('Alien Warfare'),genre('action film'),published(2019)).
movie(title(1917),genre('drama film'),published(2019)).
movie(title('Rottentail'),genre('comedy horror'),published(2019)).
movie(title('Selah and the Spades'),genre('teen film'),published(2019)).
movie(title('Itsy Bitsy'),genre('horror film'),published(2019)).
movie(title('Dirty John, The Dirty Truth'),genre('documentary film'),published(2019)).
movie(title('See You Yesterday'),genre('science fiction film'),published(2019)).
movie(title('Penguins'),genre('documentary film'),published(2019)).
movie(title('Calum Von Moger: Unbroken'),genre('documentary film'),published(2019)).
movie(title('The Tomorrow Man'),genre('drama film'),published(2019)).
movie(title('After Class'),genre('comedy-drama'),published(2019)).
movie(title('Entrenched: Prologue'),genre('drama film'),published(2019)).
movie(title('Zilla and Zoe'),genre('comedy film'),published(2019)).
movie(title('Bennett''s War'),genre('sport film'),published(2019)).
movie(title('Rattlesnake'),genre('drama film'),published(2019)).
movie(title('Santa Fake'),genre('Christmas film'),published(2019)).
movie(title('Weightless'),genre('drama film'),published(2019)).
movie(title('Miles Davis: Birth of the Cool'),genre('documentary film'),published(2019)).
movie(title('Haunt'),genre('horror film'),published(2019)).
movie(title('The Trap'),genre('comedy film'),published(2019)).
movie(title('The Flourish'),genre('drama film'),published(2019)).
movie(title('The Vast of Night'),genre('thriller film'),published(2019)).
movie(title('Cunningham'),genre('biographical film'),published(2019)).
movie(title('Trick'),genre('slasher film'),published(2019)).
movie(title('Spirits in the Forest'),genre('musical film'),published(2019)).
movie(title('Holiday Rush'),genre('Christmas film'),published(2019)).
movie(title('Trauma Center'),genre('thriller film'),published(2019)).
movie(title('All in My Family'),genre('documentary film'),published(2019)).
movie(title('Up to Snuff'),genre('documentary film'),published(2019)).
movie(title('Wrinkles the Clown'),genre('horror film'),published(2019)).
movie(title('Cunningham'),genre('musical film'),published(2019)).
movie(title('The Other Side of Heaven 2: Fire of Faith'),genre('independent film'),published(2019)).
movie(title('Stray Dolls'),genre('crime film'),published(2019)).
movie(title('Loud Krazy Love'),genre('biographical film'),published(2019)).
movie(title('The Knight Before Christmas'),genre('Christmas film'),published(2019)).
movie(title('Jesus Is King'),genre('concert film'),published(2019)).
movie(title('Countdown'),genre('horror film'),published(2019)).
movie(title('Into the Okavango'),genre('documentary film'),published(2019)).
movie(title('Disappearance'),genre('thriller film'),published(2019)).
movie(title('Winterland'),genre('documentary film'),published(2019)).
movie(title('We Summon the Darkness'),genre('horror film'),published(2019)).
movie(title('Standing Up, Falling Down'),genre('comedy film'),published(2019)).
movie(title('I Am Woman'),genre('biographical film'),published(2019)).
movie(title('Bit'),genre('LGBT-related film'),published(2019)).
movie(title('Night Walk'),genre('crime film'),published(2019)).
movie(title('Cuck'),genre('independent film'),published(2019)).
movie(title('Teenage Lesbian'),genre('pornographic film'),published(2019)).
movie(title('Wish Man'),genre('drama film'),published(2019)).
movie(title('Artik'),genre('horror film'),published(2019)).
movie(title('Last Ferry'),genre('thriller film'),published(2019)).
movie(title('Moon of the Blood Beast'),genre('horror film'),published(2019)).
movie(title('Romantic Warriors IV: Krautrock (Part I)'),genre('documentary film'),published(2019)).
movie(title('Vaxxed II: The People''s Truth'),genre('documentary film'),published(2019)).
movie(title('Haunt'),genre('thriller film'),published(2019)).
movie(title('Olympic Dreams'),genre('comedy film'),published(2019)).
movie(title('Christmas Break-In'),genre('comedy film'),published(2019)).
movie(title('Tuscaloosa'),genre('drama film'),published(2019)).
movie(title('7 Days to Vegas'),genre('comedy film'),published(2019)).
movie(title('San Andreas Mega Quake'),genre('disaster film'),published(2019)).
movie(title('Dads'),genre('documentary film'),published(2019)).
movie(title('Circus of Books'),genre('documentary film'),published(2019)).
movie(title('Bit'),genre('horror film'),published(2019)).
movie(title('Rolling Thunder Revue: A Bob Dylan Story by Martin Scorsese'),genre('documentary film'),published(2019)).
movie(title('The Rise of the Synths'),genre('documentary film'),published(2019)).
movie(title('Every Time I Die'),genre('independent film'),published(2019)).
movie(title('Last Ferry'),genre('drama film'),published(2019)).
movie(title('Devil''s Night: Dawn of the Nain Rouge'),genre('horror film'),published(2019)).
movie(title('The Obituary of Tunde Johnson'),genre('LGBT-related film'),published(2019)).
movie(title('Miles Davis: Birth of the Cool'),genre('musical film'),published(2019)).
movie(title('Becoming Nobody'),genre('documentary film'),published(2019)).
movie(title('Q86826438'),genre('parody film'),published(2019)).
movie(title('Spirits in the Forest'),genre('documentary film'),published(2019)).
movie(title('Q86826438'),genre('pornographic film'),published(2019)).
movie(title('Mermaid Down'),genre('horror film'),published(2019)).
movie(title('Cunningham'),genre('documentary film'),published(2019)).
movie(title('Dancing with the Birds'),genre('documentary film'),published(2019)).
movie(title('Impossible Monsters'),genre(thriller),published(2019)).
movie(title('We Die Young'),genre('action film'),published(2019)).
movie(title('Ask Dr. Ruth'),genre('documentary film'),published(2019)).
movie(title('Last Ferry'),genre('LGBT-related film'),published(2019)).
movie(title('League of Legends: Origins'),genre('documentary film'),published(2019)).
movie(title('Mermaid Down'),genre('fantasy film'),published(2019)).
movie(title('Loud Krazy Love'),genre('documentary film'),published(2019)).
movie(title('Metallica & San Francisco Symphony S&M 2'),genre('documentary film'),published(2019)).
movie(title('Rolling Thunder Revue: A Bob Dylan Story by Martin Scorsese'),genre('concert film'),published(2019)).
movie(title('The World Before Your Feet'),genre('documentary film'),published(2019)).
movie(title('Chained for Life'),genre('drama film'),published(2019)).
movie(title('Faith, Hope & Love'),genre('romantic comedy'),published(2019)).
movie(title('Airplane Mode'),genre('parody film'),published(2019)).
movie(title('Aquarela'),genre('documentary film'),published(2019)).
movie(title('Raising Buchanan'),genre('buddy film'),published(2019)).
movie(title('Gay Chorus Deep South'),genre('LGBT-related film'),published(2019)).
movie(title('Trapped: The Alex Cooper Story'),genre('LGBT-related film'),published(2019)).
movie(title('The Mortuary Collection'),genre('anthology film'),published(2019)).
movie(title('Last Tango in Harlem'),genre('drama film'),published(2019)).
movie(title('American Son'),genre('drama film'),published(2019)).
movie(title('A Christmas Prince: The Royal Baby'),genre('romantic comedy'),published(2019)).
movie(title('Girl on the Third Floor'),genre('horror film'),published(2019)).
movie(title('Trauma Center'),genre('action film'),published(2019)).
movie(title('Bikram: Yogi, Guru, Predator'),genre('documentary film'),published(2019)).
movie(title('Gay Chorus Deep South'),genre('documentary film'),published(2019)).
movie(title('Trapped: The Alex Cooper Story'),genre('LGBTI+ related TV series'),published(2019)).
movie(title('Gangsters Incorporated'),genre('action comedy film'),published(2019)).
movie(title('Romantic Warriors IV: Krautrock (Part I)'),genre('musical film'),published(2019)).
movie(title('Bit'),genre('comedy film'),published(2019)).
movie(title('Music, War and Love'),genre('drama film'),published(2019)).
movie(title('Undercover Brother 2'),genre('action comedy film'),published(2019)).
movie(title('Wrinkles the Clown'),genre('documentary film'),published(2019)).
movie(title('The Crystal Calls Making the Dark Crystal: Age of Resistance'),genre('making-of'),published(2019)).
movie(title('Metallica & San Francisco Symphony S&M 2'),genre('concert film'),published(2019)).


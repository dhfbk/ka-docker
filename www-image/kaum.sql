-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Creato il: Dic 13, 2022 alle 14:35
-- Versione del server: 10.7.3-MariaDB-1:10.7.3+maria~focal
-- Versione PHP: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kaum`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `creender_annotations`
--

CREATE TABLE `creender_annotations` (
  `id` int(11) NOT NULL,
  `dtc_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `data` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `creender_choices`
--

CREATE TABLE `creender_choices` (
  `id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `data` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `creender_datasets`
--

CREATE TABLE `creender_datasets` (
  `id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `test` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `creender_ds_task_cluster`
--

CREATE TABLE `creender_ds_task_cluster` (
  `id` int(11) NOT NULL,
  `row` int(11) NOT NULL,
  `task` int(11) NOT NULL,
  `cluster` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `creender_rows`
--

CREATE TABLE `creender_rows` (
  `id` int(11) NOT NULL,
  `dataset_id` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `hssh_annotations`
--

CREATE TABLE `hssh_annotations` (
  `id` int(11) NOT NULL,
  `sentence` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `modified_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `hssh_datasets`
--

CREATE TABLE `hssh_datasets` (
  `id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `task_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `lang` varchar(2) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `type` enum('gr','ch') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `hssh_ds_task_cluster`
--

CREATE TABLE `hssh_ds_task_cluster` (
  `id` int(11) NOT NULL,
  `row` int(11) NOT NULL,
  `task` int(11) NOT NULL,
  `cluster` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `hssh_rows`
--

CREATE TABLE `hssh_rows` (
  `id` int(11) NOT NULL,
  `dataset_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `goldLabel` tinyint(4) NOT NULL DEFAULT 0,
  `goldTokens` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `options`
--

CREATE TABLE `options` (
  `id` varchar(200) NOT NULL,
  `value` text NOT NULL,
  `api` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `options`
--

INSERT INTO `options` (`id`, `value`, `api`) VALUES
('creender_choicelist_name_minlength', '4', 1),
('creender_dataset_name_minlength', '4', 1),
('creender_default_answer', 'Why would you make fun of this user?', 1),
('creender_default_comment', 'What would you write?', 1),
('creender_default_question', 'If you saw this picture on Instagram, would you make fun of the user who posted it?', 1),
('creender_images_path', '/var/www/tasks/creender_images', 0),
('creender_photos_educator', '10', 1),
('hssh_dataset_name_minlength', '4', 1),
('languages', 'it,en', 1),
('max_user_name_len', '25', 0),
('nouns_for_passwords', 'people\nhistory\nway\nart\nworld\ninformation\nmap\ntwo\nfamily\ngovernment\nhealth\nsystem\ncomputer\nmeat\nyear\nthanks\nmusic\nperson\nreading\nmethod\ndata\nfood\nunderstanding\ntheory\nlaw\nbird\nliterature\nproblem\nsoftware\ncontrol\nknowledge\npower\nability\neconomics\nlove\ninternet\ntelevision\nscience\nlibrary\nnature\nfact\nproduct\nidea\ntemperature\ninvestment\narea\nsociety\nactivity\nstory\nindustry\nmedia\nthing\noven\ncommunity\ndefinition\nsafety\nquality\ndevelopment\nlanguage\nmanagement\nplayer\nvariety\nvideo\nweek\nsecurity\ncountry\nexam\nmovie\norganization\nequipment\nphysics\nanalysis\npolicy\nseries\nthought\nbasis\nboyfriend\ndirection\nstrategy\ntechnology\narmy\ncamera\nfreedom\npaper\nenvironment\nchild\ninstance\nmonth\ntruth\nmarketing\nuniversity\nwriting\narticle\ndepartment\ndifference\ngoal\nnews\naudience\nfishing\ngrowth\nincome\nmarriage\nuser\ncombination\nfailure\nmeaning\nmedicine\nphilosophy\nteacher\ncommunication\nnight\nchemistry\ndisease\ndisk\nenergy\nnation\nroad\nrole\nsoup\nadvertising\nlocation\nsuccess\naddition\napartment\neducation\nmath\nmoment\npainting\npolitics\nattention\ndecision\nevent\nproperty\nshopping\nstudent\nwood\ncompetition\ndistribution\nentertainment\noffice\npopulation\npresident\nunit\ncategory\ncigarette\ncontext\nintroduction\nopportunity\nperformance\ndriver\nflight\nlength\nmagazine\nnewspaper\nrelationship\nteaching\ncell\ndealer\nfinding\nlake\nmember\nmessage\nphone\nscene\nappearance\nassociation\nconcept\ncustomer\ndeath\ndiscussion\nhousing\ninflation\ninsurance\nmood\nwoman\nadvice\nblood\neffort\nexpression\nimportance\nopinion\npayment\nreality\nresponsibility\nsituation\nskill\nstatement\nwealth\napplication\ncity\ncounty\ndepth\nestate\nfoundation\ngrandmother\nheart\nperspective\nphoto\nrecipe\nstudio\ntopic\ncollection\ndepression\nimagination\npassion\npercentage\nresource\nsetting\nad\nagency\ncollege\nconnection\ncriticism\ndebt\ndescription\nmemory\npatience\nsecretary\nsolution\nadministration\naspect\nattitude\ndirector\npersonality\npsychology\nrecommendation\nresponse\nselection\nstorage\nversion\nalcohol\nargument\ncomplaint\ncontract\nemphasis\nhighway\nloss\nmembership\npossession\npreparation\nsteak\nunion\nagreement\ncancer\ncurrency\nemployment\nengineering\nentry\ninteraction\nmixture\npreference\nregion\nrepublic\ntradition\nvirus\nactor\nclassroom\ndelivery\ndevice\ndifficulty\ndrama\nelection\nengine\nfootball\nguidance\nhotel\nowner\npriority\nprotection\nsuggestion\ntension\nvariation\nanxiety\natmosphere\nawareness\nbath\nbread\ncandidate\nclimate\ncomparison\nconfusion\nconstruction\nelevator\nemotion\nemployee\nemployer\nguest\nheight\nleadership\nmall\nmanager\noperation\nrecording\nsample\ntransportation\ncharity\ncousin\ndisaster\neditor\nefficiency\nexcitement\nextent\nfeedback\nguitar\nhomework\nleader\nmom\noutcome\npermission\npresentation\npromotion\nreflection\nrefrigerator\nresolution\nrevenue\nsession\nsinger\ntennis\nbasket\nbonus\ncabinet\nchildhood\nchurch\nclothes\ncoffee\ndinner\ndrawing\nhair\nhearing\ninitiative\njudgment\nlab\nmeasurement\nmode\nmud\norange\npoetry\npolice\npossibility\nprocedure\nqueen\nratio\nrelation\nrestaurant\nsatisfaction\nsector\nsignature\nsignificance\nsong\ntooth\ntown\nvehicle\nvolume\nwife\naccident\nairport\nappointment\narrival\nassumption\nbaseball\nchapter\ncommittee\nconversation\ndatabase\nenthusiasm\nerror\nexplanation\nfarmer\ngate\ngirl\nhall\nhistorian\nhospital\ninjury\ninstruction\nmaintenance\nmanufacturer\nmeal\nperception\npie\npoem\npresence\nproposal\nreception\nreplacement\nrevolution\nriver\nson\nspeech\ntea\nvillage\nwarning\nwinner\nworker\nwriter\nassistance\nbreath\nbuyer\nchest\nchocolate\nconclusion\ncontribution\ncookie\ncourage\ndad\ndesk\ndrawer\nestablishment\nexamination\ngarbage\ngrocery\nhoney\nimpression\nimprovement\nindependence\ninsect\ninspection\ninspector\nking\nladder\nmenu\npenalty\npiano\npotato\nprofession\nprofessor\nquantity\nreaction\nrequirement\nsalad\nsister\nsupermarket\ntongue\nweakness\nwedding\naffair\nambition\nanalyst\napple\nassignment\nassistant\nbathroom\nbedroom\nbeer\nbirthday\ncelebration\nchampionship\ncheek\nclient\nconsequence\ndeparture\ndiamond\ndirt\near\nfortune\nfriendship\nfuneral\ngene\ngirlfriend\nhat\nindication\nintention\nlady\nmidnight\nnegotiation\nobligation\npassenger\npizza\nplatform\npoet\npollution\nrecognition\nreputation\nshirt\nsir\nspeaker\nstranger\nsurgery\nsympathy\ntale\nthroat\ntrainer\nuncle\nyouth\ntime\nwork\nfilm\nwater\nmoney\nexample\nwhile\nbusiness\nstudy\ngame\nlife\nform\nair\nday\nplace\nnumber\npart\nfield\nfish\nback\nprocess\nheat\nhand\nexperience\njob\nbook\nend\npoint\ntype\nhome\neconomy\nvalue\nbody\nmarket\nguide\ninterest\nstate\nradio\ncourse\ncompany\nprice\nsize\ncard\nlist\nmind\ntrade\nline\ncare\ngroup\nrisk\nword\nfat\nforce\nkey\nlight\ntraining\nname\nschool\ntop\namount\nlevel\norder\npractice\nresearch\nsense\nservice\npiece\nweb\nboss\nsport\nfun\nhouse\npage\nterm\ntest\nanswer\nsound\nfocus\nmatter\nkind\nsoil\nboard\noil\npicture\naccess\ngarden\nrange\nrate\nreason\nfuture\nsite\ndemand\nexercise\nimage\ncase\ncause\ncoast\naction\nage\nbad\nboat\nrecord\nresult\nsection\nbuilding\nmouse\ncash\nclass\nnothing\nperiod\nplan\nstore\ntax\nside\nsubject\nspace\nrule\nstock\nweather\nchance\nfigure\nman\nmodel\nsource\nbeginning\nearth\nprogram\nchicken\ndesign\nfeature\nhead\nmaterial\npurpose\nquestion\nrock\nsalt\nact\nbirth\ncar\ndog\nobject\nscale\nsun\nnote\nprofit\nrent\nspeed\nstyle\nwar\nbank\ncraft\nhalf\ninside\noutside\nstandard\nbus\nexchange\neye\nfire\nposition\npressure\nstress\nadvantage\nbenefit\nbox\nframe\nissue\nstep\ncycle\nface\nitem\nmetal\npaint\nreview\nroom\nscreen\nstructure\nview\naccount\nball\ndiscipline\nmedium\nshare\nbalance\nbit\nblack\nbottom\nchoice\ngift\nimpact\nmachine\nshape\ntool\nwind\naddress\naverage\ncareer\nculture\nmorning\npot\nsign\ntable\ntask\ncondition\ncontact\ncredit\negg\nhope\nice\nnetwork\nnorth\nsquare\nattempt\ndate\neffect\nlink\npost\nstar\nvoice\ncapital\nchallenge\nfriend\nself\nshot\nbrush\ncouple\ndebate\nexit\nfront\nfunction\nlack\nliving\nplant\nplastic\nspot\nsummer\ntaste\ntheme\ntrack\nwing\nbrain\nbutton\nclick\ndesire\nfoot\ngas\ninfluence\nnotice\nrain\nwall\nbase\ndamage\ndistance\nfeeling\npair\nsavings\nstaff\nsugar\ntarget\ntext\nanimal\nauthor\nbudget\ndiscount\nfile\nground\nlesson\nminute\nofficer\nphase\nreference\nregister\nsky\nstage\nstick\ntitle\ntrouble\nbowl\nbridge\ncampaign\ncharacter\nclub\nedge\nevidence\nfan\nletter\nlock\nmaximum\nnovel\noption\npack\npark\nplenty\nquarter\nskin\nsort\nweight\nbaby\nbackground\ncarry\ndish\nfactor\nfruit\nglass\njoint\nmaster\nmuscle\nred\nstrength\ntraffic\ntrip\nvegetable\nappeal\nchart\ngear\nideal\nkitchen\nland\nlog\nmother\nnet\nparty\nprinciple\nrelative\nsale\nseason\nsignal\nspirit\nstreet\ntree\nwave\nbelt\nbench\ncommission\ncopy\ndrop\nminimum\npath\nprogress\nproject\nsea\nsouth\nstatus\nstuff\nticket\ntour\nangle\nblue\nbreakfast\nconfidence\ndaughter\ndegree\ndoctor\ndot\ndream\nduty\nessay\nfather\nfee\nfinance\nhour\njuice\nlimit\nluck\nmilk\nmouth\npeace\npipe\nseat\nstable\nstorm\nsubstance\nteam\ntrick\nafternoon\nbat\nbeach\nblank\ncatch\nchain\nconsideration\ncream\ncrew\ndetail\ngold\ninterview\nkid\nmark\nmatch\nmission\npain\npleasure\nscore\nscrew\nsex\nshop\nshower\nsuit\ntone\nwindow\nagent\nband\nblock\nbone\ncalendar\ncap\ncoat\ncontest\ncorner\ncourt\ncup\ndistrict\ndoor\neast\nfinger\ngarage\nguarantee\nhole\nhook\nimplement\nlayer\nlecture\nlie\nmanner\nmeeting\nnose\nparking\npartner\nprofile\nrespect\nrice\nroutine\nschedule\nswimming\ntelephone\ntip\nwinter\nairline\nbag\nbattle\nbed\nbill\nbother\ncake\ncode\ncurve\ndesigner\ndimension\ndress\nease\nemergency\nevening\nextension\nfarm\nfight\ngap\ngrade\nholiday\nhorror\nhorse\nhost\nhusband\nloan\nmistake\nmountain\nnail\nnoise\noccasion\npackage\npatient\npause\nphrase\nproof\nrace\nrelief\nsand\nsentence\nshoulder\nsmoke\nstomach\nstring\ntourist\ntowel\nvacation\nwest\nwheel\nwine\narm\naside\nassociate\nbet\nblow\nborder\nbranch\nbreast\nbrother\nbuddy\nbunch\nchip\ncoach\ncross\ndocument\ndraft\ndust\nexpert\nfloor\ngod\ngolf\nhabit\niron\njudge\nknife\nlandscape\nleague\nmail\nmess\nnative\nopening\nparent\npattern\npin\npool\npound\nrequest\nsalary\nshame\nshelter\nshoe\nsilver\ntackle\ntank\ntrust\nassist\nbake\nbar\nbell\nbike\nblame\nboy\nbrick\nchair\ncloset\nclue\ncollar\ncomment\nconference\ndevil\ndiet\nfear\nfuel\nglove\njacket\nlunch\nmonitor\nmortgage\nnurse\npace\npanic\npeak\nplane\nreward\nrow\nsandwich\nshock\nspite\nspray\nsurprise\ntill\ntransition\nweekend\nwelcome\nyard\nalarm\nbend\nbicycle\nbite\nblind\nbottle\ncable\ncandle\nclerk\ncloud\nconcert\ncounter\nflower\ngrandfather\nharm\nknee\nlawyer\nleather\nload\nmirror\nneck\npension\nplate\npurple\nruin\nship\nskirt\nslice\nsnow\nspecialist\nstroke\nswitch\ntrash\ntune\nzone\nanger\naward\nbid\nbitter\nboot\nbug\ncamp\ncandy\ncarpet\ncat\nchampion\nchannel\nclock\ncomfort\ncow\ncrack\nengineer\nentrance\nfault\ngrass\nguy\nhell\nhighlight\nincident\nisland\njoke\njury\nleg\nlip\nmate\nmotor\nnerve\npassage\npen\npride\npriest\nprize\npromise\nresident\nresort\nring\nroof\nrope\nsail\nscheme\nscript\nsock\nstation\ntoe\ntower\ntruck\nwitness\n', 0),
('project_default_complexity', 'easy', 1),
('project_default_educators', '3', 1),
('project_default_language', 'en', 1),
('project_max_educators', '10', 1),
('project_name_minlength', '4', 1),
('task_default_afternoon_from', '14:00', 1),
('task_default_afternoon_to', '18:30', 1),
('task_default_annotations', '2', 1),
('task_default_days_duration', '3', 1),
('task_default_disabledStatus', '0', 1),
('task_default_morning_from', '09:00', 1),
('task_default_morning_to', '12:30', 1),
('task_default_students', '25', 1),
('task_max_students', '50', 1),
('task_name_minlength', '4', 1),
('task_types', 'hssh	High School Superhero\ncreender	Creender\nrc	Rocket.Chat\nusers	Users\n', 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `rc_scenarios`
--

CREATE TABLE `rc_scenarios` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `label` varchar(200) NOT NULL,
  `school` int(11) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `rc_schools`
--

CREATE TABLE `rc_schools` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `tool` set('rc','hssh','creender','users') NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `disabled` tinyint(1) NOT NULL DEFAULT 1,
  `closed` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `project` int(11) NOT NULL,
  `task` int(11) DEFAULT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `educator` tinyint(1) NOT NULL DEFAULT 0,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `creender_annotations`
--
ALTER TABLE `creender_annotations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dtc_id` (`dtc_id`),
  ADD KEY `user` (`user`);

--
-- Indici per le tabelle `creender_choices`
--
ALTER TABLE `creender_choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project` (`project_id`);

--
-- Indici per le tabelle `creender_datasets`
--
ALTER TABLE `creender_datasets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project` (`project_id`),
  ADD KEY `task` (`task_id`);

--
-- Indici per le tabelle `creender_ds_task_cluster`
--
ALTER TABLE `creender_ds_task_cluster`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un` (`row`,`task`,`cluster`),
  ADD KEY `row` (`row`),
  ADD KEY `task` (`task`),
  ADD KEY `cluster` (`cluster`);

--
-- Indici per le tabelle `creender_rows`
--
ALTER TABLE `creender_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dataset_id` (`dataset_id`);

--
-- Indici per le tabelle `hssh_annotations`
--
ALTER TABLE `hssh_annotations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `session_id` (`session_id`);

--
-- Indici per le tabelle `hssh_datasets`
--
ALTER TABLE `hssh_datasets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project` (`project_id`),
  ADD KEY `task` (`task_id`),
  ADD KEY `type` (`type`);

--
-- Indici per le tabelle `hssh_ds_task_cluster`
--
ALTER TABLE `hssh_ds_task_cluster`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un` (`row`,`task`,`cluster`),
  ADD KEY `row` (`row`),
  ADD KEY `task` (`task`),
  ADD KEY `cluster` (`cluster`);

--
-- Indici per le tabelle `hssh_rows`
--
ALTER TABLE `hssh_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dataset_id` (`dataset_id`);

--
-- Indici per le tabelle `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `rc_scenarios`
--
ALTER TABLE `rc_scenarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school` (`school`);

--
-- Indici per le tabelle `rc_schools`
--
ALTER TABLE `rc_schools`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project` (`project_id`),
  ADD KEY `tool` (`tool`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `project` (`project`),
  ADD KEY `task` (`task`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `creender_annotations`
--
ALTER TABLE `creender_annotations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `creender_choices`
--
ALTER TABLE `creender_choices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `creender_datasets`
--
ALTER TABLE `creender_datasets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `creender_ds_task_cluster`
--
ALTER TABLE `creender_ds_task_cluster`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `creender_rows`
--
ALTER TABLE `creender_rows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `hssh_annotations`
--
ALTER TABLE `hssh_annotations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `hssh_datasets`
--
ALTER TABLE `hssh_datasets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `hssh_ds_task_cluster`
--
ALTER TABLE `hssh_ds_task_cluster`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `hssh_rows`
--
ALTER TABLE `hssh_rows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `rc_scenarios`
--
ALTER TABLE `rc_scenarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `rc_schools`
--
ALTER TABLE `rc_schools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

const op$currentDate = r'$currentDate';
const opDateTypeDoc = {r'$type': 'date'};
const opTimeStampeTypeDoc = {r'$type': 'timestamp'};

const op$inc = r'$inc';
const op$min = r'$min';
const op$max = r'$max';
const op$mul = r'$mul';
const op$rename = r'$rename';
const op$set = r'$set';
const op$setOnInsert = r'$setOnInsert';
const op$unset = r'$unset';

// *************  Comparison
const op$eq = r'$eq';
const op$gt = r'$gt';
const op$gte = r'$gte';
const op$lt = r'$lt';
const op$lte = r'$lte';
const op$ne = r'$ne';
const op$in = r'$in';
const op$nin = r'$nin';

// ************* Geo Spatial
const op$within = r'$within';
const op$box = r'$box';
const op$near = r'$near';
const op$maxDistance = r'$maxDistance';
const op$minDistance = r'$minDistance';
const op$geoWithin = r'$geoWithin';
const op$nearSphere = r'$nearSphere';
const op$geoIntersects = r'$geoIntersects';

// ************* Element
const op$exists = r'$exists';
const op$type = r'$type';

// ************* Evaluation
const op$expr = r'$expr';
const op$mod = r'$mod';
const op$regex = r'$regex';
const op$options = r'$options';
const op$where = r'$where';
const op$jsonSchema = r'$jsonSchema';
const op$text = r'$text';
const op$search = r'$search';
const op$language = r'$language';
const op$caseSensitive = r'$caseSensitive';
const op$diacriticSensitive = r'$diacriticSensitive';

// ************* Geometry
const op$center = r'$center';
const op$centerSphere = r'$centerSphere';
const op$geometry = r'$geometry';
//const op$box = r'$box';

// ************* Logical
const op$and = r'$and';
const op$not = r'$not';
const op$or = r'$or';
const op$nor = r'$nor';

// ************* array Query
const op$all = r'$all';
const op$size = r'$size';

// ************* miscellaneous
const op$comment = r'$comment';

const op$addToSet = r'$addToSet';
const op$pop = r'$pop';
const op$pull = r'$pull';
const op$push = r'$push';
const op$pullAll = r'$pullAll';

const op$each = r'$each';
const op$position = r'$position';
const op$slice = r'$slice';
const op$sort = r'$sort';
const op$meta = r'$meta';
const op$elemMatch = r'$elemMatch';

const op$Bit = r'$bit';
const opBitAnd = 'and';
const opBitOr = 'or';
const opBitXor = 'xor';

// *********************** AGGREGATION **********************

// **** Array Object
const op$arrayToObject = r'$arrayToObject';
const op$arrayElemAt = r'$arrayElemAt';
const op$concatArrays = r'$concatArrays';
const op$filter = r'$filter';
const op$indexOfArray = r'$indexOfArray';
const op$isArray = r'$isArray';
const op$map = r'$map';
const op$objectToArray = r'$objectToArray';
const op$range = r'$range';
const op$reduce = r'$reduce';
const op$reverseArray = r'$reverseArray';
//const op$slice = r'$slice';
const op$zip = r'$zip';

// **** Arithmentic
const op$abs = r'$abs';
const op$add = r'$add';
const op$ceil = r'$ceil';
const op$divide = r'$divide';
const op$exp = r'$exp';
const op$floor = r'$floor';
const op$ln = r'$ln';
const op$log = r'$log';
const op$log10 = r'$log10';
//const op$mod = r'$mod';
const op$multiply = r'$multiply';
const op$pow = r'$pow';
const op$round = r'$round';
const op$sqrt = r'$sqrt';
const op$subtract = r'$subtract';
const op$trunc = r'$trunc';

// **** Accumulator
//const op$addToSet = r'$addToSet';
const op$avg = r'$avg';
const op$first = r'$first';
const op$last = r'$last';
//const op$max = r'$max';
const op$mergeObjects = r'$mergeObjects';
//const op$min = r'$min';
//const op$push = r'$push';
const op$stdDevPop = r'$stdDevPop';
const op$stdDevSamp = r'$stdDevSamp';
const op$sum = r'$sum';

// **** Comparison
const op$cmp = r'$cmp';
const op$cond = r'$cond';
const op$dateFromParts = r'$dateFromParts';
//const op$eq = r'$eq';
//const op$gt = r'$gt';
//const op$gte = r'$gte';
const op$ifNull = r'$ifNull';
//const op$lt = r'$lt';
//const op$lte = r'$lte';
//const op$ne = r'$ne';
const op$switch = r'$switch';
const pmCase = 'case';
const pmThen = 'then';

// **** Date Time
//const op$dateFromParts = r'$dateFromParts';
const op$dateFromString = r'$dateFromString';
const op$dateToParts = r'$dateToParts';
const op$dayOfMonth = r'$dayOfMonth';
const op$dayOfWeek = r'$dayOfWeek';
const op$dayOfYear = r'$dayOfYear';
const op$hour = r'$hour';
const op$isoDayOfWeek = r'$isoDayOfWeek';
const op$isoWeek = r'$isoWeek';
const op$isoWeekYear = r'$isoWeekYear';
const op$millisecond = r'$millisecond';
const op$minute = r'$minute';
const op$month = r'$month';
const op$second = r'$second';
const op$toDate = r'$toDate';
const op$week = r'$week';
const op$year = r'$year';

// **** Stages
const st$addFields = r'$addFields';
const st$bucket = r'$bucket';
const st$bucketAuto = r'$bucketAuto';
const st$collStats = r'$collStats';
const st$count = r'$count';
const st$densify = r'$densify';
const st$facet = r'$facet';
const st$geoNear = r'$geoNear';
const st$graphLookup = r'$graphLookup';
const st$limit = r'$limit';
const st$lookup = r'$lookup';
const st$match = r'$match';
const st$group = r'$group';
const st$project = r'$project';
const st$replaceRoot = r'$replaceRoot';
const st$replaceWith = r'$replaceWith';
const st$set = r'$set';
const st$setWindowFields = r'$setWindowFields';
const st$skip = r'$skip';
const st$sort = r'$sort';
const st$sortByCount = r'$sortByCount';
const st$unionWith = r'$unionWith';
const st$unset = r'$unset';
const st$unwind = r'$unwind';

// **** Db Stages
const st$changeStream = r'$changeStream';
const st$changeStreamSplitLargeEvent = r'$changeStreamSplitLargeEvent';
const st$currentOp = r'$currentOp';
const st$documents = r'$documents';
const st$listLocalSessions = r'$listLocalSessions';

// **** String
const op$concat = r'$concat';
const op$indexOfBytes = r'$indexOfBytes';
const op$indexOfCP = r'$indexOfCP';
const op$ltrim = r'$ltrim';
const op$regexFind = r'$regexFind';
const op$regexFindAll = r'$regexFindAll';
const op$regexMatch = r'$regexMatch';
const op$rtrim = r'$rtrim';
const op$split = r'$split';
const op$strLenBytes = r'$strLenBytes';
const op$strLenCP = r'$strLenCP';
const op$strcasecmp = r'$strcasecmp';
const op$substrBytes = r'$substrBytes';
const op$substrCP = r'$substrCP';
const op$toLower = r'$toLower';
const op$toString = r'$toString';
const op$trim = r'$trim';
const op$toUpper = r'$toUpper';

// **** Type Expression
const op$convert = r'$convert';
const op$toBool = r'$toBool';
const op$toDecimal = r'$toDecimal';
const op$toDouble = r'$toDouble';
const op$toInt = r'$toInt';
const op$toLong = r'$toLong';
const op$toObjectId = r'$toObjectId';
//const op$type = r'$type';

// **** Type Expression
const op$let = r'$let';

# Copyright (c) 2020 The GodotXterm authors.
# Copyright (c) 2019 The xterm.js authors. All rights reserved.
# License MIT
extends 'res://addons/gut/test.gd'

const Decoder = preload("res://addons/godot_xterm/input/text_decoder.gd")

# Note: There might be some invisible characters (such as emoji) depending
# on your editor and font settings.
const TEST_STRINGS = [
	"Лорем ипсум долор сит амет, ех сеа аццусам диссентиет. Ан еос стет еирмод витуперата. Иус дицерет урбанитас ет. Ан при алтера долорес сплендиде, цу яуо интегре денияуе, игнота волуптариа инструцтиор цу вим.",
	"ლორემ იფსუმ დოლორ სით ამეთ, ფაცერ მუციუს ცონსეთეთურ ყუო იდ, ფერ ვივენდუმ ყუაერენდუმ ეა, ესთ ამეთ მოვეთ სუავითათე ცუ. ვითაე სენსიბუს ან ვიხ. ეხერცი დეთერრუისსეთ უთ ყუი. ვოცენთ დებითის ადიფისცი ეთ ფერ. ნეც ან ფეუგაით ფორენსიბუს ინთერესსეთ. იდ დიცო რიდენს იუს. დისსენთიეთ ცონსეყუუნთურ სედ ნე, ნოვუმ მუნერე ეუმ ათ, ნე ეუმ ნიჰილ ირაცუნდია ურბანითას.",
	"अधिकांश अमितकुमार प्रोत्साहित मुख्य जाने प्रसारन विश्लेषण विश्व दारी अनुवादक अधिकांश नवंबर विषय गटकउसि गोपनीयता विकास जनित परस्पर गटकउसि अन्तरराष्ट्रीयकरन होसके मानव पुर्णता कम्प्युटर यन्त्रालय प्रति साधन",
	"覧六子当聞社計文護行情投身斗来。増落世的況上席備界先関権能万。本物挙歯乳全事携供板栃果以。頭月患端撤競見界記引去法条公泊候。決海備駆取品目芸方用朝示上用報。講申務紙約週堂出応理田流団幸稿。起保帯吉対阜庭支肯豪彰属本躍。量抑熊事府募動極都掲仮読岸。自続工就断庫指北速配鳴約事新住米信中験。婚浜袋著金市生交保他取情距。",
	"八メル務問へふらく博辞説いわょ読全タヨムケ東校どっ知壁テケ禁去フミ人過を装5階がねぜ法逆はじ端40落ミ予竹マヘナセ任1悪た。省ぜりせ製暇ょへそけ風井イ劣手はぼまず郵富法く作断タオイ取座ゅょが出作ホシ月給26島ツチ皇面ユトクイ暮犯リワナヤ断連こうでつ蔭柔薄とレにの。演めけふぱ損田転10得観びトげぎ王物鉄夜がまけ理惜くち牡提づ車惑参ヘカユモ長臓超漫ぼドかわ。",
	"모든 국민은 행위시의 법률에 의하여 범죄를 구성하지 아니하는 행위로 소추되지 아니하며. 전직대통령의 신분과 예우에 관하여는 법률로 정한다, 국회는 헌법 또는 법률에 특별한 규정이 없는 한 재적의원 과반수의 출석과 출석의원 과반수의 찬성으로 의결한다. 군인·군무원·경찰공무원 기타 법률이 정하는 자가 전투·훈련등 직무집행과 관련하여 받은 손해에 대하여는 법률이 정하는 보상외에 국가 또는 공공단체에 공무원의 직무상 불법행위로 인한 배상은 청구할 수 없다.",
	"كان فشكّل الشرقي مع, واحدة للمجهود تزامناً بعض بل. وتم جنوب للصين غينيا لم, ان وبدون وكسبت الأمور ذلك, أسر الخاسر الانجليزية هو. نفس لغزو مواقعها هو. الجو علاقة الصعداء انه أي, كما مع بمباركة للإتحاد الوزراء. ترتيب الأولى أن حدى, الشتوية باستحداث مدن بل, كان قد أوسع عملية. الأوضاع بالمطالبة كل قام, دون إذ شمال الربيع،. هُزم الخاصّة ٣٠ أما, مايو الصينية مع قبل.",
	"או סדר החול מיזמי קרימינולוגיה. קהילה בגרסה לויקיפדים אל היא, של צעד ציור ואלקטרוניקה. מדע מה ברית המזנון ארכיאולוגיה, אל טבלאות מבוקשים כלל. מאמרשיחהצפה העריכהגירסאות שכל אל, כתב עיצוב מושגי של. קבלו קלאסיים ב מתן. נבחרים אווירונאוטיקה אם מלא, לוח למנוע ארכיאולוגיה מה. ארץ לערוך בקרבת מונחונים או, עזרה רקטות לויקיפדים אחר גם.",
	"Лорем ლორემ अधिकांश 覧六子 八メル 모든 בקרבת 💮 😂 äggg 123€ 𝄞.",
]

func test_utf32_to_utf8():
	# 1 byte utf8 character
	assert_eq(
		Decoder.utf32_to_utf8(0x00000061),
		PoolByteArray([0x61])
	)
	# 2 byte utf8 character
	assert_eq(
		Decoder.utf32_to_utf8(0x00000761),
		PoolByteArray([0xdd, 0xa1])
	)
	# 3 byte utf8 character
	assert_eq(
		Decoder.utf32_to_utf8(0x00002621),
		PoolByteArray([0xe2, 0x98, 0xa1])
	)
	# 4 byte utf8 character
	assert_eq(
		Decoder.utf32_to_utf8(0x00010144),
		PoolByteArray([0xf0, 0x90, 0x85, 0x84])
	)
	assert_eq(
		Decoder.utf32_to_utf8(0x0001f427) as Array,
		PoolByteArray([0xf0, 0x9f, 0x90, 0xa7]) as Array
	)

func test_string_from_codepoint():
	assert_eq(Decoder.string_from_codepoint(49), '1')
	assert_eq(Decoder.string_from_codepoint(0x1f427), '🐧')
	assert_eq(Decoder.string_from_codepoint(0x1d11e), '𝄞')

func test_utf32_to_string():
	assert_eq(
		Decoder.utf32_to_string([49, 50, 51, 0x1d11e, 49, 50, 51]),
		'123𝄞123'
	)

class TestUtf8ToUtf32Decoder:
	extends 'res://addons/gut/test.gd'
	
	var decoder = Decoder.Utf8ToUtf32.new()
	var target = []
	
	func before_each():
		decoder.clear()
		target.clear()
		target.resize(5)
	
	func skip_test_full_code_point_0_to_65535(): # 1/2/3 byte sequences
		for i in range(65536):
			# skip surrogate pairs
			if i >= 0xD800 and i <= 0xDFFF:
				continue
			var utf8_data = Decoder.utf32_to_utf8(i)
			var length = decoder.decode(utf8_data, target)
			assert_eq(length, 1)
			assert_eq(
				Decoder.string_from_codepoint(target[0]),
				utf8_data.get_string_from_utf8()
			)
			decoder.clear()
	
	func skip_test_full_codepoint_65536_to_0x10FFFF(): # 4 byte sequences
		for i in range(65536, 0x10FFFF):
			var utf8_data = Decoder.utf32_to_utf8(i)
			var length = decoder.decode(utf8_data, target)
			assert_eq(length, 1)
			assert_eq(target[0], i)
	
	func test_test_strings():
		target.resize(500)
		for string in TEST_STRINGS:
			var utf8_data = string.to_utf8()
			var length = decoder.decode(utf8_data, target)
			assert_eq(Decoder.utf32_to_string(target, 0, length), string)
			decoder.clear()

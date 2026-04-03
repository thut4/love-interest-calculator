import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/cosmic_background.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/saju_profile.dart';
import '../providers/saju_providers.dart';

const List<String> _elementOrder = ['Wood', 'Fire', 'Earth', 'Metal', 'Water'];

const Map<String, String> _elementKorean = {
  'Wood': '목(木)',
  'Fire': '화(火)',
  'Earth': '토(土)',
  'Metal': '금(金)',
  'Water': '수(水)',
};

const Map<String, Color> _elementColors = {
  'Wood': Color(0xFF7BD389),
  'Fire': Color(0xFFFF8FAB),
  'Earth': Color(0xFFFFD166),
  'Metal': Color(0xFFB8C0FF),
  'Water': Color(0xFF70D6FF),
};

const String _langEnglish = 'en';
const String _langMyanmar = 'my';

const Map<String, String> _elementMyanmar = {
  'Wood': 'သစ်',
  'Fire': 'မီး',
  'Earth': 'မြေ',
  'Metal': 'သတ္တု',
  'Water': 'ရေ',
};

const Map<String, String> _animalMyanmar = {
  'Rat': 'ကြွက်',
  'Ox': 'နွား',
  'Tiger': 'ကျား',
  'Rabbit': 'ယုန်',
  'Dragon': 'နဂါး',
  'Snake': 'မြွေ',
  'Horse': 'မြင်း',
  'Goat': 'ဆိတ်',
  'Monkey': 'မျောက်',
  'Rooster': 'ကြက်',
  'Dog': 'ခွေး',
  'Pig': 'ဝက်',
};

const Map<String, String> _pillarLabelMyanmar = {
  'Year Pillar': 'Year Pillar (နှစ်တိုင်)',
  'Month Pillar': 'Month Pillar (လတိုင်)',
  'Day Pillar': 'Day Pillar (နေ့တိုင်)',
  'Hour Pillar': 'Hour Pillar (နာရီတိုင်)',
};

const Map<String, String> _destinyMyanmar = {
  'Wood':
      'သင့်ကံကြမ္မာစွမ်းအင်မှာ တိုးတက်မှု၊ လေ့လာမှုနှင့် ရည်မှန်းချက်တစ်ခုဆီသို့ ရွေ့လျားခြင်းမှ အားဖြစ်စေပါတယ်။',
  'Fire':
      'သင့်ကံကြမ္မာစွမ်းအင်မှာ ဖော်ထုတ်ပြသမှု၊ နွေးထွေးမှုနှင့် လှုံ့ဆော်မှုမှ အားဖြစ်စေပါတယ်။',
  'Earth':
      'သင့်ကံကြမ္မာစွမ်းအင်မှာ တည်ငြိမ်မှု၊ ယုံကြည်မှုတည်ဆောက်ခြင်းနှင့် အစဉ်တကျလုပ်ဆောင်ခြင်းမှ အားဖြစ်စေပါတယ်။',
  'Metal':
      'သင့်ကံကြမ္မာစွမ်းအင်မှာ စည်းကမ်း၊ စံနှုန်းနှင့် တိကျမှုမှ အားဖြစ်စေပါတယ်။',
  'Water':
      'သင့်ကံကြမ္မာစွမ်းအင်မှာ ခံစားသိမြင်နိုင်မှု၊ လိုက်လျောပြောင်းလဲနိုင်မှုနှင့် အတွင်းသိမှူးမှ အားဖြစ်စေပါတယ်။',
};

const Map<String, String> _advicePrimaryMyanmar = {
  'Wood':
      'တစ်ပတ်တစ်ကြိမ် လေ့လာမှု၊ မန်တော်ပေးခြင်း၊ စွမ်းရည်တိုးတက်ရေး စီစဉ်မှုများထည့်ပါ။',
  'Fire':
      'ရေးသားခြင်း၊ အသံထုတ်ခြင်း၊ အနုပညာစတဲ့ ဖန်တီးမှုနည်းလမ်းဖြင့် စွမ်းအင်ကို မျှတစေပါ။',
  'Earth': 'အိပ်ချိန်၊ အစားအသောက်နှင့် လှုပ်ရှားမှုကို ပုံမှန်အစီအစဉ်ထားပါ။',
  'Metal':
      'အချိန်၊ ငွေကြေးနှင့် ဆက်သွယ်ရေးအတွက် နယ်နိမိတ်များကို သေချာသတ်မှတ်ပါ။',
  'Water': 'တိတ်ဆိတ်စဉ်းစားချိန်များ ထားရှိပြီး အတွင်းသိကို ပြန်တိုးတက်စေပါ။',
};

const Map<String, String> _statusMyanmar = {
  'Strong': 'အားကောင်း',
  'Low': 'အားနည်း',
  'Balanced': 'ညီမျှ',
};

const List<String> _notesMyanmar = [
  'Month pillar ကို နေရောင်ပြောင်းလဲခွင် (입춘 기준) ခန့်မှန်းပုံစံဖြင့် တွက်ထားပါသည်။',
  'မွေးမြို့/မွေးနိုင်ငံကို timezone ခန့်မှန်းရန် အသုံးပြုထားပါသည်။',
];

const Map<String, _PillarTranslation> _pillarTranslationsMyanmar = {
  'Year Pillar': _PillarTranslation(
    title: 'အပြင်ဘက်ကံနှင့် အစောပိုင်းပတ်ဝန်းကျင်',
    summary:
        'Year Pillar သည် မွေးရာပါလက်ခံရသည့်စွမ်းအင်၊ လူမှုရေးပုံရိပ်နှင့် အစောပိုင်းဘဝအခြေခံကို ဖော်ပြပေးပါတယ်။',
    strengths: [
      'ဘယ်လိုအသိုင်းအဝိုင်းမှာ ကံအလျင်မြန်ဆုံးဖွင့်မလဲဆိုတာ ပြသပေးပါတယ်။',
      'အခြားသူတွေက သင့်စွမ်းအင်ကို ပထမဦးဆုံးဘယ်လိုဖတ်မလဲဆိုတာ ဖော်ပြပေးပါတယ်။',
    ],
    growthTip:
        'တန်ဖိုးတူအသိုင်းအဝိုင်းကို ရွေးချယ်ပြီး Year Pillar ကို အားဖြည့်ပါ။',
  ),
  'Month Pillar': _PillarTranslation(
    title: 'အလုပ်အကိုင်လှိုင်းနှင့် ထုတ်လုပ်နိုင်စွမ်း',
    summary:
        'Month Pillar သည် အလုပ်လုပ်ပုံ၊ စည်းကမ်းနှင့် ကြီးထွားရာကာလအတွင်း စွမ်းအင်အခြေအနေကို ဖော်ပြပေးပါတယ်။',
    strengths: [
      'ဘယ်နေရာမှာ ကြိုးစားမှုက ဆက်လက်တိုးပွားသွားမလဲဆိုတာ ပြသပေးပါတယ်။',
      'ပင်ပန်းလွန်းမှုမဖြစ်ဘဲ တည်ငြိမ်စွာတိုးတက်ဖို့ လှိုင်းစီးနည်းပေးပါတယ်။',
    ],
    growthTip:
        'တစ်ပတ်စာလုပ်ဆောင်မှုကို ပုံမှန်ဖွဲ့စည်းပါ။ ပုံမှန်လှိုင်းက ရေရှည်ကံကို တည်ငြိမ်စေပါတယ်။',
  ),
  'Day Pillar': _PillarTranslation(
    title: 'အဓိကကိုယ်ပိုင်စရိုက်နှင့် ဆက်ဆံရေးပုံစံ',
    summary:
        'Day Pillar သည် ဇာတာ၏နှလုံးချက်ဖြစ်ပြီး ကိုယ်ပိုင်အကျင့်၊ ခံစားချက်လိုအပ်ချက်နှင့် တစ်ဦးချင်းဆက်ဆံရေးကို ဖော်ပြပါတယ်။',
    strengths: [
      'သင်၏ တကယ့်ခံစားချက်ပုံစံနှင့် ယုံကြည်မှုပြောဆိုပုံကို ပြသပေးပါတယ်။',
      'အနီးကပ်ဆက်ဆံရေးမှာ တိုးတက်ဖို့လိုအပ်သည့် အရည်အသွေးများကို ဖော်ထုတ်ပေးပါတယ်။',
    ],
    growthTip:
        'ခံစားချက်လိုအပ်ချက်ကို တိုက်ရိုက်ပြောဆိုပါ။ ရှင်းလင်းမှုက ဆက်ဆံရေးအချိန်ကောင်းကို ဖန်တီးပေးပါတယ်။',
  ),
  'Hour Pillar': _PillarTranslation(
    title: 'အနာဂတ်မျှော်မှန်းချက်နှင့် အတွင်းဖန်တီးနိုင်စွမ်း',
    summary:
        'Hour Pillar သည် ရေရှည်အိပ်မက်၊ အတွင်းစိတ်လှုံ့ဆော်မှုနှင့် နောက်ပိုင်းဘဝအထိ ပျိုးထောင်မည့် သက်ရောက်မှုစွမ်းအင်ကို ဖော်ပြပါတယ်။',
    strengths: [
      'နောက်ပိုင်းဘဝမှာ ပိုသန်မာလာမယ့် လျှို့ဝှက်အားသာချက်တွေကို ပြသပေးပါတယ်။',
      'အတွင်းသိနှင့် အနာဂတ်စီမံကိန်းကို ဘယ်လိုပေါင်းစပ်ရမလဲဆိုတာ ညွှန်ပြပေးပါတယ်။',
    ],
    growthTip:
        'အာရုံစိုက်နက်နဲချိန်ကို ကာကွယ်ထားပါ။ တိတ်တိတ်ဆိတ်ဆိတ် ဆန်းစစ်ခြင်းက အကျိုးရှိဆုံးရလဒ်တွေကို ဖွင့်ပေးပါတယ်။',
  ),
};

const Map<String, _ElementTranslation> _elementTranslationsMyanmar = {
  'Wood': _ElementTranslation(
    title: 'တိုးတက်မှုမောင်းနှင်အား',
    essence: 'ချဲ့ထွင်မှု၊ မဟာဗျူဟာ၊ ဖန်တီးနိုင်စွမ်းနှင့် ရေရှည်ဦးတည်ချက်။',
    strengths:
        'သင်သည် လေ့လာမှုနှင့် အမြင်ရှည်မားမှုကြောင့် တိုးတက်မှုအလျင်ကောင်းကို ဖန်တီးနိုင်သည်။',
    lowState: 'အားနည်းသည့်အခါ ဦးတည်ချက်မရှင်းကာ ဆုံးဖြတ်ချက်နှေးကွေးနိုင်သည်။',
    habitFocus:
        'သုံးလတစ်ကြိမ် အဓိကတိုးတက်ရေးရည်မှန်းချက်တစ်ခု သတ်မှတ်ပြီး အပတ်စဉ်စစ်ဆေးပါ။',
    relationshipTip:
        'အနာဂတ်အစီအစဉ်ကို မျှဝေပြောဆိုခြင်းဖြင့် ဆက်ဆံရေးပူးပေါင်းမှုကို တိုးတက်စေပါ။',
    careerTip:
        'စီမံကိန်းရေးဆွဲမှု၊ coaching၊ ထုတ်ကုန်ဖန်တီးမှုနှင့် innovation အလုပ်များအတွက် သင့်တော်သည်။',
    balanceAction:
        'သဘာဝလမ်းလျှောက်ခြင်းနှင့် journal ရေးခြင်းဖြင့် အမြင်ကို ပြန်လည်သစ်စေပါ။',
  ),
  'Fire': _ElementTranslation(
    title: 'ဖော်ထုတ်ပြသမှုမောင်းနှင်အား',
    essence: 'ထင်ရှားမှု၊ ဆွဲဆောင်မှု၊ စိတ်အားထက်သန်မှုနှင့် ဖော်ပြနိုင်စွမ်း။',
    strengths:
        'သင်သည် နွေးထွေးမှုနှင့် စိတ်လှုပ်ရှားဖွယ်ဖော်ပြမှုတို့ဖြင့် အခြားသူများကို လှုံ့ဆော်နိုင်သည်။',
    lowState:
        'အားနည်းသည့်အခါ စိတ်အားကျပြီး ကိုယ်ပိုင်ဖော်ပြမှု လျော့ကျနိုင်သည်။',
    habitFocus: 'နေ့စဉ် ဖန်တီးမှုထုတ်လွှတ်ချိန် (ရေး၊ ပြော၊ ဖန်တီး) ထားပါ။',
    relationshipTip:
        'အသေးစားအောင်မြင်မှုများကို အတူကျင်းပပြီး ချစ်ကြည်မှုကို တိုးစေပါ။',
    careerTip:
        'စကားပြော/ဖျော်ဖြေ/ခေါင်းဆောင်မှု/content/storytelling လုပ်ငန်းများတွင် Fire အားကောင်းသည်။',
    balanceAction: 'အိပ်ရေးနှင့် အနားယူချိန်ကို ကာကွယ်ပြီး burnout မဖြစ်စေပါ။',
  ),
  'Earth': _ElementTranslation(
    title: 'တည်ငြိမ်မှုမောင်းနှင်အား',
    essence:
        'မြေပြင်တည်ငြိမ်မှု၊ ယုံကြည်မှု၊ တာဝန်ယူမှုနှင့် လက်တွေ့ကူညီနိုင်စွမ်း။',
    strengths:
        'သင်သည် တည်ငြိမ်မှုနှင့် ယုံကြည်လောက်မှုဖြင့် လုံခြုံမှုဖန်တီးနိုင်သည်။',
    lowState: 'အားနည်းသည့်အခါ routine ပျက်ကွက်ပြီး ဖိအားများ ပျံ့နှံ့နိုင်သည်။',
    habitFocus: 'အိပ်/နိုးအချိန်နှင့် အစားအသောက်အချိန်ကို ပုံမှန်တည်ဆောက်ပါ။',
    relationshipTip:
        'ကတိကဝတ်ကို ရှင်းလင်းစွာ သတ်မှတ်ပြီး တည်ငြိမ်ယုံကြည်မှုကို တိုးစေပါ။',
    careerTip:
        'operations၊ management၊ counseling နှင့် ရေရှည်စီမံကိန်းများအတွက် သင့်တော်သည်။',
    balanceAction:
        'အလုပ်များလွန်းမှုကို လျှော့ပြီး အခြေခံ routine တစ်ခုသို့ ပြန်ဆုတ်ပါ။',
  ),
  'Metal': _ElementTranslation(
    title: 'တိကျမှုမောင်းနှင်အား',
    essence: 'ဖွဲ့စည်းပုံ၊ စံနှုန်း၊ နယ်နိမိတ်နှင့် တိကျသုံးသပ်နိုင်စွမ်း။',
    strengths: 'သင်သည် အရေးကြီးချက်ကို စိစစ်ရွေးချယ်ရာတွင် ထူးချွန်သည်။',
    lowState:
        'အားနည်းသည့်အခါ နယ်နိမိတ်မရှင်းကာ ဆုံးဖြတ်ချက်များ ပြန့်ကျဲနိုင်သည်။',
    habitFocus:
        'အပတ်စဉ် calendar/inbox/commitment များကို စနစ်တကျ ရှင်းလင်းပါ။',
    relationshipTip:
        'ဆက်ဆံရေးအစောပိုင်းကတည်းက နယ်နိမိတ်ကို ယဉ်ကျေးစွာ သတ်မှတ်ပါ။',
    careerTip:
        'analysis၊ finance၊ strategy၊ compliance၊ systems design လုပ်ငန်းများတွင် Metal သင့်တော်သည်။',
    balanceAction:
        'ဆုံးဖြတ်ချက်စံနှုန်းတိကျစွာ သတ်မှတ်ပြီး overcommit မလုပ်ပါနှင့်။',
  ),
  'Water': _ElementTranslation(
    title: 'ဉာဏ်အမြင်မောင်းနှင်အား',
    essence:
        'အတွင်းသိ၊ လိုက်လျောပြောင်းလဲနိုင်မှု၊ နက်နဲမှုနှင့် ဆင်ခြင်နိုင်စွမ်း။',
    strengths:
        'သင်သည် နူးညံ့သော pattern များကို မြန်မြန်ဖမ်းယူနိုင်ပြီး ပြောင်းလဲမှုကို အလွယ်တကူ တုံ့ပြန်နိုင်သည်။',
    lowState:
        'အားနည်းသည့်အခါ စိတ်ရှုပ်ထွေးမှုနှင့် ဆုံးဖြတ်ချက်မခိုင်မာမှု ဖြစ်နိုင်သည်။',
    habitFocus:
        'တိတ်ဆိတ်စဉ်းစားချိန် (meditation/prayer/journaling) ကို ပုံမှန်ထားပါ။',
    relationshipTip:
        'ခံစားချက်များကို တိတ်သိမ်းမထားဘဲ သင့်တင့်အချိန်မှာ မျှဝေပါ။',
    careerTip:
        'research၊ design၊ healing၊ strategy နှင့် adaptive leadership လုပ်ငန်းများတွင် Water သင့်တော်သည်။',
    balanceAction:
        'စဉ်းစားချိန်ကို နေ့စဉ် concrete action တစ်ခုနှင့် တွဲဖက်ပါ။',
  ),
};

const Map<String, String> _uiEn = {
  'languageLabel': 'Result Language',
  'englishTab': 'English',
  'myanmarTab': 'Myanmar',
  'fourPillarsTitle': 'Four Pillars (사주팔자)',
  'fiveElementsTitle': 'Five Elements Balance (오행)',
  'destinyTitle': 'Destiny Energy Interpretation',
  'adviceTitle': 'Personalized Saju Advice',
  'deepDiveTitle': 'English Deep Dive (Detailed)',
  'deepOverview': 'Pillar-by-pillar and element-by-element reading in English.',
  'pillarInsightTitle': 'Pillar-by-Pillar Insight',
  'elementInsightTitle': 'Element-by-Element Reading',
  'dominant': 'Dominant',
  'balanceFocus': 'Balance Focus',
  'growthFocus': 'Growth focus',
  'score': 'Score',
  'summary': 'Summary',
  'strength': 'Strength',
  'whenLow': 'When low',
  'habits': 'Habits',
  'relationship': 'Relationship',
  'career': 'Career',
  'balanceAction': 'Balance action',
};

const Map<String, String> _uiMy = {
  'languageLabel': 'Result ဘာသာစကား',
  'englishTab': 'English',
  'myanmarTab': 'မြန်မာ',
  'fourPillarsTitle': 'တိုင်လေးတိုင် (사주팔자)',
  'fiveElementsTitle': 'ဓာတ်ငါးပါးညီမျှမှု (오행)',
  'destinyTitle': 'ကံကြမ္မာစွမ်းအင် အဓိပ္ပါယ်ဖော်ခြင်း',
  'adviceTitle': 'ကိုယ်ပိုင် Saju အကြံပြုချက်',
  'deepDiveTitle': 'အတိအကျ မြန်မာဘာသာ Deep Dive',
  'deepOverview': 'တိုင်တိုင်း/ဓာတ်တိုင်း အသေးစိတ်ဖတ်ရှုချက် (မြန်မာ)',
  'pillarInsightTitle': 'တိုင်တစ်တိုင်ချင်း ဖတ်ရှုချက်',
  'elementInsightTitle': 'ဓာတ်တစ်ခုချင်း ဖတ်ရှုချက်',
  'dominant': 'အဓိကဓာတ်',
  'balanceFocus': 'ညီမျှစေရန်ဓာတ်',
  'growthFocus': 'တိုးတက်ရေးအာရုံစိုက်ရန်',
  'score': 'ရမှတ်',
  'summary': 'အကျဉ်းချုပ်',
  'strength': 'အားသာချက်',
  'whenLow': 'အားနည်းသည့်အခါ',
  'habits': 'အလေ့အထ',
  'relationship': 'ဆက်ဆံရေး',
  'career': 'အလုပ်အကိုင်',
  'balanceAction': 'ညီမျှရေးလုပ်ဆောင်ချက်',
};

Map<String, String> _ui(String language) =>
    language == _langMyanmar ? _uiMy : _uiEn;

bool _isMyanmar(String language) => language == _langMyanmar;

String _elementName(String element, String language) {
  if (!_isMyanmar(language)) return element;
  return _elementMyanmar[element] ?? element;
}

String _animalName(String animal, String language) {
  if (!_isMyanmar(language)) return animal;
  return _animalMyanmar[animal] ?? animal;
}

String _pillarLabel(String label, String language) {
  if (!_isMyanmar(language)) return label;
  return _pillarLabelMyanmar[label] ?? label;
}

String _localizedEnergySummary(SajuProfile profile, String language) {
  if (!_isMyanmar(language)) return profile.energySummary;

  final dominant = profile.dominantElement;
  final dominantKo = _elementKorean[dominant] ?? dominant;
  final weak = profile.weakElements
      .map((e) => _elementName(e, language))
      .join(', ');
  return '$dominantKo (${_elementName(dominant, language)}) စွမ်းအင်က ဇာတာထဲမှာ အားအကောင်းဆုံးဖြစ်ပါတယ်။ ညီမျှစေရန် $weak ကို အဓိကထားပါ။';
}

String _localizedOverview(SajuProfile profile, String language) {
  if (!_isMyanmar(language)) return profile.englishOverview;

  final dominant = _elementName(profile.dominantElement, language);
  final weak = profile.weakElements
      .map((e) => _elementName(e, language))
      .join(', ');
  return 'သင်၏ဇာတာတွင် $dominant စွမ်းအင်က ဦးဆောင်နေပါတယ်။ ညီမျှမှုအတွက် $weak ဓာတ်ကို နေ့စဉ်အလေ့အထများဖြင့် ထည့်သွင်းအားဖြည့်ရန် လိုအပ်ပါတယ်။';
}

String _localizedDestiny(SajuProfile profile, String language) {
  if (!_isMyanmar(language)) return profile.destinyInterpretation;
  return _destinyMyanmar[profile.dominantElement] ??
      profile.destinyInterpretation;
}

List<String> _localizedAdvice(SajuProfile profile, String language) {
  if (!_isMyanmar(language)) return profile.personalizedAdvice;

  final dominant = profile.dominantElement;
  final dominantKo = _elementKorean[dominant] ?? dominant;
  final list = <String>[
    '$dominantKo (${_elementName(dominant, language)}) စွမ်းအင်က အားအကောင်းဆုံးဖြစ်နေပါတယ်။ သဘာဝလက်ဆောင်တွေကို ရည်ရွယ်ချက်ရှိစွာ အသုံးချပါ။',
    _advicePrimaryMyanmar[dominant] ?? '',
  ];

  for (final weak in profile.weakElements) {
    final weakKo = _elementKorean[weak] ?? weak;
    list.add(
      '$weakKo (${_elementName(weak, language)}) ဓာတ်ကို ညီမျှစေရန် - ${_advicePrimaryMyanmar[weak] ?? ''}',
    );
  }

  list.add(
    'Saju အချိန်လှိုင်းနှင့်လိုက်ဖက်စေရန် လစဉ် ပြန်လည်သုံးသပ်ပြီး ရွေ့လျားစွာညှိနှိုင်းပါ။',
  );
  return list.where((item) => item.trim().isNotEmpty).toList();
}

List<String> _localizedNotes(SajuProfile profile, String language) {
  if (!_isMyanmar(language)) return profile.notes;
  return _notesMyanmar;
}

_LocalizedPillarInsight _localizedPillarInsight(
  SajuPillarInsight insight,
  String language,
) {
  if (!_isMyanmar(language)) {
    return _LocalizedPillarInsight(
      label: insight.label,
      title: insight.title,
      summary: insight.summary,
      strengths: insight.strengths,
      growthTip: insight.growthTip,
      blend: insight.englishBlend,
    );
  }

  final base = _pillarTranslationsMyanmar[insight.label];
  final blendParts = insight.englishBlend.split(' stem + ');
  final stem = blendParts.isNotEmpty ? blendParts.first : '';
  final right = blendParts.length > 1 ? blendParts[1] : '';
  final branch = right.split(' branch').first;
  final animal = right.contains('(')
      ? right.split('(')[1].replaceAll(')', '')
      : '';

  return _LocalizedPillarInsight(
    label: _pillarLabel(insight.label, language),
    title: base?.title ?? insight.title,
    summary: base?.summary ?? insight.summary,
    strengths: base?.strengths ?? insight.strengths,
    growthTip: base?.growthTip ?? insight.growthTip,
    blend:
        '${_elementName(stem, language)} + ${_elementName(branch, language)} (${_animalName(animal, language)})',
  );
}

_LocalizedElementInsight _localizedElementInsight(
  SajuElementInsight insight,
  String language,
) {
  if (!_isMyanmar(language)) {
    return _LocalizedElementInsight(
      title: insight.title,
      summary: insight.summary,
      status: insight.status,
      strength: insight.strengths,
      lowState: insight.lowState,
      habitFocus: insight.habitFocus,
      relationshipTip: insight.relationshipTip,
      careerTip: insight.careerTip,
      balanceAction: insight.balanceAction,
    );
  }

  final base = _elementTranslationsMyanmar[insight.element];
  final status = _statusMyanmar[insight.status] ?? insight.status;

  String summary = base?.essence ?? insight.summary;
  if (insight.status == 'Strong') {
    summary =
        '${base?.essence ?? insight.summary} ဒီဓာတ်က ဇာတာထဲမှာ အားအကောင်းဆုံးဖြစ်ပြီး လက်ဆောင်စွမ်းရည်တွေကို ပိုလွယ်ကူစွာ အသုံးချနိုင်ပါတယ်။';
  } else if (insight.status == 'Low') {
    summary =
        '${base?.essence ?? insight.summary} ဒီဓာတ်က နည်းနေသောကြောင့် ရည်ရွယ်ပြီး အားဖြည့်ရင် ပိုညီမျှလာပါလိမ့်မယ်။';
  } else if (insight.status == 'Balanced') {
    summary =
        '${base?.essence ?? insight.summary} ဒီဓာတ်က အလယ်အလတ်တည်ငြိမ်နေပြီး လိုက်လျောအသုံးချနိုင်စွမ်းကို ထောက်ပံ့ပေးပါတယ်။';
  }

  return _LocalizedElementInsight(
    title: base?.title ?? insight.title,
    summary: summary,
    status: status,
    strength: base?.strengths ?? insight.strengths,
    lowState: base?.lowState ?? insight.lowState,
    habitFocus: base?.habitFocus ?? insight.habitFocus,
    relationshipTip: base?.relationshipTip ?? insight.relationshipTip,
    careerTip: base?.careerTip ?? insight.careerTip,
    balanceAction: base?.balanceAction ?? insight.balanceAction,
  );
}

class _PillarTranslation {
  const _PillarTranslation({
    required this.title,
    required this.summary,
    required this.strengths,
    required this.growthTip,
  });

  final String title;
  final String summary;
  final List<String> strengths;
  final String growthTip;
}

class _ElementTranslation {
  const _ElementTranslation({
    required this.title,
    required this.essence,
    required this.strengths,
    required this.lowState,
    required this.habitFocus,
    required this.relationshipTip,
    required this.careerTip,
    required this.balanceAction,
  });

  final String title;
  final String essence;
  final String strengths;
  final String lowState;
  final String habitFocus;
  final String relationshipTip;
  final String careerTip;
  final String balanceAction;
}

class _LocalizedPillarInsight {
  const _LocalizedPillarInsight({
    required this.label,
    required this.title,
    required this.summary,
    required this.strengths,
    required this.growthTip,
    required this.blend,
  });

  final String label;
  final String title;
  final String summary;
  final List<String> strengths;
  final String growthTip;
  final String blend;
}

class _LocalizedElementInsight {
  const _LocalizedElementInsight({
    required this.title,
    required this.summary,
    required this.status,
    required this.strength,
    required this.lowState,
    required this.habitFocus,
    required this.relationshipTip,
    required this.careerTip,
    required this.balanceAction,
  });

  final String title;
  final String summary;
  final String status;
  final String strength;
  final String lowState;
  final String habitFocus;
  final String relationshipTip;
  final String careerTip;
  final String balanceAction;
}

class SajuProfileScreen extends ConsumerStatefulWidget {
  const SajuProfileScreen({super.key});

  @override
  ConsumerState<SajuProfileScreen> createState() => _SajuProfileScreenState();
}

class _SajuProfileScreenState extends ConsumerState<SajuProfileScreen> {
  late final TextEditingController _cityController;
  late final TextEditingController _countryController;
  String _resultLanguage = _langEnglish;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _countryController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sajuProfileControllerProvider);
    final controller = ref.read(sajuProfileControllerProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final hasAnyInput =
        state.birthDate != null ||
        state.birthTime != null ||
        state.birthCity.trim().isNotEmpty ||
        state.birthCountry.trim().isNotEmpty ||
        state.profile != null;

    _syncTextController(_cityController, state.birthCity);
    _syncTextController(_countryController, state.birthCountry);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saju Five Elements'),
        backgroundColor: Colors.transparent,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  'Saju (사주) Destiny Energy 🔮',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Use your full birth date, exact birth time, and birth city/country to calculate your 오행 profile.',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 14),
                GlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PickerField(
                        label: 'Full Birth Date',
                        icon: Icons.calendar_month_rounded,
                        accent: const Color(0xFFFF7AB6),
                        valueText: state.birthDate == null
                            ? 'Tap to select date'
                            : MaterialLocalizations.of(
                                context,
                              ).formatMediumDate(state.birthDate!),
                        onTap: () async {
                          final selected = await _pickDate(
                            context,
                            initialDate: state.birthDate,
                          );
                          if (selected != null) {
                            controller.setBirthDate(selected);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      _PickerField(
                        label: 'Exact Birth Time',
                        icon: Icons.schedule_rounded,
                        accent: const Color(0xFF57D7FF),
                        valueText: state.birthTime == null
                            ? 'Tap to select time'
                            : MaterialLocalizations.of(
                                context,
                              ).formatTimeOfDay(state.birthTime!),
                        onTap: () async {
                          final selected = await _pickTime(
                            context,
                            initialTime: state.birthTime,
                          );
                          if (selected != null) {
                            controller.setBirthTime(selected);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _cityController,
                        onChanged: controller.setBirthCity,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Birth City',
                          hintText: 'e.g., Seoul',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _countryController,
                        onChanged: controller.setBirthCountry,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Birth Country',
                          hintText: 'e.g., South Korea',
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: state.canCalculate
                                  ? controller.calculate
                                  : null,
                              child: const Text('Calculate My Saju ✨'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: hasAnyInput
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      controller.reset();
                                    }
                                  : null,
                              child: const Text('Start New Reading'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Uses Four Pillars stem/branch cycles and Five Elements weighting.',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  GlassPanel(
                    child: Text(
                      state.errorMessage!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFFFC9D9),
                      ),
                    ),
                  ),
                ],
                if (state.profile != null) ...[
                  _ResultLanguageTabs(
                    currentLanguage: _resultLanguage,
                    onChanged: (value) {
                      setState(() {
                        _resultLanguage = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(height: 14),
                  _PillarsCard(
                    profile: state.profile!,
                    language: _resultLanguage,
                  ),
                  const SizedBox(height: 12),
                  _ElementsCard(
                    profile: state.profile!,
                    language: _resultLanguage,
                  ),
                  const SizedBox(height: 12),
                  _InterpretationCard(
                    profile: state.profile!,
                    language: _resultLanguage,
                  ),
                  const SizedBox(height: 12),
                  _DeepDiveCard(
                    profile: state.profile!,
                    language: _resultLanguage,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _syncTextController(TextEditingController controller, String value) {
    if (controller.text == value) return;
    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context, {DateTime? initialDate}) {
    final now = DateTime.now();

    return showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year, now.month, now.day),
      initialDate: initialDate ?? DateTime(2000, 1, 1),
    );
  }

  Future<TimeOfDay?> _pickTime(BuildContext context, {TimeOfDay? initialTime}) {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? const TimeOfDay(hour: 12, minute: 0),
    );
  }
}

class _ResultLanguageTabs extends StatelessWidget {
  const _ResultLanguageTabs({
    required this.currentLanguage,
    required this.onChanged,
  });

  final String currentLanguage;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final ui = _ui(currentLanguage);

    return GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      radius: 16,
      child: Row(
        children: [
          Text(
            ui['languageLabel']!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          const Spacer(),
          _languageButton(context, id: _langEnglish, label: ui['englishTab']!),
          const SizedBox(width: 8),
          _languageButton(context, id: _langMyanmar, label: ui['myanmarTab']!),
        ],
      ),
    );
  }

  Widget _languageButton(
    BuildContext context, {
    required String id,
    required String label,
  }) {
    final selected = currentLanguage == id;
    final color = selected ? const Color(0xFF9F92FF) : Colors.white54;

    return OutlinedButton(
      onPressed: () => onChanged(id),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        foregroundColor: Colors.white,
        backgroundColor: selected
            ? const Color(0xFF9F92FF).withValues(alpha: 0.24)
            : Colors.transparent,
        minimumSize: const Size(0, 42),
        padding: const EdgeInsets.symmetric(horizontal: 14),
      ),
      child: Text(label),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.icon,
    required this.accent,
    required this.valueText,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color accent;
  final String valueText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    valueText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down_rounded, color: accent),
          ],
        ),
      ),
    );
  }
}

class _PillarsCard extends StatelessWidget {
  const _PillarsCard({required this.profile, required this.language});

  final SajuProfile profile;
  final String language;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _ui(language)['fourPillarsTitle']!,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: profile.pillars.map((pillar) {
              return Container(
                width: 155,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.14),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _pillarLabel(pillar.label, language),
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pillar.hanja,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(pillar.korean, style: textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      '${_animalName(pillar.animal, language)} • ${_elementName(pillar.stemElement, language)}/${_elementName(pillar.branchElement, language)}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Text(
            '${profile.birthCity}, ${profile.birthCountry} • ${profile.timeZone}',
            style: textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ElementsCard extends StatelessWidget {
  const _ElementsCard({required this.profile, required this.language});

  final SajuProfile profile;
  final String language;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final maxValue = profile.elementCounts.values.fold<int>(
      1,
      (previousValue, element) =>
          element > previousValue ? element : previousValue,
    );
    final weakLabel = profile.weakElements
        .map((value) => _elementKorean[value] ?? value)
        .join(', ');

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _ui(language)['fiveElementsTitle']!,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          ..._elementOrder.map((element) {
            final value = profile.elementCounts[element] ?? 0;
            final progress = value / maxValue;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(_elementKorean[element] ?? element),
                      const Spacer(),
                      Text('$value'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 9,
                      value: progress,
                      backgroundColor: Colors.white.withValues(alpha: 0.13),
                      valueColor: AlwaysStoppedAnimation(
                        _elementColors[element] ?? const Color(0xFF8B7CFF),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 2),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                label: Text(
                  '${_ui(language)['dominant']}: ${_elementKorean[profile.dominantElement] ?? profile.dominantElement}'
                  '${_isMyanmar(language) ? ' (${_elementName(profile.dominantElement, language)})' : ''}',
                ),
              ),
              Chip(
                label: Text(
                  '${_ui(language)['balanceFocus']}: $weakLabel'
                  '${_isMyanmar(language) ? ' (${profile.weakElements.map((e) => _elementName(e, language)).join(', ')})' : ''}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InterpretationCard extends StatelessWidget {
  const _InterpretationCard({required this.profile, required this.language});

  final SajuProfile profile;
  final String language;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_ui(language)['destinyTitle']!, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            _localizedEnergySummary(profile, language),
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            _localizedDestiny(profile, language),
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
              fontSize: 15.2,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _localizedOverview(profile, language),
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFE8EEFF),
              fontWeight: FontWeight.w600,
              fontSize: 15.4,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          Text(_ui(language)['adviceTitle']!, style: textTheme.titleMedium),
          const SizedBox(height: 6),
          ..._localizedAdvice(profile, language).map((tip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.auto_awesome, size: 14),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _localizedNotes(profile, language).map((note) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '• $note',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeepDiveCard extends StatelessWidget {
  const _DeepDiveCard({required this.profile, required this.language});

  final SajuProfile profile;
  final String language;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_ui(language)['deepDiveTitle']!, style: textTheme.titleMedium),
          const SizedBox(height: 10),
          Text(
            _ui(language)['deepOverview']!,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _ui(language)['pillarInsightTitle']!,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...profile.pillarInsights.map((insight) {
            final localized = _localizedPillarInsight(insight, language);
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localized.label,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 2),
                  Text(localized.title, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    localized.blend,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white60),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    localized.summary,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.42,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...localized.strengths.map((line) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '• $line',
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFE5ECFF),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  Text(
                    '${_ui(language)['growthFocus']}: ${localized.growthTip}',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFF1F5FF),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),
          Text(
            _ui(language)['elementInsightTitle']!,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...profile.elementInsights.map((insight) {
            final localized = _localizedElementInsight(insight, language);
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        insight.korean,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_ui(language)['score']} ${insight.score} • ${localized.status}',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(localized.title, style: textTheme.bodyLarge),
                  const SizedBox(height: 6),
                  _detailLine(
                    _ui(language)['summary'] ?? 'Summary',
                    localized.summary,
                    textTheme,
                  ),
                  _detailLine(
                    _ui(language)['strength']!,
                    localized.strength,
                    textTheme,
                  ),
                  _detailLine(
                    _ui(language)['whenLow']!,
                    localized.lowState,
                    textTheme,
                  ),
                  _detailLine(
                    _ui(language)['habits']!,
                    localized.habitFocus,
                    textTheme,
                  ),
                  _detailLine(
                    _ui(language)['relationship']!,
                    localized.relationshipTip,
                    textTheme,
                  ),
                  _detailLine(
                    _ui(language)['career']!,
                    localized.careerTip,
                    textTheme,
                  ),
                  _detailLine(
                    _ui(language)['balanceAction']!,
                    localized.balanceAction,
                    textTheme,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _detailLine(String label, String body, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white70,
            fontSize: 14,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: Color(0xFFF2F6FF),
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: body),
          ],
        ),
      ),
    );
  }
}

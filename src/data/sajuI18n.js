import { ELEMENT_META } from './sajuData';

const ELEMENT_MM = {
  Wood: 'သစ်',
  Fire: 'မီး',
  Earth: 'မြေ',
  Metal: 'သတ္တု',
  Water: 'ရေ',
};

const ANIMAL_MM = {
  Rat: 'ကြွက်',
  Ox: 'နွား',
  Tiger: 'ကျား',
  Rabbit: 'ယုန်',
  Dragon: 'နဂါး',
  Snake: 'မြွေ',
  Horse: 'မြင်း',
  Goat: 'ဆိတ်',
  Monkey: 'မျောက်',
  Rooster: 'ကြက်',
  Dog: 'ခွေး',
  Pig: 'ဝက်',
};

const PILLAR_LABEL_MM = {
  'Year Pillar': 'Year Pillar (နှစ်တိုင်)',
  'Month Pillar': 'Month Pillar (လတိုင်)',
  'Day Pillar': 'Day Pillar (နေ့တိုင်)',
  'Hour Pillar': 'Hour Pillar (နာရီတိုင်)',
};

const STATUS_MM = {
  Strong: 'အားကောင်း',
  Low: 'အားနည်း',
  Balanced: 'ညီမျှ',
};

const DESTINY_MM = {
  Wood: 'သင့်ကံကြမ္မာစွမ်းအင်မှာ တိုးတက်မှု၊ လေ့လာမှုနှင့် ရည်မှန်းချက်တစ်ခုဆီသို့ ရွေ့လျားခြင်းမှ အားဖြစ်စေပါတယ်။',
  Fire: 'သင့်ကံကြမ္မာစွမ်းအင်မှာ ဖော်ထုတ်ပြသမှု၊ နွေးထွေးမှုနှင့် လှုံ့ဆော်မှုမှ အားဖြစ်စေပါတယ်။',
  Earth: 'သင့်ကံကြမ္မာစွမ်းအင်မှာ တည်ငြိမ်မှု၊ ယုံကြည်မှုတည်ဆောက်ခြင်းနှင့် အစဉ်တကျလုပ်ဆောင်ခြင်းမှ အားဖြစ်စေပါတယ်။',
  Metal: 'သင့်ကံကြမ္မာစွမ်းအင်မှာ စည်းကမ်း၊ စံနှုန်းနှင့် တိကျမှုမှ အားဖြစ်စေပါတယ်။',
  Water: 'သင့်ကံကြမ္မာစွမ်းအင်မှာ ခံစားသိမြင်နိုင်မှု၊ လိုက်လျောပြောင်းလဲနိုင်မှုနှင့် အတွင်းသိမှူးမှ အားဖြစ်စေပါတယ်။',
};

const ELEMENT_PRIMARY_ADVICE_MM = {
  Wood: 'တစ်ပတ်တစ်ကြိမ် လေ့လာမှု၊ မန်တော်ပေးခြင်း၊ စွမ်းရည်တိုးတက်ရေး စီစဉ်မှုများထည့်ပါ။',
  Fire: 'ရေးသားခြင်း၊ အသံထုတ်ခြင်း၊ အနုပညာစတဲ့ ဖန်တီးမှုနည်းလမ်းဖြင့် စွမ်းအင်ကို မျှတစေပါ။',
  Earth: 'အိပ်ချိန်၊ အစားအသောက်နှင့် လှုပ်ရှားမှုကို ပုံမှန်အစီအစဉ်ထားပါ။',
  Metal: 'အချိန်၊ ငွေကြေးနှင့် ဆက်သွယ်ရေးအတွက် နယ်နိမိတ်များကို သေချာသတ်မှတ်ပါ။',
  Water: 'တိတ်ဆိတ်စဉ်းစားချိန်များ ထားရှိပြီး အတွင်းသိကို ပြန်တိုးတက်စေပါ။',
};

const PILLAR_DEEP_MM = {
  'Year Pillar': {
    title: 'အပြင်ဘက်ကံနှင့် အစောပိုင်းပတ်ဝန်းကျင်',
    summary:
      'Year Pillar သည် မွေးရာပါလက်ခံရသည့်စွမ်းအင်၊ လူမှုရေးပုံရိပ်နှင့် အစောပိုင်းဘဝအခြေခံကို ဖော်ပြပေးပါတယ်။',
    strengths: [
      'ဘယ်လိုအသိုင်းအဝိုင်းမှာ ကံအလျင်မြန်ဆုံးဖွင့်မလဲဆိုတာ ပြသပေးပါတယ်။',
      'အခြားသူတွေက သင့်စွမ်းအင်ကို ပထမဦးဆုံးဘယ်လိုဖတ်မလဲဆိုတာ ဖော်ပြပေးပါတယ်။',
    ],
    growthTip:
      'တန်ဖိုးတူအသိုင်းအဝိုင်းကို ရွေးချယ်ပြီး Year Pillar ကို အားဖြည့်ပါ။',
  },
  'Month Pillar': {
    title: 'အလုပ်အကိုင်လှိုင်းနှင့် ထုတ်လုပ်နိုင်စွမ်း',
    summary:
      'Month Pillar သည် အလုပ်လုပ်ပုံ၊ စည်းကမ်းနှင့် ကြီးထွားရာကာလအတွင်း စွမ်းအင်အခြေအနေကို ဖော်ပြပေးပါတယ်။',
    strengths: [
      'ဘယ်နေရာမှာ ကြိုးစားမှုက ဆက်လက်တိုးပွားသွားမလဲဆိုတာ ပြသပေးပါတယ်။',
      'ပင်ပန်းလွန်းမှုမဖြစ်ဘဲ တည်ငြိမ်စွာတိုးတက်ဖို့ လှိုင်းစီးနည်းပေးပါတယ်။',
    ],
    growthTip:
      'တစ်ပတ်စာလုပ်ဆောင်မှုကို ပုံမှန်ဖွဲ့စည်းပါ။ ပုံမှန်လှိုင်းက ရေရှည်ကံကို တည်ငြိမ်စေပါတယ်။',
  },
  'Day Pillar': {
    title: 'အဓိကကိုယ်ပိုင်စရိုက်နှင့် ဆက်ဆံရေးပုံစံ',
    summary:
      'Day Pillar သည် ဇာတာ၏နှလုံးချက်ဖြစ်ပြီး ကိုယ်ပိုင်အကျင့်၊ ခံစားချက်လိုအပ်ချက်နှင့် တစ်ဦးချင်းဆက်ဆံရေးကို ဖော်ပြပါတယ်။',
    strengths: [
      'သင်၏ တကယ့်ခံစားချက်ပုံစံနှင့် ယုံကြည်မှုပြောဆိုပုံကို ပြသပေးပါတယ်။',
      'အနီးကပ်ဆက်ဆံရေးမှာ တိုးတက်ဖို့လိုအပ်သည့် အရည်အသွေးများကို ဖော်ထုတ်ပေးပါတယ်။',
    ],
    growthTip:
      'ခံစားချက်လိုအပ်ချက်ကို တိုက်ရိုက်ပြောဆိုပါ။ ရှင်းလင်းမှုက ဆက်ဆံရေးအချိန်ကောင်းကို ဖန်တီးပေးပါတယ်။',
  },
  'Hour Pillar': {
    title: 'အနာဂတ်မျှော်မှန်းချက်နှင့် အတွင်းဖန်တီးနိုင်စွမ်း',
    summary:
      'Hour Pillar သည် ရေရှည်အိပ်မက်၊ အတွင်းစိတ်လှုံ့ဆော်မှုနှင့် နောက်ပိုင်းဘဝအထိ ပျိုးထောင်မည့် သက်ရောက်မှုစွမ်းအင်ကို ဖော်ပြပါတယ်။',
    strengths: [
      'နောက်ပိုင်းဘဝမှာ ပိုသန်မာလာမယ့် လျှို့ဝှက်အားသာချက်တွေကို ပြသပေးပါတယ်။',
      'အတွင်းသိနှင့် အနာဂတ်စီမံကိန်းကို ဘယ်လိုပေါင်းစပ်ရမလဲဆိုတာ ညွှန်ပြပေးပါတယ်။',
    ],
    growthTip:
      'အာရုံစိုက်နက်နဲချိန်ကို ကာကွယ်ထားပါ။ တိတ်တိတ်ဆိတ်ဆိတ် ဆန်းစစ်ခြင်းက အကျိုးရှိဆုံးရလဒ်တွေကို ဖွင့်ပေးပါတယ်။',
  },
};

const ELEMENT_DEEP_MM = {
  Wood: {
    title: 'တိုးတက်မှုမောင်းနှင်အား',
    essence: 'ချဲ့ထွင်မှု၊ မဟာဗျူဟာ၊ ဖန်တီးနိုင်စွမ်းနှင့် ရေရှည်ဦးတည်ချက်။',
    strengths: 'သင်သည် လေ့လာမှုနှင့် အမြင်ရှည်မားမှုကြောင့် တိုးတက်မှုအလျင်ကောင်းကို ဖန်တီးနိုင်သည်။',
    lowState: 'အားနည်းသည့်အခါ ဦးတည်ချက်မရှင်းကာ ဆုံးဖြတ်ချက်နှေးကွေးနိုင်သည်။',
    habitFocus: 'သုံးလတစ်ကြိမ် အဓိကတိုးတက်ရေးရည်မှန်းချက်တစ်ခု သတ်မှတ်ပြီး အပတ်စဉ်စစ်ဆေးပါ။',
    relationshipTip: 'အနာဂတ်အစီအစဉ်ကို မျှဝေပြောဆိုခြင်းဖြင့် ဆက်ဆံရေးပူးပေါင်းမှုကို တိုးတက်စေပါ။',
    careerTip: 'စီမံကိန်းရေးဆွဲမှု၊ coaching၊ ထုတ်ကုန်ဖန်တီးမှုနှင့် innovation အလုပ်များအတွက် သင့်တော်သည်။',
    balanceAction: 'သဘာဝလမ်းလျှောက်ခြင်းနှင့် journal ရေးခြင်းဖြင့် အမြင်ကို ပြန်လည်သစ်စေပါ။',
  },
  Fire: {
    title: 'ဖော်ထုတ်ပြသမှုမောင်းနှင်အား',
    essence: 'ထင်ရှားမှု၊ ဆွဲဆောင်မှု၊ စိတ်အားထက်သန်မှုနှင့် ဖော်ပြနိုင်စွမ်း။',
    strengths: 'သင်သည် နွေးထွေးမှုနှင့် စိတ်လှုပ်ရှားဖွယ်ဖော်ပြမှုတို့ဖြင့် အခြားသူများကို လှုံ့ဆော်နိုင်သည်။',
    lowState: 'အားနည်းသည့်အခါ စိတ်အားကျပြီး ကိုယ်ပိုင်ဖော်ပြမှု လျော့ကျနိုင်သည်။',
    habitFocus: 'နေ့စဉ် ဖန်တီးမှုထုတ်လွှတ်ချိန် (ရေး၊ ပြော၊ ဖန်တီး) ထားပါ။',
    relationshipTip: 'အသေးစားအောင်မြင်မှုများကို အတူကျင်းပပြီး ချစ်ကြည်မှုကို တိုးစေပါ။',
    careerTip: 'စကားပြော/ဖျော်ဖြေ/ခေါင်းဆောင်မှု/content/storytelling လုပ်ငန်းများတွင် Fire အားကောင်းသည်။',
    balanceAction: 'အိပ်ရေးနှင့် အနားယူချိန်ကို ကာကွယ်ပြီး burnout မဖြစ်စေပါ။',
  },
  Earth: {
    title: 'တည်ငြိမ်မှုမောင်းနှင်အား',
    essence: 'မြေပြင်တည်ငြိမ်မှု၊ ယုံကြည်မှု၊ တာဝန်ယူမှုနှင့် လက်တွေ့ကူညီနိုင်စွမ်း။',
    strengths: 'သင်သည် တည်ငြိမ်မှုနှင့် ယုံကြည်လောက်မှုဖြင့် လုံခြုံမှုဖန်တီးနိုင်သည်။',
    lowState: 'အားနည်းသည့်အခါ routine ပျက်ကွက်ပြီး ဖိအားများ ပျံ့နှံ့နိုင်သည်။',
    habitFocus: 'အိပ်/နိုးအချိန်နှင့် အစားအသောက်အချိန်ကို ပုံမှန်တည်ဆောက်ပါ။',
    relationshipTip: 'ကတိကဝတ်ကို ရှင်းလင်းစွာ သတ်မှတ်ပြီး တည်ငြိမ်ယုံကြည်မှုကို တိုးစေပါ။',
    careerTip: 'operations၊ management၊ counseling နှင့် ရေရှည်စီမံကိန်းများအတွက် သင့်တော်သည်။',
    balanceAction: 'အလုပ်များလွန်းမှုကို လျှော့ပြီး အခြေခံ routine တစ်ခုသို့ ပြန်ဆုတ်ပါ။',
  },
  Metal: {
    title: 'တိကျမှုမောင်းနှင်အား',
    essence: 'ဖွဲ့စည်းပုံ၊ စံနှုန်း၊ နယ်နိမိတ်နှင့် တိကျသုံးသပ်နိုင်စွမ်း။',
    strengths: 'သင်သည် အရေးကြီးချက်ကို စိစစ်ရွေးချယ်ရာတွင် ထူးချွန်သည်။',
    lowState: 'အားနည်းသည့်အခါ နယ်နိမိတ်မရှင်းကာ ဆုံးဖြတ်ချက်များ ပြန့်ကျဲနိုင်သည်။',
    habitFocus: 'အပတ်စဉ် calendar/inbox/commitment များကို စနစ်တကျ ရှင်းလင်းပါ။',
    relationshipTip: 'ဆက်ဆံရေးအစောပိုင်းကတည်းက နယ်နိမိတ်ကို ယဉ်ကျေးစွာ သတ်မှတ်ပါ။',
    careerTip: 'analysis၊ finance၊ strategy၊ compliance၊ systems design လုပ်ငန်းများတွင် Metal သင့်တော်သည်။',
    balanceAction: 'ဆုံးဖြတ်ချက်စံနှုန်းတိကျစွာ သတ်မှတ်ပြီး overcommit မလုပ်ပါနှင့်။',
  },
  Water: {
    title: 'ဉာဏ်အမြင်မောင်းနှင်အား',
    essence: 'အတွင်းသိ၊ လိုက်လျောပြောင်းလဲနိုင်မှု၊ နက်နဲမှုနှင့် ဆင်ခြင်နိုင်စွမ်း။',
    strengths: 'သင်သည် နူးညံ့သော pattern များကို မြန်မြန်ဖမ်းယူနိုင်ပြီး ပြောင်းလဲမှုကို အလွယ်တကူ တုံ့ပြန်နိုင်သည်။',
    lowState: 'အားနည်းသည့်အခါ စိတ်ရှုပ်ထွေးမှုနှင့် ဆုံးဖြတ်ချက်မခိုင်မာမှု ဖြစ်နိုင်သည်။',
    habitFocus: 'တိတ်ဆိတ်စဉ်းစားချိန် (meditation/prayer/journaling) ကို ပုံမှန်ထားပါ။',
    relationshipTip: 'ခံစားချက်များကို တိတ်သိမ်းမထားဘဲ သင့်တင့်အချိန်မှာ မျှဝေပါ။',
    careerTip: 'research၊ design၊ healing၊ strategy နှင့် adaptive leadership လုပ်ငန်းများတွင် Water သင့်တော်သည်။',
    balanceAction: 'စဉ်းစားချိန်ကို နေ့စဉ် concrete action တစ်ခုနှင့် တွဲဖက်ပါ။',
  },
};

const MY_NOTES = [
  'Month pillar ကို နေရောင်ပြောင်းလဲခွင် (입춘 기준) ခန့်မှန်းပုံစံဖြင့် တွက်ထားပါသည်။',
  'မွေးမြို့/မွေးနိုင်ငံကို timezone ခန့်မှန်းရန် အသုံးပြုထားပါသည်။',
];

const UI_TEXT = {
  en: {
    languageLabel: 'Result Language',
    englishTab: 'English',
    myanmarTab: 'Myanmar',
    fourPillarsTitle: 'Four Pillars (사주팔자)',
    fiveElementsTitle: 'Five Elements Balance (오행)',
    destinyTitle: 'Destiny Energy Interpretation',
    personalizedAdviceTitle: 'Personalized Saju Advice',
    deepDiveTitle: 'English Deep Dive (Detailed)',
    deepOverviewTitle: 'Pillar-by-pillar and element-by-element reading in English.',
    pillarInsightTitle: 'Pillar-by-Pillar Insight',
    elementInsightTitle: 'Element-by-Element Reading',
    dominantTag: 'Dominant',
    balanceTag: 'Balance Focus',
    growthFocusLabel: 'Growth focus',
    scoreLabel: 'Score',
    strengthLabel: 'Strength',
    whenLowLabel: 'When low',
    habitsLabel: 'Habits',
    relationshipLabel: 'Relationship',
    careerLabel: 'Career',
    balanceActionLabel: 'Balance action',
  },
  my: {
    languageLabel: 'Result ဘာသာစကား',
    englishTab: 'English',
    myanmarTab: 'မြန်မာ',
    fourPillarsTitle: 'တိုင်လေးတိုင် (사주팔자)',
    fiveElementsTitle: 'ဓာတ်ငါးပါးညီမျှမှု (오행)',
    destinyTitle: 'ကံကြမ္မာစွမ်းအင် အဓိပ္ပါယ်ဖော်ခြင်း',
    personalizedAdviceTitle: 'ကိုယ်ပိုင် Saju အကြံပြုချက်',
    deepDiveTitle: 'အတိအကျ မြန်မာဘာသာ Deep Dive',
    deepOverviewTitle: 'တိုင်တိုင်း/ဓာတ်တိုင်း အသေးစိတ်ဖတ်ရှုချက် (မြန်မာ)',
    pillarInsightTitle: 'တိုင်တစ်တိုင်ချင်း ဖတ်ရှုချက်',
    elementInsightTitle: 'ဓာတ်တစ်ခုချင်း ဖတ်ရှုချက်',
    dominantTag: 'အဓိကဓာတ်',
    balanceTag: 'ညီမျှစေရန်ဓာတ်',
    growthFocusLabel: 'တိုးတက်ရေးအာရုံစိုက်ရန်',
    scoreLabel: 'ရမှတ်',
    strengthLabel: 'အားသာချက်',
    whenLowLabel: 'အားနည်းသည့်အခါ',
    habitsLabel: 'အလေ့အထ',
    relationshipLabel: 'ဆက်ဆံရေး',
    careerLabel: 'အလုပ်အကိုင်',
    balanceActionLabel: 'ညီမျှရေးလုပ်ဆောင်ချက်',
  },
};

function safeElementName(element) {
  return ELEMENT_MM[element] || element;
}

function buildMyanmarAdvice(dominantElement, weakElements) {
  const dominantKorean = ELEMENT_META[dominantElement]?.korean || dominantElement;
  const list = [
    `${dominantKorean} (${safeElementName(dominantElement)}) စွမ်းအင်က အားအကောင်းဆုံးဖြစ်နေပါတယ်။ သဘာဝလက်ဆောင်တွေကို ရည်ရွယ်ချက်ရှိစွာ အသုံးချပါ။`,
    ELEMENT_PRIMARY_ADVICE_MM[dominantElement],
  ];

  weakElements.forEach((element) => {
    const korean = ELEMENT_META[element]?.korean || element;
    list.push(
      `${korean} (${safeElementName(element)}) ဓာတ်ကို ညီမျှစေရန် - ${ELEMENT_PRIMARY_ADVICE_MM[element]}`
    );
  });

  list.push('Saju အချိန်လှိုင်းနှင့်လိုက်ဖက်စေရန် လစဉ် ပြန်လည်သုံးသပ်ပြီး ရွေ့လျားစွာညှိနှိုင်းပါ။');
  return list.filter(Boolean);
}

function buildMyanmarElementDeepDive(item) {
  const base = ELEMENT_DEEP_MM[item.element];
  const status = STATUS_MM[item.status] || item.status;
  let summary = base?.essence || item.summary;

  if (item.status === 'Strong') {
    summary = `${base?.essence || item.summary} ဒီဓာတ်က ဇာတာထဲမှာ အားအကောင်းဆုံးဖြစ်ပြီး လက်ဆောင်စွမ်းရည်တွေကို ပိုလွယ်ကူစွာ အသုံးချနိုင်ပါတယ်။`;
  } else if (item.status === 'Low') {
    summary = `${base?.essence || item.summary} ဒီဓာတ်က နည်းနေသောကြောင့် ရည်ရွယ်ပြီး အားဖြည့်ရင် ပိုညီမျှလာပါလိမ့်မယ်။`;
  } else if (item.status === 'Balanced') {
    summary = `${base?.essence || item.summary} ဒီဓာတ်က အလယ်အလတ်တည်ငြိမ်နေပြီး လိုက်လျောအသုံးချနိုင်စွမ်းကို ထောက်ပံ့ပေးပါတယ်။`;
  }

  return {
    element: item.element,
    korean: item.korean,
    score: item.score,
    status,
    title: base?.title || item.title,
    summary,
    strengths: base?.strengths || item.strengths,
    lowState: base?.lowState || item.lowState,
    habitFocus: base?.habitFocus || item.habitFocus,
    relationshipTip: base?.relationshipTip || item.relationshipTip,
    careerTip: base?.careerTip || item.careerTip,
    balanceAction: base?.balanceAction || item.balanceAction,
  };
}

export function buildLocalizedSajuResult(profile, language = 'en') {
  const lang = language === 'my' ? 'my' : 'en';
  const ui = UI_TEXT[lang];

  const pillars = profile.pillars.map((pillar) => {
    const label = lang === 'my' ? (PILLAR_LABEL_MM[pillar.label] || pillar.label) : pillar.label;
    const animal = lang === 'my' ? (ANIMAL_MM[pillar.animal] || pillar.animal) : pillar.animal;
    const stemLabel = lang === 'my' ? safeElementName(pillar.stem.element) : pillar.stem.element;
    const branchLabel = lang === 'my' ? safeElementName(pillar.branch.element) : pillar.branch.element;

    return {
      ...pillar,
      displayLabel: label,
      displayAnimal: animal,
      displayElementPair: `${stemLabel}/${branchLabel}`,
    };
  });

  if (lang === 'en') {
    return {
      ui,
      pillars,
      locationLine: `${profile.birthLocation.city}, ${profile.birthLocation.country} · ${profile.timezone}`,
      energySummary: profile.energySummary,
      destinyInterpretation: profile.destinyInterpretation,
      personalizedAdvice: profile.personalizedAdvice,
      notes: profile.notes,
      deepOverview: profile.englishOverview,
      dominantTag: `${ui.dominantTag}: ${ELEMENT_META[profile.dominantElement].korean}`,
      balanceTag: `${ui.balanceTag}: ${profile.weakElements
        .map((item) => ELEMENT_META[item].korean)
        .join(', ')}`,
      pillarDeepDive: profile.pillarDeepDive.map((item) => ({
        label: item.label,
        title: item.title,
        blend: `${item.hanja} · ${item.korean} · ${item.englishBlend}`,
        summary: item.summary,
        strengths: item.strengths,
        growthTip: item.growthTip,
      })),
      elementDeepDive: profile.elementDeepDive.map((item) => ({ ...item })),
    };
  }

  const weakMmList = profile.weakElements.map((item) => safeElementName(item)).join(', ');
  const dominantKorean = ELEMENT_META[profile.dominantElement].korean;

  return {
    ui,
    pillars,
    locationLine: `${profile.birthLocation.city}, ${profile.birthLocation.country} · ${profile.timezone}`,
    energySummary: `${dominantKorean} (${safeElementName(profile.dominantElement)}) စွမ်းအင်က ဇာတာထဲမှာ အားအကောင်းဆုံးဖြစ်ပါတယ်။ ညီမျှစေရန် ${weakMmList} ကို အဓိကထားပါ။`,
    destinyInterpretation: DESTINY_MM[profile.dominantElement] || profile.destinyInterpretation,
    personalizedAdvice: buildMyanmarAdvice(profile.dominantElement, profile.weakElements),
    notes: MY_NOTES,
    deepOverview: `သင်၏ဇာတာတွင် ${safeElementName(profile.dominantElement)} စွမ်းအင်က ဦးဆောင်နေပါတယ်။ ညီမျှမှုအတွက် ${weakMmList} ဓာတ်ကို နေ့စဉ်အလေ့အထများဖြင့် ထည့်သွင်းအားဖြည့်ရန် လိုအပ်ပါတယ်။`,
    dominantTag: `${ui.dominantTag}: ${dominantKorean} (${safeElementName(profile.dominantElement)})`,
    balanceTag: `${ui.balanceTag}: ${profile.weakElements
      .map((item) => `${ELEMENT_META[item].korean} (${safeElementName(item)})`)
      .join(', ')}`,
    pillarDeepDive: profile.pillarDeepDive.map((item) => {
      const base = PILLAR_DEEP_MM[item.label];
      const stemElement = item.englishBlend.split(' stem + ')[0];
      const branchPart = item.englishBlend.split(' stem + ')[1] || '';
      const branchElement = branchPart.split(' branch')[0];
      const animal = branchPart.includes('(') ? branchPart.split('(')[1].replace(')', '') : '';

      return {
        label: PILLAR_LABEL_MM[item.label] || item.label,
        title: base?.title || item.title,
        blend: `${item.hanja} · ${item.korean} · ${safeElementName(stemElement)} + ${safeElementName(branchElement)} (${ANIMAL_MM[animal] || animal})`,
        summary: base?.summary || item.summary,
        strengths: base?.strengths || item.strengths,
        growthTip: base?.growthTip || item.growthTip,
      };
    }),
    elementDeepDive: profile.elementDeepDive.map((item) => buildMyanmarElementDeepDive(item)),
  };
}

export const SAJU_RESULT_UI_TEXT = UI_TEXT;

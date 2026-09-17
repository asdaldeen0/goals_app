# 📓 أهدافي — دفتر الإنجاز (The Achievement Ledger)

تطبيق شخصي لتتبع الأهداف وتوثيق الإنجازات اليومية، مبني بإطار عمل **Flutter** ومستوحى بصرياً من هوية "دفاتر الحسابات والأرشيف العتيق" (ورق دافئ، حبر كحلي، ولمسات برونزية وختم شمعي).

---

## 🌟 مميزات التطبيق

- **تتبع الأهداف والمهام الفرعية:** إدارة كاملة للأهداف الحالية والمكتملة والمتأخرة.
- **إحصائيات الإنجاز:** بطاقات ورسوم تقدم مخصصة لمتابعة نسبة التقدم الفعلي.
- **نظام تنبيهات ذكي:** تذكيرات مجدولة يومية باستخدام `flutter_local_notifications`.
- **هوية بصرية فريدة (Ledger Aesthetic):** تصميم هادئ ودافئ مريح للعين بعيداً عن ألوان النيون المعتادة.
- **حفظ تفضيلات المستخدم محلياً:** إدارة بيانات المستخدم والإشعارات عبر `GetStorage`.

---

## 🛠️ التقنيات المستخدمة (Tech Stack)

- **Framework:** Flutter
- **Architecture:** Clean Architecture
- **State Management:** GetX
- **Local Storage:** GetStorage
- **Notifications:** flutter_local_notifications & timezone
- **Design System:** Custom Design Palette (`AppColors` & `AppTypography`)

---

## 🚀 تشغيل المشروع محلياً

```bash
# استنساخ المستودع
git clone [https://github.com/asdaldeen0/goals_app.git](https://github.com/asdaldeen0/goals_app.git)

# الانتقال للمجلد
cd goals_app

# تحميل الحزم
flutter pub get

# تشغيل التطبيق
flutter run
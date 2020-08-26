import 'dart:convert';

/// Sample data for receiving from beyond :)
const data = {
  "sections": [
    {
      "id": 1,
      "title": "Продукты"
    },
    {
      "id": 2,
      "title": "Фермеры"
    },
    {
      "id": 3,
      "title": "Агротуры"
    }
  ],
  "categories": [
    {
      "id": 1,
      "sectionId": 1,
      "title": "Овощи и фрукты",
      "icon": "assets/images/categories/fruit.png"
    },
    {
      "id": 2,
      "sectionId": 1,
      "title": "Мясо и рыба",
      "icon": "assets/images/categories/meat.png"
    },
    {
      "id": 3,
      "sectionId": 1,
      "title": "Молоко и яйца",
      "icon": "assets/images/categories/milk.png"
    }
  ],
  "products": [
    {
      "id": 1,
      "sectionId": 1,
      "categoryId": 3,
      "farmerId": 1,
      "title": "Молоко 5%",
      "unit": "1л",
      "totalRating": 4.0,
      "ratingCount": 1,
      "image": "assets/images/products/milk1.jpg",
      "shortDescription": "Наше молоко и сливки поступают на завод в тот же день, когда доят коров.",
      "description": "Наше молоко и сливки поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 100.0,
      "characteristics": [
        {
          "title": "Вес продукта",
          "value": "1,501 кг"
        },
        {
          "title": "Вес продукта с упаковкой",
          "value": "2,300 кг"
        },
        {
          "title": "Категория",
          "value": "Молочный продукт"
        },
        {
          "title": "Тип маркировки",
          "value": "Столовое"
        },
        {
          "title": "Срок годности",
          "value": "7 суток"
        },
        {
          "title": "Вес продукта",
          "value": "1,680 кг"
        },
        {
          "title": "Вес продукта с упаковкой",
          "value": "2,300 кг"
        },
        {
          "title": "Категория",
          "value": "Сырный продукт"
        },
        {
          "title": "Тип маркировки",
          "value": "Столовое"
        },
        {
          "title": "Срок годности",
          "value": "7 суток"
        }
      ]
    },
    {
      "id": 2,
      "sectionId": 1,
      "categoryId": 3,
      "farmerId": 1,
      "title": "Сливки 5%",
      "unit": "0.5 л",
      "totalRating": 3.8,
      "ratingCount": 3,
      "image": "assets/images/products/milk2.jpg",
      "shortDescription": "Наше молоко и сливки поступают на завод в тот же день, когда доят коров.",
      "description": "Наше молоко и сливки поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 120.0,
      "characteristics": [
        {
          "title": "Вес продукта",
          "value": "0,680 кг"
        },
        {
          "title": "Категория",
          "value": "Молочный продукт"
        }
      ]
    },
    {
      "id": 3,
      "sectionId": 1,
      "categoryId": 3,
      "farmerId": 1,
      "title": "Сыр Гауда 40%",
      "unit": "0.200 кг",
      "totalRating": 12.3,
      "ratingCount": 4,
      "image": "assets/images/products/cheese1.jpg",
      "shortDescription": "Наш сыр поступает на завод в тот же год, когда доят коров.",
      "description": "Наш сыр поступает на завод в тот же год, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 160.0,
      "characteristics": [
        {
          "title": "Вес продукта",
          "value": "0,4500 кг"
        },
        {
          "title": "Категория",
          "value": "Молочный продукт"
        }
      ]
    },
    {
      "id": 4,
      "sectionId": 1,
      "categoryId": 2,
      "farmerId": 2,
      "title": "Курица",
      "unit": "1кг",
      "totalRating": 0.0,
      "ratingCount": 0,
      "image": "assets/images/products/chicken1.jpg",
      "shortDescription": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров.",
      "description": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 250.0,
      "characteristics": [
        {
          "title": "Вес продукта",
          "value": "0,4500 кг"
        },
        {
          "title": "Категория",
          "value": "Молочный продукт"
        }
      ]
    },
    {
      "id": 5,
      "sectionId": 1,
      "categoryId": 2,
      "farmerId": 2,
      "title": "Куриные ножки",
      "unit": "1кг",
      "totalRating": 7.1,
      "ratingCount": 21,
      "image": "assets/images/products/chicken2.jpg",
      "shortDescription": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров.",
      "description": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 170.0,
      "characteristics": []
    },
    {
      "id": 6,
      "sectionId": 1,
      "categoryId": 2,
      "farmerId": 2,
      "title": "Куриные желудки",
      "unit": "1кг",
      "totalRating": 4,
      "ratingCount": 3,
      "image": "assets/images/products/chicken3.jpg",
      "shortDescription": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров.",
      "description": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 110.0,
      "characteristics": []
    },
    {
      "id": 7,
      "sectionId": 1,
      "categoryId": 2,
      "farmerId": 2,
      "title": "Рыба",
      "unit": "1кг",
      "totalRating": 4,
      "ratingCount": 3,
      "image": "assets/images/products/fish1.jpg",
      "shortDescription": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров.",
      "description": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 110.0,
      "characteristics": []
    },
    {
      "id": 8,
      "sectionId": 1,
      "categoryId": 2,
      "farmerId": 3,
      "title": "Свинина",
      "unit": "1кг",
      "totalRating": 2.4,
      "ratingCount": 3,
      "image": "assets/images/products/pork1.jpg",
      "shortDescription": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров.",
      "description": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 400.0,
      "characteristics": []
    },
    {
      "id": 9,
      "sectionId": 1,
      "categoryId": 2,
      "farmerId": 3,
      "title": "Сало",
      "unit": "1кг",
      "totalRating": 4.9,
      "ratingCount": 23,
      "image": "assets/images/products/pork2.jpg",
      "shortDescription": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров.",
      "description": "Наше мясо, курица и рыба поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
      "price": 350.0,
      "characteristics": []
    }
  ],
  "farmers": [
    {
      "id": 1,
      "title": "Молочный рай"
    },
    {
      "id": 2,
      "title": "Мясное королевство"
    },
    {
      "id": 3,
      "title": "Поросячье счастье"
    }
  ]
};

// ignore: non_constant_identifier_names
final TheData = jsonEncode(data);
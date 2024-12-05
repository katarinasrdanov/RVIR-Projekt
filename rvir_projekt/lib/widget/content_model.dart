class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description:
          'Pick your food from our menu which\n      will leave you wanting more!',
      image: "images/foodIcon.png",
      title: "Select from only\n the best Menu!"),
  UnboardingContent(
      description:
          'You can pay us upon delivery or\n                  Card payment!',
      image: "images/onlinePaymentIcon.png",
      title: "Easy Online Payment!"),
  UnboardingContent(
      description: 'Deliver your food at your\n                doorstep!',
      image: "images/deliveryGuyIcon.png",
      title: "Quick Delivery at Your Door!"),
];

class ContentBlock {
  final String? text;
  final String? imagePath;

  ContentBlock.text(this.text) : imagePath = null;
  ContentBlock.image(this.imagePath) : text = null;
}

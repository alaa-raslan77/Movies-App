class CategoryModel {
  String label;
  String imagePath;
  String id;

  CategoryModel(
      {required this.label, required this.imagePath, required this.id});

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
          label: "Action", imagePath: "assets/images/action.jpeg", id: "28"),
      CategoryModel(
          label: "Adventure",
          imagePath: "assets/images/Adventure.jpeg",
          id: "12"),
      CategoryModel(
          label: "Animation",
          imagePath: "assets/images/Animation.jpeg",
          id: "16"),
      CategoryModel(
          label: "Comedy", imagePath: "assets/images/Comedy.jpeg", id: "35"),
      CategoryModel(
          label: "Crime", imagePath: "assets/images/Crime.jpeg", id: "80"),
      CategoryModel(
          label: "Documentary",
          imagePath: "assets/images/Documentary.jpeg",
          id: "99"),
      CategoryModel(
          label: "Drama", imagePath: "assets/images/Drama.jpeg", id: "18"),
      CategoryModel(
          label: "Family", imagePath: "assets/images/Family.jpeg", id: "10751"),
      CategoryModel(
          label: "Fantasy", imagePath: "assets/images/Fantasy.jpeg", id: "14"),
      CategoryModel(
          label: "History", imagePath: "assets/images/History.jpeg", id: "36"),
      CategoryModel(
          label: "Horror", imagePath: "assets/images/Horror.jpeg", id: "27"),
      CategoryModel(
          label: "Music", imagePath: "assets/images/Music.jpeg", id: "10402"),
      CategoryModel(
          label: "Mystery",
          imagePath: "assets/images/Mystery.jpeg",
          id: "9648"),
      CategoryModel(
          label: "Romance",
          imagePath: "assets/images/Romance.jpg",
          id: "10749"),
      CategoryModel(
          label: "Science Fiction",
          imagePath: "assets/images/Science Fiction.jpeg",
          id: "878"),
      CategoryModel(
          label: "TV Movie",
          imagePath: "assets/images/TV Movie.jpeg",
          id: "10770"),
      CategoryModel(
          label: "Thriller",
          imagePath: "assets/images/Thriller.jpeg",
          id: "53"),
      CategoryModel(
          label: "War", imagePath: "assets/images/War.jpeg", id: "10752"),
      CategoryModel(
          label: "Western", imagePath: "assets/images/Western.jpeg", id: "37"),
    ];
  }
}

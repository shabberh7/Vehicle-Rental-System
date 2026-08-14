package collage;

public final class VehicleImageUtil {

    private VehicleImageUtil() {}

    public static String getImage(String carName) {
        if (carName == null || carName.trim().isEmpty()) {
            return "images/cars/bugatti.jpg";
        }

        String name = carName.toLowerCase().trim();

        if (name.contains("aventador")) return "images/cars/aventador.jpg";
        if (name.contains("bugatti")) return "images/cars/bugatti.jpg";
        if (name.contains("ferrari")) return "images/cars/ferrari.jpg";
        if (name.contains("lamborghini")) return "images/cars/lamborghini.jpg";
        if (name.contains("aston martin") || name.contains("astonmartin")) return "images/cars/astonmartin.jpg";
        if (name.contains("audi")) return "images/cars/audir8.jpg";
        if (name.contains("bmw")) return "images/cars/bmwm8.jpg";
        if (name.contains("bentley")) return "images/cars/bentley.jpg";
        if (name.contains("rolls royce") || name.contains("rolls-royce") || name.contains("rollsroyce")) return "images/cars/rollsroyce.jpg";
        if (name.contains("range rover") || name.contains("rangerover")) return "images/cars/range-rover.jpg";
        if (name.contains("porsche")) return "images/cars/porsche.jpg";
        if (name.contains("mclaren 720") || name.contains("720s")) return "images/cars/mclaren.jpg";
        if (name.contains("mclaren 765") || name.contains("765lt")) return "images/cars/mclaren2.jpg";
        if (name.contains("mclaren")) return "images/cars/mclaren_1.jpg";

        return "images/cars/bugatti.jpg";
    }
}

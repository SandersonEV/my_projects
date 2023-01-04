public class App {
    
    // Java will execute and show everything inside of main method brackets every time you run the code
    public static void main(String[] args) throws Exception {
        System.out.println("Loja de Sapatos d"); // comments

        int id = 1;
        int quantity = 9;
        double shoeSize = 9.5;
        double price = 55.60;
        String shoeName = "Nike Shox"; // NonPrimitive types starts with a capital letter
        boolean vitrine = true;
        char sex = 'M';
        double total = quantity * price;

        System.out.println(quantity + " unidades a " + price + " reais -> Total: " + total);

        int lenghtShoeName = shoeName.length(); // As the variable shoeName has a Data Type NonPrimitive (String) we can use methods with this variable

        newOrder(1, "All Star", 6);
    }

    // You can also create a new method - This will only execute if we call the method
    // 'Void' means that this method do not return any value
    // The 'private' in the beggining means that this method can't be called from out of this file
    private static void newOrder(int identificação, String nome, int quantidade){
        System.out.println("burrrrpppppp!!");
    }

    private static String feedback(){
        return "Produto criado com sucesso.";
    }
}

public class Drop {
    private String message;
    Object o = new Object();

    private boolean empty = true;

    public synchronized String take() {
        // Como está vazio, ele vai esperar até não ficar
        while (empty) {
            try {
                // Força a thread atual a esperar até outra thread chamar via notify
                wait();
            } catch (InterruptedException e) {
            }
        }
        // Quando deixa de estar vazio, ele retorna a string atual do buffer, e avisa pro put/Produtor que pode meter mais strings
        empty = true;
        System.out.println("Print do take");
        notifyAll();
        return message;
    }

    public synchronized void put(String message) {
        // Está "cheio" pq, em tese, o buffer teria tamanho 1
        while (!empty) {
            try {
                wait();
            } catch (InterruptedException e) {

            }
        }
        empty = false;
        this.message = message;
        System.out.println("Print do put");
        notifyAll();
    }
}
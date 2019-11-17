import java.util.Random;

public class Consumidor implements Runnable {
    private Drop drop;
    private Random random = new Random();

    public Consumidor(Drop d) {
        this.drop = d;
    }

    public void run() {
        for (String message = this.drop.take(); !message.equals("Fim"); message = this.drop.take()) {
            System.out.format("Mensagem recebida: %s%n", message);
            try {
                Thread.sleep(random.nextInt(500));
            } catch (InterruptedException e) {
            }
        }
        System.out.println("Mensagens Lidas");
    }
}
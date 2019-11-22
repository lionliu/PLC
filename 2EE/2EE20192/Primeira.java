import java.util.concurrent.atomic.AtomicInteger;

public class ProdutorConsumidor {

    Produtor p;
    Consumidor c;
    AtomicInteger ai;

    public ProdutorConsumidor(int n) {
        this.ai = new AtomicInteger(n);
        this.p = new Produtor(this.ai);
        this.c = new Consumidor(this.ai);
    }

}

class Consumidor implements Runnable {

    AtomicInteger ai;

    public Consumidor(AtomicInteger ai) {
        this.ai = ai;
    }

    public void run() {
        while (true) {

            try {
                // Dar um tempo para consumir
                Thread.sleep(10000);
            } catch (Exception e) {}
            System.out.println("Consumindo");
            this.ai.getAndDecrement();
        }
    }
}

class Produtor implements Runnable {

    AtomicInteger ai;

    public Produtor(AtomicInteger ai) {
        this.ai = ai;
    }

    public void run() {
        while (true) {

            try {
                // Dar um tempo para produzir
                Thread.sleep(4000);
            } catch (Exception e) {}
            System.out.println("Produzindo");
            System.out.println(this.ai.get());
            this.ai.getAndIncrement();
        }
    }
}
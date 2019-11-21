import java.util.concurrent.atomic.AtomicInteger;


public class Segunda {
    public static void main(String[] args) {
        AtomicInteger ai = new AtomicInteger(0);
    }
}

class Produtor implements Runnable {
    private AtomicInteger contagem;

    public Produtor(AtomicInteger n) {
        this.contagem = n;
    }

    public void run() {
        while(true) {
            this.contagem.incrementAndGet();
            Thread.sleep(2000);
            System.out.println(this.contagem.get());
        }
        
    }
}

class Consumidor implements Runnable {

    private AtomicInteger contagem;

    public Consumidor(AtomicInteger n) {
        this.contagem = n;
    }

    public void run() {
        while(true) {
            this.contagem.decrementAndGet();
            Thread.sleep(10000);
        }
    }
}
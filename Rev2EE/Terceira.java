import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class Terceira {
    public static void main(String[] args) {
        Padaria mutti = new Padaria();
        Thread t1 = new Thread(mutti.produtor);
        Thread t2 = new Thread(mutti.consumidor);
        t1.start();
        t2.start();
    }
}

class Paes10 {
}

class Producer implements Runnable {

    public Padaria padaria;

    public Producer(Padaria p) {
        this.padaria = p;
    }

    public void run() {
        while(true) {
            synchronized(this.padaria.forno) {
                while(!this.padaria.forno.isEmpty()) {
                    try {
                        System.out.println("Produtor: Forno nao esta vazio");
                        this.padaria.forno.wait();
                    } catch(Exception e) {}
                }
            }

            System.out.println("Produtor: Forno esta vazio");

            for(int i = 0; i < 5; i++) {
                try {
                    Thread.sleep(this.padaria.tempoColocar);

                    padaria.forno.put(new Paes10());

                    synchronized (this.padaria.forno) {
                        System.out.println("Forno esta com " + (this.padaria.forno.size() * 10) + " paes.");
                        this.padaria.forno.notify();
                    }
                } catch(Exception e) {}
                
                           
            }            
        }
    }
}

class Consumer implements Runnable {

    public Padaria padaria;

    public Consumer(Padaria p) {
        this.padaria = p;
    }

    public void run() {
        while(true) {
            synchronized(this.padaria.forno) {
                while(this.padaria.forno.isEmpty()) {
                    try {
                        System.out.println("Consumidor: forno esta vazio");
                        this.padaria.forno.wait();
                    } catch(Exception e) {}
                }
            }
            System.out.println("Consumidor: forno nao esta vazio");
            try {
                Thread.sleep(this.padaria.tempoAssar);

                this.padaria.forno.take();

                synchronized (this.padaria.forno) {
                    System.out.println("10 paes prontos.");
                    this.padaria.forno.notify();
                }
            } catch(Exception e) {}
            
            
        }
    }
}

class Padaria {
    public int tempoAssar = 2000;
    public int tempoColocar = 500;

    public BlockingQueue<Paes10> forno;

    public Consumer consumidor;
    public Producer produtor;

    public Padaria() {
        this.forno = new ArrayBlockingQueue<Paes10>(5);
        this.produtor = new Producer(this);
        this.consumidor = new Consumer(this);
    }
}


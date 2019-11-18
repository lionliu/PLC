

public class Quarta {
    public static void main(String[] args) {
        
    }
}

class Semaforo {
    private int count;

    public Semaforo(int start) {
        this.count = start;
    }

    public synchronized void up() {
        this.count++;
        notifyAll();
    }

    public synchronized void down() {
        while(count <= 0) {
            try {
                wait();
            } catch(Exception e) {}
        }
        count--;
    }
}
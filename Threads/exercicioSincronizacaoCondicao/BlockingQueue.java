

public class BlockingQueue implements Runnable {
    
    public int capacidadeMaxima;
    public int indexPut;
    public int indexTake;
    public int qt;
    public int[] fila;

    public BlockingQueue(int n) {
        this.capacidade = n;
        this.fila = new int[n];
        this.indexTake = 0;
        this.indexPut = 0;
        this.qt = 0;
    }

    public synchronized int take() {
        while(this.qt == 0) {
            try {
                wait();
            } catch(Exception e) {}
            
        }
        int retorno = this.fila[this.indexTake++ % this.capacidadeMaxima];
        this.qt--;
        notifyAll();
        return retorno;
    }

    public synchronized void put(int n) {
        while(this.qt == (this.capacidadeMaxima - 1)) {
            try {
                wait();
            } catch(Exception e) {}
        }
        this.fila[this.indexPut++ % this.capacidadeMaxima] = n;
        this.qt++;
        notifyAll();
    }
}
public class BlockingQueue {

    private int indexPut;
    private int tamFila;
    private int indexTake;
    private int qtItens;
    public int[] fila;



    public BlockingQueue(int qt) {
        this.indexPut = 0;
        this.tamFila = qt;
        this.indexTake = 0;
        this.qtItens = 0;
        this.fila = new int[qt];
    }

    public synchronized void put(int n) {
        try {
            // Se a fila estiver cheia espera ficar livre.
            while(this.qtItens == this.tamFila) {
                wait();
            }
            this.qtItens++;
            this.fila[this.indexPut++ % this.tamFila] = n;
            notifyAll();
        } catch(Exception e) {}

        // this.t[this.indexPut++ % this.qtFila] = n;
    }

    public synchronized int get() {
        int retorno = 0;
        try {
            while(this.qtItens == 0) {
                wait();
            }
            this.qtItens--;
            retorno = this.fila[this.indexTake % this.tamFila];
            this.fila[this.indexTake++ % this.tamFila] = 0; // Limpa a casa retirada
            notifyAll();

        } catch (Exception e) {}
        return retorno;
    }
}

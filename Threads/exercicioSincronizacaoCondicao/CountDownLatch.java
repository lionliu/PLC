public class CountDownLatch {

    private int n;

    public CountDownLatch(int n) {
        this.n = n;
    }

    public synchronized void countDown() {
        if (this.n > 0) {
            System.out.println(n);
            this.n--;
        } else {
            notifyAll();
        }
    }

    public synchronized void await() {
        while(this.n != 0) {
            try {
                wait();
            } catch(InterruptedException e) {
            }
        }
        System.out.println("Sai do await");
    }
}
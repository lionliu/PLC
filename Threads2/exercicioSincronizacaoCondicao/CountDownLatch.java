public class CountDownLatch {

    private int n;

    public CountDownLatch(int n) {
        this.n = n;
    }

    public void countDown() {
        if (this.n > 0) {
            this.n--;
            System.out.println(n);
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
    }
}
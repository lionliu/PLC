public class CountDownLatch {

    private int n;

    public CountDownLatch(int n) {
        this.n = n;
    }

    public void countDown() {
        if (this.n > 0) {
            this.n--;
        } else if (this.n == 0) {

        }
    }

    public void await() {

    }

    // public void run() {

    // }
}
import java.time.Duration;
import java.util.Random;
import java.util.Arrays;
import java.util.List;
import java.util.Collections;

public class TimeSplit {
    public int[] splitInterval() {
        Random rng = new Random();
 
        int numSplits = rng.nextInt(3) + 3;
        int[] splitDurations = new int[numSplits];
        int duration = rng.nextInt(6) * 60000 + (5 * 60000);

        int sum = 0;
  
        for (int i = 0; i < numSplits; i++) {
            int num;
            if (i == numSplits - 1) {
                // Generate the last number so that the sum adds up to k
                num = duration - sum;
            } else {
                num = rng.nextInt(duration - sum) + 1; // Generate a random number between 1 and k - sum (inclusive)
                sum += num;
            }
            splitDurations[i] = (int) num;
        }

        return splitDurations;
    }

    public int[] assignNumbers(int[] array) {
        int n = array.length; // Number of elements

        // Create an array of integers from 1 to n
        int[] numbers = new int[n];
        for (int i = 0; i < n; i++) {
            numbers[i] = i + 1;
        }


        // Shuffle the array
        return shuffleArray(numbers);
    }
    
    public int[] shuffleArray(int[] array) {
        Random random = new Random();
        
        for (int i = array.length - 1; i > 0; i--) {
          int j = random.nextInt(i + 1);
          int temp = array[i];
          array[i] = array[j];
          array[j] = temp;
        }
        
        return array;
    }
}

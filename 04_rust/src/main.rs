const ARRAY_SIZE: usize = 16;

extern {
    fn quicksort(array: *mut u64, size: usize);
}

fn fill_random(slice: &mut [u64], max: u64) {
    for i in 0..slice.len() {
        slice[i] = rand::random::<u64>() % max + 1;
    }
}

fn main() {
    let mut array = vec![0u64; ARRAY_SIZE];
    fill_random(&mut array, 16);
    println!("before: {:?}", array);

    unsafe {
        quicksort((&mut array).as_mut_ptr(), array.len());
    }
    println!("after:  {:?}", array);
}

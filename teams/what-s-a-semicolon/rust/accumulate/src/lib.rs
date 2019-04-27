pub fn map<F, T, U>(input: Vec<T>, mut fun: F) -> Vec<U>
where
    F: FnMut(T) -> U,
{
    let mut output: Vec<U> = vec![];
    for i in input {
        output.push(fun(i));
    }
    return output;
}

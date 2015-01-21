import System.Random

type Segment = (Int, Int)

-- входные данные (массив пар координат отрезков)
input :: [Segment]
input = [(1,6),(5,6),(2,3),(5,6),(4,6),(1,2),(3,4),(1,5),(1,2),(2,5)]

-- количество циклов генерации решения
genCnt = 10000

-- селекторы для конструкции (Segment, Idx)
getIdx = snd 
getXL = fst . fst
getXR = snd . fst

-- заполнение одной линии
oneLine []  acc = return $ reverse acc
oneLine lst acc = do  
    el <- getRndElem lst
    oneLine 
        (filter (skip el) lst)
        (el : acc)    
        
-- выбор случайного элемента из списка
getRndElem lst = do 
    r <- randomRIO (0, length lst - 1)
    return $ lst !! r 

-- предикат для "просеивания" элементов списка   
skip skipEl el = 
    getIdx el /= getIdx skipEl && 
    (   getXR el <= getXL skipEl || 
        getXL el >= getXR skipEl  )

-- формирование одного вариант решения         
oneCase []  acc = return $ reverse acc      
oneCase lst acc = do 
    line <- oneLine lst []
    let idxs = map getIdx line
    let left = filter (\x -> notElem (getIdx x) idxs) lst
    oneCase left (line : acc)

-- основная функция эвристического алгоритма     
solve []  best _ = return best
solve lst best 0 = return best        
solve lst best n = do
    sol <- oneCase lst []
    if length sol  < length best then solve lst sol (n - 1)
    else solve lst best (n - 1)
      
-- стартовая функция программы      
main = do 
    let idxs_input = zip input [0..]
    let bad_solution = map (\x -> [x]) idxs_input
    l <- solve idxs_input bad_solution genCnt
    putStrLn $ "Solution's length = "
                ++ show (length l)
                ++ "\n" 
                ++ show l

    
# Grep Guide
Use grep to extract out only the results that contains “L337”, “Honda” and “Blue”:

```bash
$ cat vehicles.txt | grep -A 5 L337 | grep -A 4  -B 1 Honda | grep -A 3 -B 2 Blue
```

## With awk

`RS=` stands for paragraph mode, `ORS` sets the output paragraph to be separated by 2 lines, and there is three regex matching three conditions.
```bash
$ awk -v RS= -v ORS="\n\n" '/L337/ && /Blue/ && /Honda/'  vehicles.txt
```

   Output:

   ```
License Plate L337QE9
Make: Honda
Color: Blue
Owner: Erika Owens
Height: 6'5"
Weight: 220 lbs

License Plate L337539
Make: Honda
Color: Blue
Owner: Aron Pilhofer
Height: 5'3"
Weight: 198 lbs

License Plate L337369
Make: Honda
Color: Blue
Owner: Heather Billings
Height: 5'2"
Weight: 244 lbs

License Plate L337DV9
Make: Honda
Color: Blue
Owner: Joe Germuska
Height: 6'2"
Weight: 164 lbs

License Plate L3375A9
Make: Honda
Color: Blue
Owner: Jeremy Bowers
Height: 6'1"
Weight: 204 lbs

License Plate L337WR9
Make: Honda
Color: Blue
Owner: Jacqui Maher
Height: 6'2"
Weight: 130 lbs
   ```


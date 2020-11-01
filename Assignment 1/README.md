# Estimation of the expected value

### Loading data:
```
>> load data1
```

### Plotting the sequence of 100 measurements:
```
>> plot(data1.x)
```
![1](https://user-images.githubusercontent.com/64482881/97801254-8f6f0d00-1c3b-11eb-84cc-4ab793924cc0.jpeg)


### Time average 
```
>> 𝑚̂ = mean(data1.x)
```
## Result:

We got : 𝑚̂ = 0.20388, and by definition the white noise is a zero mean process, then:
  * 𝑚̂ ≠ 0 : Hence, the process has no zero mean, i.e. it is not a white noise process.
  
### Remark:
We can convert it to a white noise process by subtracting this time average from each component of the original vector data1.x
```
>> new_data = data1.x - 𝑚̂
```

Then the expected value of the mean is:
```
>> 𝑚̂' = mean(new_data)
```
Hence, this new process is a white noise process, since it has the same variance as the previous one and it is at the same time a zero mean, i.e. m̂ ′=0.

![2](https://user-images.githubusercontent.com/64482881/97801310-0ad0be80-1c3c-11eb-95ee-b85bb59bfdd7.png)
```
>> sd = std(data.x)
```
![3](https://user-images.githubusercontent.com/64482881/97801320-2fc53180-1c3c-11eb-87b7-fe86c02a53a7.png)

```
>> t = tinv(1-alpha/2, n-1);
```
![4](https://user-images.githubusercontent.com/64482881/97801330-49ff0f80-1c3c-11eb-95f9-1536d8495ff7.png)

![5](https://user-images.githubusercontent.com/64482881/97801369-89c5f700-1c3c-11eb-9df8-0a85d920a9fb.png)

# Estimation of the covariance function

### Loading the data:

```
>> load covProc
```
### Plotting the sequence of 100 measurements:

```
>> t = tiledlayout(1,3);
>> for k=1:3
>>     nexttile;
>>     plot(covProc(1:end-k),covProc(k+1:end),'.');
>>     xlabel(['y(t-' num2str(k) ')']);
>>     ylabel('y(t)');
>>     title(['ρ(t-' num2str(k) ', t)']);
>> end
>> width=700;
>> height=200;
>> set(gcf,'position',[300,300,width,height])
```
![6](https://user-images.githubusercontent.com/64482881/97801427-ea553400-1c3c-11eb-9f5a-04913188a318.jpeg)

![7](https://user-images.githubusercontent.com/64482881/97801463-3607dd80-1c3d-11eb-98f2-c0204ad784fa.png)
![8](https://user-images.githubusercontent.com/64482881/97801472-3e601880-1c3d-11eb-99dc-e61f9d99e78f.jpeg)
![9](https://user-images.githubusercontent.com/64482881/97801473-3f914580-1c3d-11eb-981c-3d3cedf72c04.png)
![10](https://user-images.githubusercontent.com/64482881/97801474-415b0900-1c3d-11eb-922a-c1e77a26a7d9.jpeg)
![11](https://user-images.githubusercontent.com/64482881/97801475-428c3600-1c3d-11eb-9f3f-b447c8b5faca.png)



















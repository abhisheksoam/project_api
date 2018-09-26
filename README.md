## Project Specifications 

Built using Django Framework (1.11.15)

## Get it running

**Step 1:**

Clone this repository:
```terminal
git clone https://github.com/abhisheksoam/project_api.git
```

**Step 2:**

> Ensure you that you have docker installed and running in your system before proceeding with next steps. A quick test
> to see if docker is installed correctly is to execute the command `docker run hello-world` and it should run without
> errors.
Build the docker Image.
Make sure you have docker installed for the next step. 

```terminal
docker-compose build
```

**Step 3:**

Final Step
```terminal
docker-compose up
```


**Step 4:**

Check everything is working as expected

Head to browser for accesing API
```terminal
http://localhost:8080/one
```

It should return success response


```terminal
{
    key: "one",
    value: "1",

    response: {
        status: true,
        msg: "Success"
    }
}
```



**Step 5: Test API** 



Running Collection json 
```terminal
docker pull postman/newman_ubuntu1404

docker run --net=host  -v $PWD/collections/:/etc/newman -t postman/newman_ubuntu1404 run "APITesting.postman_collection.json"
```

You can definitely create your own tests for testing purpose.

That's it! Done :) 

If you find something wrong, drop a message!



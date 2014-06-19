# EntityLoaders

Explicitly load related entities using navigation properties.

Download using NuGet: [EntityLoaders](http://www.nuget.org/packages/EntityLoaders/)

## Overview
If you use Entity Framework and you find yourself torn between the benefits of using eager loading and lazy loading, this project may be what you're looking for. *EntityLoaders* provides all of the benefits of using lazy-loading without needing to bog your codebase down with proxy objects, excessive database hits and mile-long `Include` chains.

Assume you have a customer with multiple orders. Once you have access to the customer entity, you can load its orders using *EntityLoaders*:

    using EntityLoaders;
    
    ...
    
    context.GetLoader(customer).Load(c => c.Orders);
    foreach (Order order in customer.Orders)
    {
    }
    
In this example, `context` is your `DbContext` instance. The `GetLoader` extension method will create a loader for the customer and the `Load` method will build a query to grab and load the orders.

You can grab the orders related to multiple customers at once by passing a list of customers to the `GetLoader` method:

    context.GetLoader(customer1, customer2).Load(c => c.Orders);
    context.GetLoader(new Customer[] { customer1, customer 2 }).Load(c => c.Orders);
    context.GetLoader(customers).Load(c => c.Orders);
    
If you need to filter, group or perform additional `Include`s when loading related entities, you can use the `LoadQuery` methods:

    using System.Data.Entity;
    using EntityLoaders;
    
    ...

    context.GetLoader(customer)
           .LoadQuery(c => c.Orders)
           .Where(o => o.OrderDate > new DateTime(2014, 01, 01))
           .Include(o => o.OrderItems)
           .Load();
           
`LoadQuery` will not result in a database hit until the collection is enumerated (e.g., calling `Load`, `ToList`, etc.).

## Performance
By default, *EntityLoaders* will check to see if a related entity is already loaded before hitting the database if you call `Load`. However, `LoadQuery` will perform a database hit no matter what.

In the case of large entity sets (tens of thousands of entities), checking to see if an entity is already loaded can cause performce problems. In those cases, using `LoadQuery` can actually perform better.

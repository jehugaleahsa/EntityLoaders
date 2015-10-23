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
    context.GetLoader(new Customer[] { customer1, customer2 }).Load(c => c.Orders);
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
If you use `Load`, *EntityLoaders* will check to see if a related entity is already loaded before hitting the database. However, `LoadQuery` will perform a database hit no matter what.

In the case of large entity sets (tens of thousands of entities), checking to see if an entity is already loaded can be slow. In those cases, using `LoadQuery` can actually perform better.

## License
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>

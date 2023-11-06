## Has Many Relationships
### References
- [Join Table in Rails](https://medium.com/@mahdy.a.noureddine/step-by-step-guide-on-efficiently-making-a-join-table-in-rails-426fa6b9cce2)

- [Modify Devise](https://github.com/learn-academy-2023-foxtrot/syllabus/blob/main/capstone/modifying-devise.md)

### Explanation
In Ruby on Rails, a "has_many through" relationship is a type of association that allows you to connect three models in a more complex way. Users can have many blockers and solutions. Blockers and solutions can be assigned to many users. The User and Blocker models don't have a direct association with each other; instead, they go through the Solution model.

### Process
1. Generate resources: `foreign keys for User and Blocker models will be placed on the Solution model`
2. Define the models: `has_many through relationship will be placed on User and Blocker` 
3. Create associations in the seed file: 
```rb
  # Create user seeds
  user1 = User.where(email: 'dilemma1@example.com').first_or_create(username: 'User1', password: 'password1', password_confirmation: 'password1')

  # Create blocker seeds
  blocker1 = Blocker.create(
    category: 'holiday',
    blocker_description: 'Should I bring a new dish to the holiday dinner?',
    resolved: true,
    urgent: true
  )

  # Create solution seeds
  # user1.solutions is a reference to the association between the User model and the Solution model, which represents a user's solutions. The create method is used to build and save a new Solution record with the specified attributes. `blocker: blocker1` assigns the Blocker record blocker1 to the solution, linking this solution to the 'holiday' blocker.
  solution1 = user1.solutions.create(
    blocker: blocker1,
    description: 'Holidays are valuable moments. Bring your best not your test.',
    require_followup: false,
    attempted: true,
    acceptable: true
  )
```

### routes
```rb
  # config/routes.rb
  resources :blockers do
    collection do
      get 'user_blockers'
    end
  end
```
### ChatGPT
Certainly, here are examples of the `create`, `update`, and `destroy` methods in a `BlockersController` that are restricted to actions that belong to the current user. These actions are used to create new blockers, update existing blockers, and delete blockers that are associated with the current user.

```ruby
class BlockersController < ApplicationController
  before_action :authenticate_user!, :require_login # Ensure the user is authenticated

  # Ensure that the user is logged in before performing actions
  def require_login
    unless current_user
      flash[:error] = 'You must be logged in to access this page.'
      redirect_to login_path
    end
  end
  # Display blockers and their solutions that belong to the current user
  def my_blockers
    @user = current_user
    # @user = User.find(params[:id])
    @blockers = @user.blockers.includes(:solutions) # Assuming there's a solutions association


  # Create a new blocker for the current user
  def create
    @blocker = current_user.blockers.build(blocker_params)

    if @blocker.save
      redirect_to @blocker, notice: 'Blocker was successfully created.'
    else
      render :new
    end
  end

  # Update an existing blocker owned by the current user
  def update
    @blocker = current_user.blockers.find(params[:id])

    if @blocker.update(blocker_params)
      redirect_to @blocker, notice: 'Blocker was successfully updated.'
    else
      render :edit
    end
  end

  # Delete a blocker owned by the current user
  def destroy
    @blocker = current_user.blockers.find(params[:id])
    @blocker.destroy

    redirect_to blockers_path, notice: 'Blocker was successfully destroyed.'
  end

  # ...

  private

  def blocker_params
    params.require(:blocker).permit(:title, :description)
  end
end
```

In these examples:

1. The `create` method allows the current user to create a new blocker associated with their account. It uses `current_user` to build the blocker and associates it with the user. After successful creation, the user is redirected to the blocker's show page. If there are validation errors, the user is shown the new blocker form.

2. The `update` method allows the current user to edit and update their own blockers. It retrieves the blocker based on the user's association and the provided blocker `id`. After successful update, the user is redirected to the blocker's show page. If there are validation errors, the user is shown the edit blocker form.

3. The `destroy` method enables the current user to delete their own blockers. It first finds the blocker based on the user's association and the provided blocker `id`. After successfully deleting the blocker, the user is redirected to the blockers' index page.

Make sure to configure your routes and views accordingly, and ensure that the user is authenticated and authorized to perform these actions.

### react
Certainly, you can structure the `fetch` request in the format you provided. Here's how you can use this structure to make a `fetch` request to your Rails API endpoint:

```javascript
import React, { useState, useEffect } from 'react';

function BlockersAndSolutions() {
  const [blockers, setBlockers] = useState([]);
  const [solutions, setSolutions] = useState([]);

  useEffect(() => {
    // Fetch data when the component mounts
    const userId = 1; // Replace with the actual current user's ID
    const apiUrl = `/api/blockers-and-solutions?user_id=${userId}`;

    fetch(apiUrl)
      .then((response) => response.json())
      .then((data) => {
        setBlockers(data.blockers);
        setSolutions(data.solutions);
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }, []);

  return (
    <div>
      <h2>Blockers</h2>
      <ul>
        {blockers.map((blocker) => (
          <li key={blocker.id}>{blocker.description}</li>
        ))}
      </ul>

      <h2>Solutions</h2>
      <ul>
        {solutions.map((solution) => (
          <li key={solution.id}>{solution.description}</li>
        ))}
      </ul>
    </div>
  );
}

export default BlockersAndSolutions;
```

In this code, the `fetch` request follows the structure you provided:

1. The initial `fetch` request is made to the `apiUrl`.

2. The first `.then()` handles the response by converting it to JSON.

3. The second `.then()` processes the JSON data and updates the component's state with the retrieved data.

4. The `.catch()` method is used to handle errors in case the request fails.

This structure ensures that you make the API request and handle the response and errors as intended while displaying the retrieved data in your React component.


class Api::BlockersAndSolutionsController < ApplicationController
  def index
    user_id = params[:user_id] # Retrieve the user ID from the request
    blockers = Blocker.where(user_id: user_id)
    solutions = Solution.where(user_id: user_id)

    render json: { blockers: blockers, solutions: solutions }
  end
end

Certainly, here are the controller action methods you can use in your Rails `BlockersController` to handle the CRUD (Create, Read, Update, Delete) operations for both blockers and solutions. These actions correspond to the React components for creating, updating, and deleting blockers and solutions.

```ruby
class BlockersController < ApplicationController
  before_action :authenticate_user! # Ensure the user is authenticated

  # Create a new blocker
  def create
    @blocker = current_user.blockers.build(blocker_params)

    if @blocker.save
      render json: @blocker, status: :created
    else
      render json: @blocker.errors, status: :unprocessable_entity
    end
  end

  # Update an existing blocker
  def update
    @blocker = current_user.blockers.find(params[:id])

    if @blocker.update(blocker_params)
      render json: @blocker
    else
      render json: @blocker.errors, status: :unprocessable_entity
    end
  end

  # Delete a blocker
  def destroy
    @blocker = current_user.blockers.find(params[:id])
    @blocker.destroy

    head :no_content
  end

  # Create a new solution for a blocker
  def create_solution
    @blocker = current_user.blockers.find(params[:blocker_id])
    @solution = @blocker.solutions.build(solution_params)

    if @solution.save
      render json: @solution, status: :created
    else
      render json: @solution.errors, status: :unprocessable_entity
    end
  end

  # Update an existing solution
  def update_solution
    @solution = current_user.solutions.find(params[:id])

    if @solution.update(solution_params)
      render json: @solution
    else
      render json: @solution.errors, status: :unprocessable_entity
    end
  end

  # Delete a solution
  def destroy_solution
    @solution = current_user.solutions.find(params[:id])
    @solution.destroy

    head :no_content
  end

  # ...

  private

  def blocker_params
    params.require(:blocker).permit(:title, :description)
  end

  def solution_params
    params.require(:solution).permit(:description)
  end
end
```

In this example, we have added controller actions for creating, updating, and deleting blockers and solutions, taking into account that solutions are associated with blockers.

- `create`: Creates a new blocker associated with the current user.
- `update`: Updates an existing blocker owned by the current user.
- `destroy`: Deletes a blocker owned by the current user.
- `create_solution`: Creates a new solution associated with a blocker owned by the current user.
- `update_solution`: Updates an existing solution owned by the current user.
- `destroy_solution`: Deletes a solution owned by the current user.

Make sure to configure your routes accordingly to map these controller actions, and handle any additional logic or authentication checks that your application may require.

To implement update, create, and delete functionality for blockers and solutions in your React application, you need to create appropriate components and make corresponding HTTP requests to your Rails API endpoints. Below are examples of how you can structure these components in your React application and perform these operations.

Assuming you have separate components for creating, updating, and deleting blockers and solutions, here's a basic structure of how you might organize these components:

1. **CreateBlocker Component (Create Blocker)**

   This component allows the user to create a new blocker:

   ```jsx
   import React, { useState } from 'react';

   function CreateBlocker() {
     const [title, setTitle] = useState('');
     const [description, setDescription] = useState('');

     const handleSubmit = (e) => {
       e.preventDefault();
       fetch('/api/blockers', {
         method: 'POST',
         headers: {
           'Content-Type': 'application/json',
         },
         body: JSON.stringify({ title, description }),
       })
         .then((response) => response.json())
         .then(() => {
           // Redirect or update the UI as needed
         });
     };

     return (
       <div>
         <h2>Create a New Blocker</h2>
         <form onSubmit={handleSubmit}>
           <input
             type="text"
             placeholder="Title"
             value={title}
             onChange={(e) => setTitle(e.target.value)}
           />
           <textarea
             placeholder="Description"
             value={description}
             onChange={(e) => setDescription(e.target.value)}
           />
           <button type="submit">Create Blocker</button>
         </form>
       </div>
     );
   }

   export default CreateBlocker;
   ```

2. **UpdateBlocker Component (Update Blocker)**

   This component allows the user to update an existing blocker:

   ```jsx
   import React, { useState, useEffect } from 'react';

   function UpdateBlocker({ blockerId }) {
     const [title, setTitle] = useState('');
     const [description, setDescription] = useState('');

     useEffect(() => {
       fetch(`/api/blockers/${blockerId}`)
         .then((response) => response.json())
         .then((data) => {
           setTitle(data.title);
           setDescription(data.description);
         });
     }, [blockerId]);

     const handleSubmit = (e) => {
       e.preventDefault();
       fetch(`/api/blockers/${blockerId}`, {
         method: 'PUT',
         headers: {
           'Content-Type': 'application/json',
         },
         body: JSON.stringify({ title, description }),
       })
         .then((response) => response.json())
         .then(() => {
           // Redirect or update the UI as needed
         });
     };

     return (
       <div>
         <h2>Edit Blocker</h2>
         <form onSubmit={handleSubmit}>
           <input
             type="text"
             placeholder="Title"
             value={title}
             onChange={(e) => setTitle(e.target.value)}
           />
           <textarea
             placeholder="Description"
             value={description}
             onChange={(e) => setDescription(e.target.value)}
           />
           <button type="submit">Update Blocker</button>
         </form>
       </div>
     );
   }

   export default UpdateBlocker;
   ```

3. **DeleteBlocker Component (Delete Blocker)**

   This component allows the user to delete a blocker:

   ```jsx
   import React from 'react';

   function DeleteBlocker({ blockerId }) {
     const handleDelete = () => {
       if (window.confirm('Are you sure you want to delete this blocker?')) {
         fetch(`/api/blockers/${blockerId}`, {
           method: 'DELETE',
         })
           .then(() => {
             // Redirect or update the UI as needed
           });
       }
     };

     return (
       <div>
         <h2>Delete Blocker</h2>
         <button onClick={handleDelete}>Delete Blocker</button>
       </div>
     );
   }

   export default DeleteBlocker;
   ```

These components can be used in your React application to provide Create, Update, and Delete (CRUD) functionality for blockers. Make sure to replace the API endpoints (`/api/blockers/{id}`) with the actual URLs for your Rails API, and handle error states and redirection as needed in a production application.
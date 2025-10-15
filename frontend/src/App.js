import React, { useEffect, useRef, useState } from 'react';
import { Toaster, toast } from 'react-hot-toast';
import AddRestaurantModal from './components/AddRestaurantModal';
import axios from 'axios';

function App() {
  const [restaurants, setRestaurants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const [isModalOpen, setIsModalOpen] = useState(false);
  const openBtnRef = useRef(null);

  const url = `${process.env.REACT_APP_API_URL}${process.env.REACT_APP_API_VERSION}/restaurants`;

  useEffect(() => {
    const fetchRestaurants = async () => {
      try {
        setLoading(true);
        const response = await axios.get(url);
        if (response.data.isSuccess) {
          setRestaurants(response.data.items);
          setError(null);
        } else {
          setError('Failed to load restaurants. Please try again later.');
        }
      } catch (err) {
        setError('Failed to load restaurants. Please try again later.');
      } finally {
        setLoading(false);
      }
    };
    fetchRestaurants();
    // eslint-disable-next-line
  }, [url]);

  const handleOpen = () => setIsModalOpen(true);
  const handleClose = () => {
    setIsModalOpen(false);
    openBtnRef.current?.focus();
  };

  const handleCreateRestaurant = async (payload) => {
    
    const creation = new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve(payload);
      }, 500);
    });

    await toast.promise(
      creation,
      {
        loading: 'Creating restaurant…',
        success: 'Restaurant created successfully!',
        error: 'Failed to create restaurant',
      }
    );

    const nextId = restaurants.length ? Math.max(...restaurants.map(r => r.id)) + 1 : 1;
    const newRestaurant = { id: nextId.toString(), ...payload };
    setRestaurants(prev => [...prev, newRestaurant]); 
    handleClose();
  };

  if (loading) {
    return (
      <div className="loading-container">
        <div className="loading-content">
          <div className="spinner"></div>
          <p>Loading restaurants...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="error-container">
        <div className="error-content">
          <div className="error-icon">⚠️</div>
          <h2>Oops!</h2>
          <p>{error}</p>
          <button onClick={() => window.location.reload()}>Try Again</button>
        </div>
      </div>
    );
  }

  return (
    <div className="app-container">
      <div className="content-wrapper">
        <div className="header-row">
          <h1 className="app-title">Top Restaurants</h1>
          <button
            className="add-btn"
            onClick={handleOpen}
            ref={openBtnRef}
            aria-haspopup="dialog"
          >
            + Add Restaurant
          </button>
        </div>

        <div className="restaurant-card">
          <ul className="restaurant-list">
            {restaurants.map((restaurant) => (
              <li key={restaurant.id} className="restaurant-item">
                <div className="restaurant-name">
                  <h2>{restaurant.name}</h2>
                </div>
                <div className="restaurant-rating">
                  <span className="star-icon">⭐</span>
                  <span className="rating-value">{restaurant.rating}</span>
                </div>
              </li>
            ))}
          </ul>
        </div>

        <p className="restaurant-count">
          Showing {restaurants.length} restaurants
        </p>
      </div>

      <AddRestaurantModal
        open={isModalOpen}
        onClose={handleClose}
        onCreate={handleCreateRestaurant}
      />

      <Toaster position="top-right" /> 
    </div>
  );
}

export default App;

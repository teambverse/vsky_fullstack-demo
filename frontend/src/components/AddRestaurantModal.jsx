import React, { useEffect, useRef, useState, useMemo } from "react";
import CountryCodePicker from "../utils/CountryCodePicker";
import { toast } from "react-hot-toast";
import axios from "axios";

const AddRestaurantModal = ({ open, onClose, onCreate }) => {
  const firstFieldRef = useRef(null);

  const [form, setForm] = useState({
    name: "",
    address: "",
    rating: "",
  });

  const [phone, setPhone] = useState("");
  const [countryCode, setCountryCode] = useState("+1");
  const [isoCode, setISOCode] = useState("US");

  const [errors, setErrors] = useState({});
  const [submitting, setSubmitting] = useState(false);
  const [showToast, setShowToast] = useState(false);
  const [hoverRating, setHoverRating] = useState(0);

  useEffect(() => {
    if (open) {
      // reset form each open
      setForm({ name: "", address: "", rating: "" });
      setPhone("");
      setCountryCode("+1");
      setISOCode("US");
      setErrors({});
      setSubmitting(false);
      setShowToast(false);
      setHoverRating(0);
      setTimeout(() => firstFieldRef.current?.focus(), 0);
    }
  }, [open]);

  useEffect(() => {
    const onKeyDown = (e) => {
      if (e.key === "Escape") {
        e.preventDefault();
        onClose();
      }
    };
    if (open) document.addEventListener("keydown", onKeyDown);
    return () => document.removeEventListener("keydown", onKeyDown);
  }, [open, onClose]);

  const onChange = (e) => {
    const { name, value } = e.target;

    const MAX_NAME = 100;
    const MAX_ADDRESS = 300;

    if (name === "name" && value.length > MAX_NAME) return;
    if (name === "address" && value.length > MAX_ADDRESS) return;

    setForm((prev) => ({ ...prev, [name]: value }));
    setErrors((prev) => ({ ...prev, [name]: "" }));
  };

  const validate = () => {
    const errs = {};
    if (!form.name.trim()) errs.name = "Name is required";
    if (!form.address.trim()) errs.address = "Address is required";

    const digits = (phone.match(/\d/g) || []).length;
    if (!phone) errs.phone = "Phone is required";
    else if (digits < 7) errs.phone = "Phone seems too short";

    const ratingNum = Number(form.rating);
    if (form.rating === "") errs.rating = "Rating is required";
    else if (Number.isNaN(ratingNum)) errs.rating = "Rating must be a number";
    else if (ratingNum < 1 || ratingNum > 5)
      errs.rating = "Rating must be between 1 and 5";

    setErrors(errs);
    return Object.keys(errs).length === 0;
  };

  const isFormValid = useMemo(() => {
    if (!form.name.trim()) return false;
    if (!form.address.trim()) return false;
    const digits = (phone.match(/\d/g) || []).length;
    if (!phone || digits < 7) return false;
    const ratingNum = Number(form.rating);
    if (form.rating === "" || Number.isNaN(ratingNum)) return false;
    if (ratingNum < 1 || ratingNum > 5) return false;
    return true;
  }, [form, phone]);

  const onSubmit = async (e) => {
    e.preventDefault();
    if (!validate()) return;
    try {
      setSubmitting(true);

      const payload = {
        name: form.name.trim(),
        address: form.address.trim(),
        phone_number: phone,
        rating: form.rating.toString(),
      };

      const url = `${process.env.REACT_APP_API_URL}${process.env.REACT_APP_API_VERSION}/restaurants`;

      const response = await axios.post(url, payload);

      if (response.data.isSuccess) {
        toast.success("Restaurant created successfully!");
        await onCreate(payload);
      } else {
        toast.error("Failed to create restaurant");
      }

      setShowToast(true);
      setTimeout(() => {
        setShowToast(false);
        onClose();
      }, 1200);
    } catch (err) {
      console.error(err);
      toast.error("Error creating restaurant. Please check your input.");
    } finally {
      setSubmitting(false);
    }
  };

  if (!open) return null;

  return (
    <div
      className="modal-overlay"
      role="dialog"
      aria-modal="true"
      aria-label="Add Restaurant"
      onMouseDown={(e) => {
        if (e.target.classList.contains("modal-overlay")) onClose();
      }}
    >
      <div className="modal-content" role="document">
        <div className="modal-header">
          <h3>Add New Restaurant</h3>
          <button className="icon-btn" onClick={onClose} aria-label="Close">
            ✕
          </button>
        </div>

        <form onSubmit={onSubmit} noValidate>
          {/* Live preview card */}
          <div
            className="restaurant-card"
            style={{ marginBottom: 12 }}
            aria-hidden
          >
            <h2>Live Preview</h2>
            <div
              className="restaurant-item"
              style={{ alignItems: "flex-start" }}
            >
              <div className="restaurant-name">
                <h2 style={{ fontSize: "1rem" }}>
                  {form.name || "Restaurant name"}
                </h2>
                <div style={{ color: "#6b7280", fontSize: 13 }}>
                  {form.address || "Address will appear here"}
                </div>
              </div>
              <div style={{ textAlign: "right" }}>
                <div style={{ color: "#ea580c", fontWeight: 700 }}>
                  {form.rating ? Number(form.rating).toFixed(1) : "-"}
                </div>
                <div style={{ fontSize: 12, color: "#6b7280" }}>
                  {phone || "phone"}
                </div>
              </div>
            </div>
          </div>
          <div className="form-row">
            <label htmlFor="name">Name</label>
            <input
              id="name"
              name="name"
              type="text"
              value={form.name}
              onChange={onChange}
              ref={firstFieldRef}
              required
            />
            <div
              style={{
                display: "flex",
                justifyContent: "space-between",
                alignItems: "center",
              }}
            >
              {errors.name ? (
                <small className="error-text">{errors.name}</small>
              ) : (
                <span />
              )}
              <small style={{ color: "#6b7280" }}>{form.name.length}/100</small>
            </div>
          </div>

          <div className="form-row">
            <label htmlFor="address">Address</label>
            <input
              id="address"
              name="address"
              type="text"
              value={form.address}
              onChange={onChange}
              required
            />
            <div
              style={{
                display: "flex",
                justifyContent: "space-between",
                alignItems: "center",
              }}
            >
              {errors.address ? (
                <small className="error-text">{errors.address}</small>
              ) : (
                <span />
              )}
              <small style={{ color: "#6b7280" }}>
                {form.address.length}/300
              </small>
            </div>
          </div>

          <div className="form-row">
            <CountryCodePicker
              phone={phone}
              setPhone={setPhone}
              countryCode={countryCode}
              setCountryCode={setCountryCode}
              setISOCode={setISOCode}
              label="Phone Number"
              isRequired
            />
            {errors.phone && (
              <small className="error-text">{errors.phone}</small>
            )}
          </div>

          <div className="form-row">
            <label htmlFor="rating">Rating (1-5)</label>
            <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
              {/* clickable stars */}
              <div style={{ display: "flex", gap: 6 }}>
                {[1, 2, 3, 4, 5].map((s) => (
                  <button
                    key={s}
                    type="button"
                    aria-label={`Set rating ${s}`}
                    onMouseEnter={() => setHoverRating(s)}
                    onMouseLeave={() => setHoverRating(0)}
                    onClick={() =>
                      setForm((p) => ({ ...p, rating: String(s) }))
                    }
                    style={{
                      background: "transparent",
                      border: "none",
                      cursor: "pointer",
                      fontSize: 20,
                      color:
                        (hoverRating || Number(form.rating)) >= s
                          ? "#f59e0b"
                          : "#e5e7eb",
                      lineHeight: 1,
                      padding: 0,
                    }}
                  >
                    ★
                  </button>
                ))}
              </div>
              <input
                id="rating"
                name="rating"
                type="number"
                inputMode="decimal"
                step="0.1"
                min="1"
                max="5"
                value={form.rating}
                onChange={onChange}
                required
                style={{ width: 84 }}
              />
            </div>
            {errors.rating && (
              <small className="error-text">{errors.rating}</small>
            )}
          </div>

          {errors.submit && <div className="error-banner">{errors.submit}</div>}

          {/* Success toast */}
          {showToast && <div className="toast-success">Restaurant created</div>}

          <div className="modal-footer">
            <button type="button" className="secondary-btn" onClick={onClose}>
              Cancel
            </button>
            <button type="submit" disabled={submitting || !isFormValid}>
              {submitting ? "Submitting…" : "Create"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddRestaurantModal;

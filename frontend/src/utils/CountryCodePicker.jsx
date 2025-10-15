import PhoneInput from "react-phone-input-2";
import "react-phone-input-2/lib/bootstrap.css";
import { useTheme } from "next-themes";

export const Label = ({ className, htmlFor, children }) => (
  <label className={className} htmlFor={htmlFor}>
    {children}
  </label>
);

const CountryCodePicker = (props) => {
  const {
    phone,
    setPhone,
    countryCode,
    setCountryCode,
    setISOCode,
    isRequired = true,
    labelClassName,
    label = "Phone Number",
    bgDark = "#030C37",
    disabled,
  } = props;

  const { resolvedTheme } = useTheme?.() || { resolvedTheme: "light" };
  const isDark = resolvedTheme === "dark";

  return (
    <div className="flex flex-col">
      <Label className={labelClassName} htmlFor="phone">
        {label}
        {isRequired ? " *" : ""}
      </Label>
      <PhoneInput
        disabled={disabled}
        country={"us"}
        inputStyle={{
          fontSize: "16px",
          color: disabled ? "gray" : isDark ? "white" : "black",
          width: "100%",
          padding: "12px 6.5px 12px 50px",
          background: isDark ? bgDark : "white",
        }}
        buttonStyle={{
          marginTop: "1px",
          height: "38px",
          borderRadius: "6px",
          background: isDark ? bgDark : "transparent",
          paddingLeft: "0px",
          zIndex: 0,
        }}
        dropdownStyle={{
          zIndex: 10,
          borderRadius: "8px",
          maxHeight: "200px",
          overflowY: "auto",
          backgroundColor: isDark ? "#1F2937" : "#fff",
        }}
        containerClass="!w-full"
        searchPlaceholder="Search country"
        enableSearch={true}
        value={phone}
        onChange={(value, country) => {
          setPhone(value);
          setCountryCode(`+${country.dialCode}`);
          setISOCode(
            country.countryCode ? country.countryCode.toUpperCase() : ""
          );
        }}
        inputClass="custom-phone-input dark:!border-[#FFFFFF1F] !border-[#D9D9D9]"
      />
    </div>
  );
};
export default CountryCodePicker;

export const submitTestExplanation = async (formData) => {
  try {

    console.log("Submitting test explanation:", formData);

    const response = await fetch("http://localhost:5245/api/chat/explain", {
      method: 'POST',
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        user:{
        userName: formData.userName
      },
        question: formData.testContent
      })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    console.log(response)
    const data = await response.json();
    console.log(data)
    return data;

  } catch (error) {
    console.error("Error submitting test explanation:", error);
    return { data: null, error: error.message || "Failed to submit explanation" };
  }
};



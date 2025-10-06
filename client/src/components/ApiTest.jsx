import { useState, useEffect } from 'react';

const ApiTest = () => {
  const [apiData, setApiData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const testEndpoint = async (endpoint, label) => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch(`http://localhost:5245/api/${endpoint}`);
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const data = await response.json();
      setApiData({ label, data });
    } catch (err) {
      setError(`${label}: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const seedTestData = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('http://localhost:5245/api/TestData/seed', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const data = await response.json();
      setApiData({ label: 'Seed Data', data });
    } catch (err) {
      setError(`Seed Data: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const testLogin = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('http://localhost:5245/api/Profiles/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          identifier: 'student@codesage.com',
          password: 'student123'
        })
      });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const data = await response.json();
      setApiData({ label: 'Login Test', data });
    } catch (err) {
      setError(`Login Test: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const debugLogin = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('http://localhost:5245/api/Debug/test-login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          email: 'student@codesage.com',
          password: 'student123'
        })
      });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const data = await response.json();
      setApiData({ label: 'Debug Login', data });
    } catch (err) {
      setError(`Debug Login: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const testSimpleLogin = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('http://localhost:5245/api/Profiles/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          identifier: 'student@test.com',
          password: 'password'
        })
      });
      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`HTTP ${response.status}: ${errorText}`);
      }
      const data = await response.json();
      setApiData({ label: 'Simple Login Test', data });
    } catch (err) {
      setError(`Simple Login Test: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const testPlainLogin = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch('http://localhost:5245/api/Profiles/simple-login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          identifier: 'simple@test.com',
          password: 'test123'
        })
      });
      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`HTTP ${response.status}: ${errorText}`);
      }
      const data = await response.json();
      setApiData({ label: 'Plain Login Test', data });
    } catch (err) {
      setError(`Plain Login Test: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ padding: '20px', maxWidth: '800px', margin: '0 auto' }}>
      <h2>🔌 API Connection Test</h2>
      <p>Test the connection between React frontend and ASP.NET backend</p>
      
      <div style={{ marginBottom: '20px' }}>
        <button 
          onClick={() => testEndpoint('TestData/status', 'Data Status')}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#007bff', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Check Data Status
        </button>
        
        <button 
          onClick={seedTestData}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#28a745', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Seed Test Data
        </button>
        
        <button 
          onClick={() => testEndpoint('Profiles', 'Profiles')}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#17a2b8', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Get Profiles
        </button>
        
        <button 
          onClick={() => testEndpoint('Courses', 'Courses')}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#ffc107', color: 'black', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Get Courses
        </button>
        
        <button 
          onClick={testLogin}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#dc3545', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Test Login
        </button>
        
        <button 
          onClick={() => testEndpoint('Debug/profiles', 'Debug Profiles')}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#6f42c1', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Debug Profiles
        </button>
        
        <button 
          onClick={debugLogin}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#e83e8c', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Debug Login
        </button>
      </div>

      <div style={{ marginBottom: '20px', paddingTop: '10px', borderTop: '1px solid #ddd' }}>
        <h4>🔧 Reset & Test</h4>
        <button 
          onClick={() => testEndpoint('TestData/create-test-users', 'Create Test Users')}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#fd7e14', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Create Fresh Test Users
        </button>
        
        <button 
          onClick={testSimpleLogin}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#20c997', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Test Simple Login
        </button>
        
        <button 
          onClick={() => testEndpoint('TestData/create-simple-users', 'Create Simple Users')}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#6c757d', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Create Plain Password Users
        </button>
        
        <button 
          onClick={testPlainLogin}
          disabled={loading}
          style={{ margin: '5px', padding: '10px 15px', backgroundColor: '#198754', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}
        >
          Test Plain Login
        </button>
      </div>

      {loading && <p>⏳ Loading...</p>}
      
      {error && (
        <div style={{ background: '#f8d7da', color: '#721c24', padding: '10px', borderRadius: '4px', marginBottom: '10px' }}>
          ❌ {error}
        </div>
      )}
      
      {apiData && (
        <div style={{ background: '#d4edda', color: '#155724', padding: '15px', borderRadius: '4px' }}>
          <h3>✅ {apiData.label} - Success!</h3>
          <pre style={{ background: '#f8f9fa', padding: '10px', borderRadius: '4px', overflow: 'auto' }}>
            {JSON.stringify(apiData.data, null, 2)}
          </pre>
        </div>
      )}
    </div>
  );
};

export default ApiTest;
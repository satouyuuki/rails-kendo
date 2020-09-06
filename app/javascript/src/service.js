const csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

const myHeaders = new Headers({
  'Content-Type': 'application/json',
  "X-Requested-With": "XMLHttpRequest",
  "X-CSRF-Token": csrf_token
});
export const place = {
  createPlaceApi: (data) => {
    return fetch('api/places', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getPlaceApi: () => {
    return fetch('api/places')
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}
export const school = {
  createSchoolApi: (data) => {
    return fetch('api/schools', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getSchoolApi: () => {
    return fetch('api/schools')
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}
export const match = {
  createMatchApi: (data) => {
    return fetch('api/matches', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}

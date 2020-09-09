const csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

const myHeaders = new Headers({
  'Content-Type': 'application/json',
  "X-Requested-With": "XMLHttpRequest",
  "X-CSRF-Token": csrf_token
});
export const place = {
  createPlaceApi: (data) => {
    return fetch('/api/places', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getPlaceApi: () => {
    return fetch('/api/places')
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}
export const school = {
  createSchoolApi: (data) => {
    return fetch('/api/schools', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getSchoolApi: () => {
    return fetch('/api/schools')
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}
export const match = {
  createMatchApi: (data) => {
    return fetch('/api/matches', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  deleteMatchApi: (match_id) => {
    return fetch(`/api/matches/${match_id}`, {
      method: 'DELETE',
      headers: myHeaders,
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getAllMatchApi: () => {
    return fetch('/api/matches')
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getMatchApi: (match_id) => {
    return fetch(`/api/matches/${match_id}`)
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}
export const opponent = {
  createOpponentApi: (data) => {
    return fetch('/api/opponents', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getOpponentApi: (school_id) => {
    return fetch(`/api/opponents/${school_id}`)
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}

export const team = {
  createTeamApi: (data) => {
    return fetch('/api/teams', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getTeamApi: () => {
    return fetch('/api/teams')
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}

export const log = {
  createLogApi: (data) => {
    return fetch('/api/logs', {
      method: 'POST',
      headers: myHeaders,
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  },
  getLogApi: (match_id) => {
    return fetch(`/api/logs/${match_id}`)
      .then(res => res.json())
      .catch(err => console.log('error is ' + err));
  }
}

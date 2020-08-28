import moment from 'moment';
moment.locale('ja');

export default {
  methods: {
    dateFormat: (start) => {
      return moment(start).format('YYYY-MM-DD')
    },
  }
}
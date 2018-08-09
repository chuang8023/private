/**
 * appcenter model
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

'use strict';

const qyCloud = global[global.app];
const config = qyCloud.config;
const http = new qyCloud.Http(config.api);

const Model = qyCloud.Model;

const _ = require('lodash');

// 用户头像生成
const _avatarGen = id => {
    return `${config.fileio}/api/user/avatar/show/120/120/${id}`;
};

// 格式化用户（上下级）
const _formateUser = users => {
    return _.map(users, user => {
        let {id, name} = user;

        return {
            id,
            avatar: _avatarGen(id),
            name
        };
    });
};

class App extends Model {
    info(req) {
        let {id} = req.params;

        return http.get(...this._appendCookie(`/api2/user/info/contact/${id}`, req)).then(response => {
            if (response.status === 200) {
                let {result} = response;

                let left = _.pick(result, [
                    'real_name', 'pinying', 'sign', 'sex', 'intimacyNum', 'communicateNum', 'workNum'
                ]);

                left.avatar = _avatarGen(result.user_id); // 用户头像

                let middle = _.pick(result, [
                    'phone', 'qq', 'email', 'addr', 'jobdesc', 'ext'
                ]);

                let {entry} = result;

                if (entry) {
                    let date = (new Date() - new Date(entry.replace(/-/g, '/'))) / (1000 * 60 * 60 * 24);
                    let ageLimit;

                    if (isNaN(date)) {
                        ageLimit = '未知';
                    } else {
                        if (date <= 30) {
                            ageLimit = `${Math.floor(date)}天`;
                        } else if (date < 360) {
                            ageLimit = `${Math.floor(date / 30)}个月`;
                        } else {
                            let month = date / 30;

                            let year = Math.floor(month / 12);

                            let remind = Math.floor(month - year * 12);

                            ageLimit = `${year}年${remind ? `${remind}个月` : ''}`;
                        }
                    }
                    middle.ageLimit = ageLimit;
                }

                let right = {
                    jobs: _.filter(result.jobs, job => job !== '')
                };

                // 上下级
                let {directLeaders, directUnders} = result;

                right.chiefs = _formateUser(directLeaders);
                right.juniors = _formateUser(directUnders);

                return {
                    self: result.isMe,
                    left,
                    middle,
                    right
                };
            }

            return response;
        });
    }

    interTalk(req, id) { // 互动沟通
        return http.get(...this._appendCookie('/api2/message/together/comm', req, {
            userId: id,
            'paging[start]': 0,
            'paging[perPage]': 20
        }));
    }

    interWork(req, id) { // 共同工作
        return http.get(...this._appendCookie('/api2/workflow/together/all', req, {
            userId: id,
            'paging[start]': 0,
            'paging[perPage]': 20
        }));
    }

    moreWork(req) { // 共同工作内部点击
        let {appid, uid, start} = req.query;

        return http.get(...this._appendCookie('/api2/workflow/together/app', req, {
            definitionId: appid,
            userId: uid,
            'paging[start]': start || 0,
            'paging[perPage]': 20
        }));
    }

    lastmore(req) { // 分页共同工作尾部点击
        let {uid, pagestart} = req.query;

        return http.get(...this._appendCookie('/api2/workflow/together/all', req, {
            userId: uid,
            'paging[start]': pagestart || 0,
            'paging[perPage]': 20
        }));
    }

    moreTalk(req) { // 互动沟通尾部点击
        let {uid, start} = req.query;

        return http.get(...this._appendCookie('/api2/message/together/comm', req, {
            userId: uid,
            'paging[start]': start || 0
        }));
    }
}

module.exports = new App();

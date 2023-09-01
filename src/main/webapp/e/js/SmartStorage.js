/**
 * 阿文
 */
(function fx897876() {
   let HashMap= function () {
        let memObj = {};
        this.count = 0;
        //添加
        this.add = function(key, value) {
            if (memObj.hasOwnProperty(key)) {
                return false; //如果键已经存在，不添加
            }else {
                memObj[key] = value;
                this.count++;
                return true;
            }
        }

        this.contain = function(key) {
            return memObj.hasOwnProperty(key);
        }

        this.get = function(key){
            if (this.contain(key))
                return memObj[key];
            return null;
        }
        this.remove= function(key) {
            if (this.contain(key)) {
                delete memObj[key];
                this.count--;
            }
        }
        //清空
        this.clear = function(){
            memObj = {};
            this.count = 0;
        }
        this.getData=function (){
            return memObj;
        }
        this.setData=function (data){
            return memObj=data;
        }
    }

    /**
     * {
     *     id,
     *     name,
     *     tupian,
     *     price,
     *     count
     *     typename
     * }
     * @constructor
     */
    let SmartStorage=function (){

        let lockey="locshopcart";
        this.add=function (key,item){
            let strCart=window.localStorage.getItem(lockey);
            let map=new HashMap();
            if(strCart!=null)
                map.setData(JSON.parse(strCart));
            let  temitem=map.get(key);
            if(temitem==null)
                map.add(key,item);
            else
                temitem.count=temitem.count+item.count;
            console.log("数据对象",map.getData());
            window.localStorage.setItem(lockey,JSON.stringify(map.getData()));
        }
        this.remove=function (key){
            let strCart=window.localStorage.getItem(lockey);
            let map=new HashMap();
            if(strCart!=null)
                map.setData(JSON.parse(strCart));
            map.remove(key);
            window.localStorage.setItem(lockey,JSON.stringify(map.getData()));
        }
        this.getItems=function (){
            let strCart=window.localStorage.getItem(lockey);
            console.log("strCart",strCart);
            let arr=[];
            let map=new HashMap();
            if(strCart!=null)
                map.setData(JSON.parse(strCart));
            console.log("map.getData()=",map.getData());
            for(let key in map.getData()){
                arr.push({id:key,value:map.getData()[key]});
            }
            console.log("arr=",arr);
            return arr;
        }
        this.update=function (key,item){
            let strCart=window.localStorage.getItem(lockey);
            let map=new HashMap();
            if(strCart!=null)
                map.setData(JSON.parse(strCart));
            let  temitem=map.get(key);
            if(temitem==null)
                map.add(key,item);
            else
                Object.assign(temitem,item);
            window.localStorage.setItem(lockey,JSON.stringify(map.getData()));
        }

        this.clear=function (){
            window.localStorage.removeItem(lockey);
        }
    }
    window.SmartStorage=SmartStorage;
})();



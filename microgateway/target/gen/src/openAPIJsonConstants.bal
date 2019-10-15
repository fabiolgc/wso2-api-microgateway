
function getOpenAPIs() returns map<json> {
	return {  "Kindel_Book_Store__1_0_0" : {
  "openapi" : "3.0.0",
  "info" : {
    "title" : "Kindel Book Store",
    "description" : "This is a service for an online bookstore",
    "termsOfService" : "http://kindel.io/terms/",
    "contact" : {
      "email" : "apiteam@kindel.io"
    },
    "license" : {
      "name" : "Apache 2.0",
      "url" : "http://www.apache.org/licenses/LICENSE-2.0.html"
    },
    "version" : "1.0.0"
  },
  "servers" : [ {
    "url" : "/"
  } ],
  "tags" : [ {
    "name" : "book",
    "description" : "Everything about your book available in store",
    "externalDocs" : {
      "description" : "Find out more",
      "url" : "http://kindel.store.io"
    }
  } ],
  "paths" : {
    "/books/list" : {
      "get" : {
        "tags" : [ "pet" ],
        "summary" : "Get the list of books",
        "description" : "Paginated result of books",
        "operationId" : "findbooks",
        "responses" : {
          "200" : {
            "description" : "successful operation"
          },
          "400" : {
            "description" : "Invalid status value"
          }
        },
        "extensions" : {
          "x-wso2-production-endpoints" : "#/x-wso2-endpoints/booklist"
        }
      }
    },
    "/books/search/{query}" : {
      "get" : {
        "tags" : [ "pet" ],
        "summary" : "Find books by by search query",
        "description" : "Returns a array of books",
        "operationId" : "searchbooks",
        "parameters" : [ {
          "name" : "query",
          "in" : "path",
          "description" : "search query to be used",
          "required" : true,
          "style" : "SIMPLE",
          "explode" : false,
          "schema" : {
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "successful operation"
          },
          "400" : {
            "description" : "Invalid query supplied"
          }
        },
        "extensions" : {
          "x-wso2-production-endpoints" : "#/x-wso2-endpoints/booksearch",
          "x-wso2-request-interceptor" : "validateHeader",
          "x-wso2-response-interceptor" : "sendCustomRespone",
          "x-wso2-disable-security" : true
        }
      }
    }
  },
  "extensions" : {
    "x-wso2-basePath" : "/bookstore/v1",
    "x-wso2-throttling-tier" : "1KPerMin",
    "x-wso2-endpoints" : [ {
      "booklist" : {
        "urls" : [ "http://books-list-service:9099" ]
      }
    }, {
      "booksearch" : {
        "urls" : [ "etcd(booksearch,http://books-list-service:9099)" ]
      }
    } ]
  }
}  };
}
namespace GE.MyLearning.BL.Interface
{
    using System;
    using System.Collections;
    using System.Collections.Generic;

    public class TreeList
    {
        private Hashtable _nodes = new Hashtable();
        private const string ROOT = "root";

        public TreeList()
        {
            this._nodes.Add("root", new Node("root", "root"));
        }

        public Node Add(string id, string text, string parentId)
        {
            Node node = this.Find(id);
            if (node == null)
            {
                node = new Node(id, text);
                node.ParentId = parentId;
                this._nodes.Add(id, node);
                if ((parentId != null) && (parentId != ""))
                {
                    if (this._nodes.ContainsKey(parentId))
                    {
                        ((Node) this._nodes[parentId]).AddChild(node);
                    }
                    return node;
                }
                ((Node) this._nodes["root"]).AddChild(node);
            }
            return node;
        }

        public void BatchCheck(List<string> ids)
        {
            for (int i = 0; i < ids.Count; i++)
            {
                Node node1 = this.Find(ids[i]);
                if (node1 != null)
                {
                    node1.Check = true;
                }
            }
        }

        public void BatchDisable(List<string> ids)
        {
            for (int i = 0; i < ids.Count; i++)
            {
                Node node1 = this.Find(ids[i]);
                if (node1 != null)
                {
                    node1.Enable = false;
                }
            }
        }

        public void BatchExpand()
        {
            foreach (Node node in this._nodes.Values)
            {
                if (node.Check || node.Expand)
                {
                    for (Node parent = node.Parent; parent != null; parent = parent.Parent)
                    {
                        parent.Expand = true;
                    }
                }
            }
        }

        public void BatchExpand(List<string> ids)
        {
            for (int i = 0; i < ids.Count; i++)
            {
                Node node1 = this.Find(ids[i]);
                if (node1 != null)
                {
                    node1.Expand = true;
                }
            }
        }

        public int Count()
        {
            return (this._nodes.Count - 1);
        }

        public Node Find(string id)
        {
            Node returnValue = null;
            if (this._nodes.ContainsKey(id))
            {
                returnValue = (Node) this._nodes[id];
            }
            return returnValue;
        }

        public void RepairTree()
        {
            foreach (Node node in this._nodes.Values)
            {
                if ((((node.ParentId != null) && (node.ParentId != "")) && (node.Parent == null)) && this._nodes.ContainsKey(node.ParentId))
                {
                    ((Node) this._nodes[node.ParentId]).AddChild(node);
                }
            }
        }

        public ICollection Nodes
        {
            get
            {
                return this._nodes.Values;
            }
        }

        public Node Root
        {
            get
            {
                return (Node) this._nodes["root"];
            }
        }

        public class Node
        {
            private bool _check;
            private List<TreeList.Node> _children;
            private bool _enable;
            private bool _expand;
            private string _id;
            private TreeList.Node _parent;
            private string _parentId;
            private string _text;

            public Node()
            {
                this._id = "";
                this._text = "";
                this._parentId = "";
                this._check = false;
                this._enable = true;
                this._expand = false;
                this._parent = null;
                this._children = null;
            }

            public Node(string id, string text)
            {
                this._id = "";
                this._text = "";
                this._parentId = "";
                this._check = false;
                this._enable = true;
                this._expand = false;
                this._parent = null;
                this._children = null;
                this._id = id;
                this._text = text;
                this._children = new List<TreeList.Node>();
            }

            public TreeList.Node AddChild(TreeList.Node child)
            {
                child._parentId = this.ID;
                child._parent = this;
                this._children.Add(child);
                return child;
            }

            public bool Check
            {
                get
                {
                    return this._check;
                }
                set
                {
                    this._check = value;
                }
            }

            public List<TreeList.Node> Children
            {
                get
                {
                    return this._children;
                }
            }

            public bool Enable
            {
                get
                {
                    return this._enable;
                }
                set
                {
                    this._enable = value;
                }
            }

            public bool Expand
            {
                get
                {
                    return this._expand;
                }
                set
                {
                    this._expand = value;
                }
            }

            public string ID
            {
                get
                {
                    return this._id;
                }
                set
                {
                    this._id = value;
                }
            }

            public TreeList.Node Parent
            {
                get
                {
                    return this._parent;
                }
                set
                {
                    this._parent = value;
                }
            }

            public string ParentId
            {
                get
                {
                    return this._parentId;
                }
                set
                {
                    this._parentId = value;
                }
            }

            public string Text
            {
                get
                {
                    return this._text;
                }
                set
                {
                    this._text = value;
                }
            }
        }
    }
}


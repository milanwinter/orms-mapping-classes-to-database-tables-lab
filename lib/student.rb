class Student

  def self.create_table
    sql = <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
    )
      SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students
      SQL
      DB[:conn].execute(sql)
  end
  
  def self.create(name:,grade:)
    student = Student.new(name,grade)
    student.save
    student
  end
    attr_accessor :name, :grade
    attr_reader :id
  
    def initialize (name,grade,id=nil)
      @id = id
      @name = name
      @grade = grade
    end



    def save
      sql = <<-SQL 
        INSERT INTO students (name,grade)
        VALUES(?,?)
        SQL

        DB[:conn].execute(sql,self.name,self.grade)

        @id = DB[:conn].execute("Select last_insert_rowid() From students")[0][0]
    end


















end

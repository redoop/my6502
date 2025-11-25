name := "chisel-6502"
version := "0.1.0"
scalaVersion := "2.12.17"

// 使用阿里云镜像
resolvers ++= Seq(
  "Aliyun Maven" at "https://maven.aliyun.com/repository/public/",
  "Aliyun Central" at "https://maven.aliyun.com/repository/central/",
  "Aliyun JCenter" at "https://maven.aliyun.com/repository/jcenter/"
)

libraryDependencies ++= Seq(
  "edu.berkeley.cs" %% "chisel3" % "3.5.6",
  "edu.berkeley.cs" %% "chiseltest" % "0.5.6" % "test"
)

scalacOptions ++= Seq(
  "-deprecation",
  "-feature",
  "-unchecked",
  "-language:reflectiveCalls"
)

addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.6" cross CrossVersion.full)

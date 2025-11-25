name := "chisel-6502"
version := "0.1.0"
scalaVersion := "2.13.12"

// 使用阿里云镜像
resolvers ++= Seq(
  "Aliyun Maven" at "https://maven.aliyun.com/repository/public/",
  "Aliyun Central" at "https://maven.aliyun.com/repository/central/",
  "Aliyun JCenter" at "https://maven.aliyun.com/repository/jcenter/"
)

libraryDependencies ++= Seq(
  "org.chipsalliance" %% "chisel" % "5.1.0",
  "edu.berkeley.cs" %% "chiseltest" % "5.0.2" % "test"
)

scalacOptions ++= Seq(
  "-deprecation",
  "-feature",
  "-unchecked",
  "-language:reflectiveCalls",
  "-Ymacro-annotations"
)

addCompilerPlugin("org.chipsalliance" % "chisel-plugin_2.13.12" % "5.1.0")

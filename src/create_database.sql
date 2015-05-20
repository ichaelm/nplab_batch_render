CREATE TABLE Scenes(
  sceneID INTEGER PRIMARY KEY,
  scene VARCHAR(255) UNIQUE NOT NULL,
  SKPLastModified DATETIME NOT NULL,
  SKPHash VARCHAR(255) NOT NULL,
  ThumbLastModified DATETIME NOT NULL,
  ThumbHash VARCHAR(255) NOT NULL,
  MXSLastModified DATETIME NOT NULL,
  MXSHash VARCHAR(255) NOT NULL,
  CTSLastModified DATETIME NOT NULL,
  CTSHash VARCHAR(255) NOT NULL,
  scene
);

CREATE UNIQUE INDEX idx_Scenes_scene ON Scenes(scene);

CREATE TABLE CameraTargets(
  cameraTargetID INTEGER PRIMARY KEY,
  sceneID INTEGER NOT NULL,
  camera UNSIGNED BIG INT NOT NULL,
  target UNSIGNED BIG INT NOT NULL,
  FOREIGN KEY(sceneID) REFERENCES Scenes(sceneID),
  UNIQUE(sceneID, camera, target)
);

CREATE INDEX idx_CameraTargets_sceneID ON CameraTargets(sceneID);

CREATE TABLE Configs(
  configID INTEGER PRIMARY KEY,
  numTraces UNSIGNED INT NOT NULL,
  numFrames UNSIGNED INT NOT NULL,
  JSONHash VARCHAR(255) NOT NULL,
);

CREATE TABLE Traces(
  traceID INTEGER PRIMARY KEY,
  cameraTargetID INTEGER NOT NULL,
  configID INTEGER NOT NULL,
  trace UNSIGNED INT NOT NULL,
  TraceLastModified DATETIME NOT NULL,
  TraceHash VARCHAR(255) NOT NULL,
  FOREIGN KEY(cameraTargetID) REFERENCES CameraTargets(cameraTargetID),
  FOREIGN KEY(configID) REFERENCES Configs(configID),
  UNIQUE(cameraTargetID, configID, trace)
);

CREATE INDEX idx_Traces_cameraTargetID ON Traces(cameraTargetID)
CREATE INDEX idx_Traces_configID ON Traces(configID)
CREATE UNIQUE INDEX idx_Traces_cameraTargetID_configID_trace ON Traces(cameraTargetID_configID_trace)

CREATE TABLE Frames(
  frameID INTEGER PRIMARY KEY,
  traceID INTEGER NOT NULL,
  frame UNSIGNED INT NOT NULL,
  hasMXS BOOL NOT NULL,
  MXSLastModified DATETIME,
  MXSHash VARCHAR(255),
  hasImage BOOL NOT NULL,
  imageLastModified DATETIME,
  imageHash VARCHAR(255),
  FOREIGN KEY(traceID) REFERENCES Traces(traceID),
  UNIQUE(traceID, frame)
);

CREATE INDEX idx_Frames_hasMXS ON Frames(hasMXS);
CREATE INDEX idx_Frames_hasImage ON Frames(hasImage);
CREATE INDEX idx_Frames_traceID ON Frames(traceID);
CREATE UNIQUE INDEX idx_Frames_traceID_frame ON Frames(traceID, frame);

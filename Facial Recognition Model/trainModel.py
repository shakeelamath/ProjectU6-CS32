#import required packages
from tensorflow import keras
from keras import Sequential
from keras import Dense, Conv2D, Flatten, Dropout, MaxPooling2D
from keras import Adam
from keras import ImageDataGenerator

#Initialize image data generator with rescaling
train_data_gen = ImageDataGenerator(rescale=1./255)
validation_data_gen = ImageDataGenerator(rescale=1./255)

#Preprocess all test images
train_generator = train_data_gen.flow_from_directory(
    'archive/train',
    target_size=(48, 48),
    batch_size=64,
    color_mode="grayscale",
    class_mode="categorical")

#Preprocess all train images
validation_generator = validation_data_gen.flow_from_directory(
    'archive/test',
    target_size=(48, 48),
    batch_size=64,
    color_mode="grayscale",
    class_mode="categorical")

#Create model structure
emotion_detection_model = Sequential()

emotion_detection_model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
emotion_detection_model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
emotion_detection_model.add(MaxPooling2D(pool_size=(2, 2)))
emotion_detection_model.add(Dropout(0.25))

emotion_detection_model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
emotion_detection_model.add(MaxPooling2D(pool_size=(2, 2)))
emotion_detection_model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
emotion_detection_model.add(MaxPooling2D(pool_size=(2, 2)))
emotion_detection_model.add(Dropout(0.25))

emotion_detection_model.add(Flatten())
emotion_detection_model.add(Dense(1024, activation='relu'))
emotion_detection_model.add(Dropout(0.5))
emotion_detection_model.add(Dense(7, activation='softmax'))

emotion_detection_model.compile(loss='categorical_crossentropy', optimizer=Adam(lr=0.0001, decay=1e-6), metrics=['accuracy'])

# Train the neural network/model
emotion_detection_model_info = emotion_detection_model.fit_generator(
        train_generator,
        steps_per_epoch=28709 // 64,
        epochs=50,
        validation_data=validation_generator,
        validation_steps=7178 // 64)

# save model structure in jason file
model_json = emotion_detection_model.to_json()
with open("emotion_detection_model.json", "w") as json_file:
    json_file.write(model_json)

# save trained model weight in .h5 file
emotion_detection_model.save_weights('emotion_detection_model.h5')
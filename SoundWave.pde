class SoundWave {
  boolean centered;
  float rotation;
  float ln;
  float amp;
  int direction;

  SoundWave() {
    centered = (int)random(1) == 1 ? true : false;
    rotation = random(10);
    ln = random(60, 200);
    amp = random(70, 150);
    direction = (int)random(-2,2);
  }

  void rotate() {
    if (!beat.isKick()) {
      rotation += random(0.05) * direction;
    }
  }

  float[][] returnPoints(PVector anchor) {
    ArrayList<float[]> points = new ArrayList<float[]>(); 
    for (int i = 0; i < player.bufferSize(); i+=50)
    {
      float x1, y1;
      if (centered) {
        x1 = map( i, 0, player.bufferSize(), 0, ln );
      } else {
        x1 = map( i, 0, player.bufferSize(), -ln/2, ln/2 );
      }
      y1 = player.mix.get(i)*amp;

      float x2 = x1*cos(rotation) - y1*sin(rotation) + anchor.x;
      float y2 = x1*sin(rotation) + y1*cos(rotation) + anchor.y;

      points.add(new float[]{x2, y2});
    }

    return points.toArray(new float[points.size()][2]);
  }
}
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int BODY_COUNT = 5000;

typedef struct
{
  float m, x, y, z, vx, vy, vz;
} Body;

void randomize(Body *bodies)
{
  for (int i = 0; i < BODY_COUNT; i++)
  {
    bodies[i].m = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    bodies[i].x = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    bodies[i].y = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    bodies[i].z = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    bodies[i].vx = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    bodies[i].vy = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
    bodies[i].vz = 2.0f * (rand() / (float)RAND_MAX) - 1.0f;
  }
}

int main(int argc, char *argv[])
{
  Body *bodies;
  FILE *fp;
  char file_name[100], body_count[10];

  for (int i = 0; i < 6; i++)
  {
    bodies = (Body *)malloc(BODY_COUNT * sizeof(Body)); // Allocate memory for bodies
    randomize(bodies);

    sprintf(body_count, "%d", BODY_COUNT);
    strcpy(file_name, "dataset_");
    strcat(file_name, body_count);
    strcat(file_name, ".csv");
    printf("Writing to %s ...\n", file_name);
    fp = fopen(file_name, "w");
    if (fp == NULL)
    {
      printf("Sorry, an error occured while opening output file for writing.\n");
      return 0;
    }
    // Write headers for csv
    fprintf(fp, "mass,coord_x,coord_y,coord_z,velocity_x,velocity_y,velocity_z\n");
    // Write nx7 values to csv (mass, coord_x, coord_y, coord_z, velocity_x, velocity_y, velocity_z)
    for (int i = 0; i < BODY_COUNT; i++)
    {
      fprintf(fp, "%.7f,%.7f,%.7f,%.7f,%.7f,%.7f,%.7f\n", bodies[i].m, bodies[i].x, bodies[i].y, bodies[i].z, bodies[i].vx, bodies[i].vy, bodies[i].vz);
    }
    printf("Done.\n");
    // printf("mass,coord_x,coord_y,coord_z,velocity_x,velocity_y,velocity_z\n");
    // for (int i = 0; i < BODY_COUNT; i++)
    // {
    //   printf("%.7f,%.7f,%.7f,%.7f,%.7f,%.7f,%.7f\n", bodies[i].m, bodies[i].x, bodies[i].y, bodies[i].z, bodies[i].vx, bodies[i].vy, bodies[i].vz);
    // }

    BODY_COUNT += 1000;
  }
  return 0;
}
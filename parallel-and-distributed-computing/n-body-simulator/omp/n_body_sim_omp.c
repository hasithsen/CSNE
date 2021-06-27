/*
 * Parallelized (OpenMP) n-body solver for planets/stars in Euclid space
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <omp.h>

#define BODY_COUNT 10000
#define SIM_STEPS 50            // Number of frames to simulate
#define G 6.674f * pow(10, -11) // Newton's universal const of gravity
#define DELTA_T 0.01f           // Time gap between two simulation frames (in simulation)

typedef struct
{
  float m, x, y, z, vx, vy, vz;
} Body;

int bye(double *tcalc)
{
  printf("Simulation took %lf seconds.\n", *tcalc);
  exit(0);
}

int main(const int argc, const char **argv)
{
  double tstart = 0.0, tstop = 0.0, tcalc = 0.0;            // For timing
  Body *bodies = (Body *)malloc(BODY_COUNT * sizeof(Body)); // Allocate memory for bodies

  char file_name[100], body_count[10];
  FILE *fp;

  sprintf(body_count, "%d", BODY_COUNT);
  strcpy(file_name, "/home/u47422/it17142038/assignment/dataset_");
  strcat(file_name, body_count);
  strcat(file_name, ".csv");
  fp = fopen(file_name, "r"); // read mode
  if (fp == NULL)
  {
    printf("Sorry, an error occured while reading input file.\n");
    return 0;
  }

  fscanf(fp, "%*[^\n]\n"); // Skip headings in input csv file

  // Assume csv with nx7 values (mass, coord_x, coord_y, coord_z, velocity_x, velocity_y, velocity_z)
  for (int i = 0; i < BODY_COUNT; i++)
    fscanf(fp, "%f,%f,%f,%f,%f,%f,%f", &bodies[i].m, &bodies[i].x, &bodies[i].y, &bodies[i].z, &bodies[i].vx, &bodies[i].vy, &bodies[i].vz);

  tstart = omp_get_wtime();
  for (int step = 0; step < SIM_STEPS; step++)
  {
#pragma omp parallel for
    for (int i = 0; i < BODY_COUNT; i++)
    {
      float Fx = 0.0f;
      float Fy = 0.0f;
      float Fz = 0.0f;

      for (int j = 0; j < BODY_COUNT; j++)
      {
        if (i == j)
          continue;

        const float dx = bodies[j].x - bodies[i].x;
        const float dy = bodies[j].y - bodies[i].y;
        const float dz = bodies[j].z - bodies[i].z;
        const float dist = sqrt(dx * dx + dy * dy + dz * dz);
        const float dist_cubed = dist * dist * dist;

        // Calculate forces
        Fx += G * bodies[i].m * bodies[j].m / dist_cubed * dx;
        Fy += G * bodies[i].m * bodies[j].m / dist_cubed * dy;
        Fz += G * bodies[i].m * bodies[j].m / dist_cubed * dz;
      }

// Assign velocities
#pragma omp critical
      {
        bodies[i].vx += DELTA_T * Fx;
        bodies[i].vy += DELTA_T * Fy;
        bodies[i].vz += DELTA_T * Fz;
      }
    }

    // Update coordinates (serial loop since not much work)
    for (int i = 0; i < BODY_COUNT; i++)
    {
      bodies[i].x += bodies[i].vx * DELTA_T;
      bodies[i].y += bodies[i].vy * DELTA_T;
      bodies[i].z += bodies[i].vz * DELTA_T;
    }
  }
  tstop = omp_get_wtime();

  printf("body0:\n m:%.7f\n x:%.7f\n y:%.7f\n z:%.7f\n vx:%.7f\n vy:%.7f\n vz:%.7f\n", bodies[0].m, bodies[0].x, bodies[0].y, bodies[0].z, bodies[0].vx, bodies[0].vy, bodies[0].vz);
  /* For debugging purposes */
  strcpy(file_name, "output_");
  strcat(file_name, "omp_");
  strcat(file_name, body_count);
  strcat(file_name, ".csv");
  printf("Written all to %s\n", file_name);
  fp = fopen(file_name, "w"); // write mode
  if (fp == NULL)
  {
    printf("Sorry, an error occured while opening output file for writing.\n");
    return 0;
  }
  // Write headers for csv
  fprintf(fp, "mass,coord_x,coord_y,coord_z,velocity_x,velocity_y,velocity_z\n");
  // Write csv with nx7 values (mass, coord_x, coord_y, coord_z, velocity_x, velocity_y, velocity_z)
  for (int i = 0; i < BODY_COUNT; i++)
    fprintf(fp, "%.7f,%.7f,%.7f,%.7f,%.7f,%.7f,%.7f\n", bodies[i].m, bodies[i].x, bodies[i].y, bodies[i].z, bodies[i].vx, bodies[i].vy, bodies[i].vz);
  fclose(fp);

  free(bodies);

  printf("Simulated %d frames for %d bodies\n", SIM_STEPS, BODY_COUNT);
  tcalc = tstop - tstart;
  bye(&tcalc);

  return 0;
}

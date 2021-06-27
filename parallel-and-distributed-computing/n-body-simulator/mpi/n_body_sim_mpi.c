/*
  Read a set of numbers from a file and calculate parallely.

  Parallelized with MPI.
*/
#include <cstdio>
#include <cstdlib>
#include <string.h>
#include <math.h>
#include <sys/time.h>
#include <mpi.h>

#define BODY_COUNT 10000
#define SIM_STEPS 50            // Number of frames to simulate
#define G 6.674f * pow(10, -11) // Newton's universal const of gravity
#define DELTA_T 0.01f           // Time gap between two simulation frames (in simulation)

typedef struct
{
  float m, x, y, z, vx, vy, vz;
} Body;

// Track CPU time
double cpuSecond()
{
  struct timeval tp;
  gettimeofday(&tp, NULL);
  return ((double)tp.tv_sec + (double)tp.tv_usec * 1.e-6);
}

int main(int argc, char **argv)
{
  int my_rank, comm_sz;
  double tstart = 0.0, tstop = 0.0, tcalc = 0.0; // For timing
  Body *bodies, *local_bodies;
  bodies = (Body *)malloc(BODY_COUNT * sizeof(Body)); // Allocate memory for bodies
  int width;

  char file_name[100], body_count[10];
  FILE *fp;
  MPI_Datatype mpi_body_type;

  MPI_Init(&argc, &argv);

  /* Create the MPI data type for communicating body data */
  MPI_Type_contiguous(7, MPI_FLOAT, &mpi_body_type);
  MPI_Type_commit(&mpi_body_type);

  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);

  if (my_rank == 0)
  {
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
    fclose(fp);
  }

  width = ceil(BODY_COUNT / comm_sz);                  // number range for locally performing calculation on
  local_bodies = (Body *)malloc(width * sizeof(Body)); // Local subset of  array of Body structs
  MPI_Scatter(bodies, width, mpi_body_type, local_bodies, width, mpi_body_type, 0, MPI_COMM_WORLD);

  if (my_rank == 0)
    tstart = cpuSecond();

  // Calculation for local subset of bodies (local_bodies)
  for (int step = 0; step < SIM_STEPS; step++)
  {
    for (int i = 0; i < width; i++)
    {
      float Fx = 0.0f;
      float Fy = 0.0f;
      float Fz = 0.0f;

      for (int j = 0; j < width; j++)
      {
        if (i == j)
          continue;

        const float dx = local_bodies[j].x - local_bodies[i].x;
        const float dy = local_bodies[j].y - local_bodies[i].y;
        const float dz = local_bodies[j].z - local_bodies[i].z;
        const float dist = sqrt(dx * dx + dy * dy + dz * dz);
        const float dist_cubed = dist * dist * dist;

        // Calculate forces
        Fx += G * local_bodies[i].m * local_bodies[j].m / dist_cubed * dx;
        Fy += G * local_bodies[i].m * local_bodies[j].m / dist_cubed * dy;
        Fz += G * local_bodies[i].m * local_bodies[j].m / dist_cubed * dz;
      }

      // Assign velocities
      local_bodies[i].vx += DELTA_T * Fx;
      local_bodies[i].vy += DELTA_T * Fy;
      local_bodies[i].vz += DELTA_T * Fz;

      // Update coordinates
      local_bodies[i].x += local_bodies[i].vx * DELTA_T;
      local_bodies[i].y += local_bodies[i].vy * DELTA_T;
      local_bodies[i].z += local_bodies[i].vz * DELTA_T;
    }
  }

  if (my_rank == 0)
    tstop = cpuSecond();
  MPI_Gather(local_bodies, width, mpi_body_type, bodies, width, mpi_body_type, 0, MPI_COMM_WORLD);
  // for (int i=0; i < 1; i++)
  //   printf("%.7f,%.7f,%.7f,%.7f,%.7f,%.7f,%.7f\n", local_bodies[i].m, local_bodies[i].x, local_bodies[i].y, local_bodies[i].z, local_bodies[i].vx, local_bodies[i].vy, local_bodies[i].vz);
  free(local_bodies);

  if (my_rank == 0)
  {
    printf("body0:\n m:%.7f\n x:%.7f\n y:%.7f\n z:%.7f\n vx:%.7f\n vy:%.7f\n vz:%.7f\n", bodies[0].m, bodies[0].x, bodies[0].y, bodies[0].z, bodies[0].vx, bodies[0].vy, bodies[0].vz);

    /* For debugging purposes */
    strcpy(file_name, "output_");
    strcat(file_name, "mpi_");
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
  }
  free(bodies);

  if (my_rank == 0)
  {
    printf("Simulated %d frames for %d bodies\n", SIM_STEPS, BODY_COUNT);
    tcalc = tstop - tstart;
    printf("Simulation took %lf seconds.\n", tcalc);
  }

  MPI_Finalize();

  return 0;
}

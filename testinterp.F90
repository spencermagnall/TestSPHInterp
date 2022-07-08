program testinterp
    use interpolations3D
    use unifdis
    implicit none
    integer, parameter :: np = 125
    real :: xyzh(4,np), xmin,ymin,zmin,xmax,ymax,zmax,dat(np) 
    real :: xmingrid(3)
    real :: dxgrid(3), dx
    real :: xoffset, yoffset,zoffset
    integer :: ngrid(3)
    logical :: normalise, periodic,vertexcen
    integer :: i,j,k
    real :: hfact, weight 
    real, allocatable :: datsmooth(:,:,:) 
    integer :: nopart, npartx, nnodes,ngridin




    npartx = 5

    ! Set min and max for particles 
    xmin = 0.
    ymin = 0.
    zmin = 0.

    xmax = 1.
    ymax = 1.
    zmax = 1. 

    ! Read in the grid offset from the part min 
    print*, "Enter the grid offset from origin in the x direction: "
    read*, xoffset
    print*, "Enter the grid offset from origin in the y direction: "
    read*, yoffset
    print*, "Enter the grid offset from origin in the z direction: "
    read*, zoffset

    xmingrid(1) = xmin + xoffset
    xmingrid(2) = ymin + yoffset
    xmingrid(3) = zmin + zoffset

    ! Particle positions and smoothing length
    hfact = 1.2
    ! Setup particles running in the domain from 0-1
    ! Get dx from particle number
    
    dx = xmax/npartx

    nopart = 0
    call set_unifdis('cubic',1,1,xmin,xmax,ymin,ymax, &
                       zmin,zmax,dx,hfact,nopart,xyzh,.true.)
    

    print*, "x pos: ", xyzh(1,:)
    ! Particle weight 
    weight = 1.

 

    ! Ngrid direction of the grid in each direction
    print*, "Enter the number of grid cells per dimension: "
    read*, ngridin
    ngrid(:) = ngridin
    nnodes = ngrid(1)*ngrid(2)*ngrid(3)
    dxgrid(:) = xmax/ngrid
    print*, "dxgrid: ", dxgrid
    print*, "3,3,3 values: ", xmingrid + dxgrid*ngrid
    ! We want to normalise 
    normalise = .true. 
    ! We want periodic boundary conditions
    periodic = .true. 
    ! Are we vertex centered or a cell centred grid
    vertexcen = .true. 
    ! Data from particles that is to be interpolated
    dat(:) = 5.678

    allocate(datsmooth(ngrid(1),ngrid(2),ngrid(3)))

    call interpolate3D(xyzh,weight,nopart,xmingrid,datsmooth,nnodes,dxgrid,normalise,dat,ngrid,periodic,vertexcen)

    do k=1,ngrid(3)
        do j=1, ngrid(2)
            do i=1, ngrid(1)
                print*, "Grid pos is: ", xmingrid(1) + dxgrid(1)*i, xmingrid(2) + dxgrid(2)*j, xmingrid(3) + dxgrid(3)*k
                print*, "dat smooth: ", datsmooth(i,j,k)
            enddo 
        enddo 
    enddo


end program testinterp

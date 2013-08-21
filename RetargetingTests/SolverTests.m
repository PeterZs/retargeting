//
//  SolverTests.m
//  Retargeting
//
//  Created by Daniel Graf on 20.11.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import "SolverTests.h"
#import "RetargetingSolver.h"
#import "Matrix.h"
#import "RetargetingTask.h"

#import "CVXGenRangeSolver25x25.h"
#import "CVXGenRangeSolver25x25+TestSolver.h"

#define DEBUG_PRINT 0

@implementation SolverTests
-(void)testSolverDesktopComparison {
    // load test case of SIR
    int M = 25;
    int N = 25;
    double W_sir = 1024.000000;
    double H_sir = 680.000000;
    double Wp_sir = 512.000000;
    double Hp_sir = 680.000000;
    double LW_sir = 6.144000;
    double LH_sir = 4.080000;
    double saliencyMatrix_sir[625] = {1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.540187,1.414214,1.817808,4.675466,5.271320,3.349149,3.362877,1.414214,1.414214,1.414214,1.810588,5.265833,4.606170,3.507638,3.291197,1.634099,1.825000,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.934566,1.590680,3.358980,4.351017,5.453176,4.962006,1.703920,1.414214,1.414214,1.414214,1.414214,3.412475,4.183030,2.948519,3.412210,2.372874,1.635481,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.461079,2.954335,4.917292,3.682400,5.832656,1.414214,1.414214,1.414214,1.414214,1.414214,3.407309,3.825578,3.763563,2.683551,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.048200,3.756716,4.087016,4.621344,3.330758,1.414214,1.414214,1.414214,1.414214,1.414214,2.752678,4.038545,2.472980,1.511474,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.861025,4.696633,3.656768,6.782137,1.832013,1.414214,1.414214,1.414214,1.414214,1.414214,2.233729,3.172453,2.258164,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.599771,4.059850,3.984840,1.483422,1.414214,1.414214,1.414214,1.414214,1.414214,1.989130,2.236472,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.446736,1.568375,1.414214,1.414214,1.414214,1.414214,1.414214,2.430980,2.756941,2.523601,2.324218,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.738818,1.414214,1.414214,2.358747,2.073187,1.414214,1.414214,3.033388,2.575859,1.414214,3.410489,3.372266,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.912730,2.281064,3.792852,3.738518,3.105492,2.735725,2.157736,4.076393,3.188167,1.414214,1.731529,2.594727,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,3.623385,4.326404,1.752549,1.666957,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.509081,1.414214,1.414214,1.414214,1.414214,1.477320,1.414214,1.414214,1.414214,1.446423,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.576991,1.648135,1.599458,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.507622,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.445486,1.414214,1.629948,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.112466,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.572689,1.873362,1.988449,1.414214,1.414214,1.478237,1.414214,1.414214,1.484031,1.838315,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.566471,1.414214,1.414214,1.474818,1.414214,1.414214,1.414214,1.414214,1.474522,2.113916,1.649886,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.449543,1.990719,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.069043,3.880673,2.414388,2.083835,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.791457,1.414214,1.414214,1.414214,1.414214,1.414214,2.575158,5.321124,4.616944,2.814981,1.605658,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,3.571062,4.411326,3.183914,1.729702,1.859568,4.964554,5.899566,4.504239,4.915271,2.920352,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,4.235609,7.074644,6.762389,5.211169,7.383849,3.286665,5.708992,5.858155,4.904784,3.299969,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.864299,4.864273,6.722278,6.856417,5.667700,8.583673,8.083784,6.400947,3.033782,2.536665,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.768222,4.206181,6.246083,4.907362,6.743728,6.090406,4.088784,1.414214,2.445984,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.755621,2.010137,1.852755,1.414214,1.414214,1.446111,1.580996,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,1.414214,2.015402,1.414214,1.414214,1.414214,1.414214,1.414214,2.545749,1.414214,1.414214,1.414214,1.414214,1.414214};
    
    Matrix * Omega = [[Matrix alloc] initFromRowMajorData:saliencyMatrix_sir withRows:M andColumns:N];
    
    TCropBox c;
    c.left = 0; c.right = 0; c.bottom = 0; c.top = 0;
    RetargetingTask * task = [[RetargetingTask alloc] initWithOmega:Omega
                                                                  M:M
                                                                  N:N
                                                                  W:W_sir
                                                                  H:H_sir
                                                                 Wp:Wp_sir
                                                                 Hp:Hp_sir
                                                                 LW:LW_sir
                                                                 LH:LH_sir
                                                              wregL:0.0
                                                   upsamplingFactor:1.0
                                                       croppingFlag:NO
                                                       croppinAlpha:1.0 croppinBeta:0.0 croppinGamma:0.0 cropBox:c];
    RetargetingSolver *solver = [[RetargetingSolver alloc] init];
    task = [solver solveASAPWithTask:task];
    Matrix * sol = [task.sRows stackTo:task.sCols];
    
    double xsol_sir[50] = {22.730381,22.671502,23.035128,24.397907,24.126253,27.330567,29.241373,25.857199,24.270898,25.828206,33.154592,31.591551,32.352233,31.738569,32.226712,28.818225,25.301918,22.627821,20.853461,20.245024,21.376271,31.866127,33.310925,33.310925,31.736235,11.277670,11.277670,11.277670,11.277670,11.277670,11.277670,11.277670,11.277670,17.404394,20.773952,25.804555,29.532462,30.535866,28.670475,26.121506,26.433279,27.134580,27.179743,27.249170,30.128882,28.698619,25.086904,21.968427,16.894258,12.161570};// now the sol cols/rows order is flipped
    Matrix * sol_sir = [[Matrix alloc] initFromColumnMajorData:xsol_sir withRows:50 andColumns:1];
    Matrix * residual = [sol_sir subtract:sol];
    if(DEBUG_PRINT) [sol printMatrixWithName:@"sol"];
    if(DEBUG_PRINT) [sol_sir printMatrixWithName:@"sol_sir"];
    if(DEBUG_PRINT) printf("SIR-Testcase: L2error: %lf\n",[residual L2Norm]);
    STAssertEqualsWithAccuracy([residual L2Norm], 0.00000, 1e-4, @"Solver for Desktop Comparison");
    
    if(DEBUG_PRINT) [residual printMatrixWithName:@"residual"];
    
    
    // solve again but now with the range solver
//    CVXGenRangeSolver25x25 *testSolver = [[CVXGenRangeSolver25x25 alloc] init];
//    [testSolver test_solver];
    
    task.croppingFlag = YES;
    task.croppingAlpha = 0.2;
    task = [solver solveWithCropping:task];
    sol = [task.sRows stackTo:task.sCols];
    
    sol_sir = [[Matrix alloc] initFromColumnMajorData:xsol_sir withRows:50 andColumns:1];
    residual = [sol_sir subtract:sol];
//    if(DEBUG_PRINT)
        [sol printMatrixWithName:@"sol_with_range_solver"];
    if(DEBUG_PRINT) [sol_sir printMatrixWithName:@"sol_sir"];
//    if(DEBUG_PRINT)
    printf("SIR-Testcase with Range solver: L2error: %lf\n",[residual L2Norm]);
    STAssertEqualsWithAccuracy([residual L2Norm], 0.00000, 1e-4, @"RangeSolver for Desktop Comparison");
    
    if(DEBUG_PRINT) [residual printMatrixWithName:@"residual"];


}

@end
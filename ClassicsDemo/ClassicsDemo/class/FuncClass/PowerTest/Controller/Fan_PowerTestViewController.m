//
//  Fan_PowerTestViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/20.
//

#import "Fan_PowerTestViewController.h"
#include "Fan_CircleProgressView.h"
#include <mach/mach.h>
@interface Fan_PowerTestViewController ()

@property (nonatomic,strong)Fan_CircleProgressView *cpuProgressView;

@property (nonatomic,strong)Fan_CircleProgressView *memoryProgressView;

@end

@implementation Fan_PowerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    Fan_CircleProgressView *cpuProgressView = [[Fan_CircleProgressView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:cpuProgressView];
    self.cpuProgressView = cpuProgressView;
    cpuProgressView.backgroundColor = [UIColor whiteColor];
    
    [cpuProgressView setTileString:@"CPU" value:@"14%"];
    cpuProgressView.value =[Fan_PowerTestViewController cpuUsageForApp] * 100;
    
    
    [self.cpuProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nvView.mas_bottom).mas_offset(50);
        make.trailing.mas_equalTo(self.view.mas_centerX).mas_equalTo(-10);
        make.height.width.mas_equalTo(120);
    }];
    
    
    Fan_CircleProgressView *memoryProgressView = [[Fan_CircleProgressView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:memoryProgressView];
    self.memoryProgressView = memoryProgressView;
    memoryProgressView.backgroundColor = [UIColor whiteColor];
    
    [memoryProgressView setTileString:@"Memory" value:@"14%"];
    memoryProgressView.value = [self applicationMemory]/1024 / 4;
    [memoryProgressView setTileString:@"Memory" value:[NSString stringWithFormat:@"%.2fM",[self applicationMemory]]];
    
    [self.memoryProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cpuProgressView.mas_bottom).mas_offset(50);
        make.trailing.mas_equalTo(self.view.mas_centerX).mas_equalTo(-10);
        make.height.width.mas_equalTo(120);
    }];
    
    [Fan_PowerTestViewController cpuUsageForApp];
    
    [self applicationCPU];
}


// 获取 CPU 使用率
+ (CGFloat)cpuUsageForApp {
    kern_return_t           kr;
    thread_array_t          thread_list;
    mach_msg_type_number_t  thread_count;
    thread_info_data_t      thinfo;
    mach_msg_type_number_t  thread_info_count;
    thread_basic_info_t     basic_info_th;
 
    // 根据当前 task 获取所有线程
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS)
        return -1;
 
    float total_cpu_usage = 0;
    // 遍历所有线程
    for (int i = 0; i < thread_count; i++) {
        thread_info_count = THREAD_INFO_MAX;
        // 获取每一个线程信息
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS)
            return -1;
 
        basic_info_th = (thread_basic_info_t)thinfo;
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            // cpu_usage : Scaled cpu usage percentage. The scale factor is TH_USAGE_SCALE.
            // 宏定义 TH_USAGE_SCALE 返回 CPU 处理总频率：
            total_cpu_usage += basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }
 
    // 注意方法最后要调用 vm_deallocate，防止出现内存泄漏
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
 
    return total_cpu_usage;
}

#define NBYTE_PER_MB (1024 * 1024)
 
 
 
- (double)applicationCPU
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < (int)thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}
 
- (double)applicationMemory
{
    struct mach_task_basic_info info;
    mach_msg_type_number_t count = sizeof(info) / sizeof(integer_t);
    if (task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &count) == KERN_SUCCESS) {
        return info.resident_size / NBYTE_PER_MB;
    }
    return 0;
}
 
- (double)systemCPU
{
    
    kern_return_t kr;
    mach_msg_type_number_t count;
    static host_cpu_load_info_data_t previous_info = {0, 0, 0, 0};
    host_cpu_load_info_data_t info;
    
    count = HOST_CPU_LOAD_INFO_COUNT;
    
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&info, &count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    natural_t user   = info.cpu_ticks[CPU_STATE_USER] - previous_info.cpu_ticks[CPU_STATE_USER];
    natural_t nice   = info.cpu_ticks[CPU_STATE_NICE] - previous_info.cpu_ticks[CPU_STATE_NICE];
    natural_t system = info.cpu_ticks[CPU_STATE_SYSTEM] - previous_info.cpu_ticks[CPU_STATE_SYSTEM];
    natural_t idle   = info.cpu_ticks[CPU_STATE_IDLE] - previous_info.cpu_ticks[CPU_STATE_IDLE];
    natural_t total  = user + nice + system + idle;
    previous_info    = info;
    
    natural_t cpu_processor_count = 0;
    natural_t cpu_processor_info_count = 0;
    processor_info_array_t cpu_processor_infos = NULL;
    host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &cpu_processor_count, &cpu_processor_infos, &cpu_processor_info_count);
 
    return (user + nice + system) * 100.0 * cpu_processor_count / total;
}
 
- (double)systemMemory
{
    vm_statistics64_data_t vmstat;
    natural_t size = HOST_VM_INFO64_COUNT;
    if (host_statistics64(mach_host_self(), HOST_VM_INFO64, (host_info64_t)&vmstat, &size) == KERN_SUCCESS) {
        double free = vmstat.free_count * PAGE_SIZE / NBYTE_PER_MB;
        double wired = vmstat.wire_count * PAGE_SIZE / NBYTE_PER_MB;
        double active = vmstat.active_count * PAGE_SIZE / NBYTE_PER_MB;
        double inactive = vmstat.inactive_count * PAGE_SIZE / NBYTE_PER_MB;
        double compressed = vmstat.compressor_page_count * PAGE_SIZE / NBYTE_PER_MB;
        double total = [NSProcessInfo processInfo].physicalMemory / NBYTE_PER_MB;
        
        return free + inactive;
    }
    return 0;
}




@end

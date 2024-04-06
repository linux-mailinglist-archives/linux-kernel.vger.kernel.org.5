Return-Path: <linux-kernel+bounces-133790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4F89A8BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C0282A64
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF018B1A;
	Sat,  6 Apr 2024 03:49:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84313ACC;
	Sat,  6 Apr 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712375377; cv=none; b=PNTr+bXb7p/6sJESiJuFQ1z625A7XQeNool+CfGrbZo9yFN834fVs6BwyGbRyBjMbu/vlOytnWEeDXOQvsYlIozNsEzCrCZTqLcfW12JAtia7A5d6aL7EVTf/Ivuf7XE+dAsUuCPJ6EG9P6xefDVO6yRA3Dj1BRw5eGAIbfNPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712375377; c=relaxed/simple;
	bh=SQrMGsif1NZfCU157fnmfmNTGjaCekI5jSmhv02F1Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw8Ew6NTlr26qkL4j9ARKpb4PJ9n3VDZA5n9godSOmMy92uXOtiAqLgZ29OSA5sBL1SHEDKT/zX1HMVkZf1HeAjHP1oe4FFADTjmdjV+W2grOjJaERvo8xTz4gfg5cRbAVe+A0lCDVHNnAcAmGDTxXozfxNsbwd0+4kROD2mgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Ax++hJxhBmgMUjAA--.62667S3;
	Sat, 06 Apr 2024 11:49:29 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWRJGxhBmbCF0AA--.16752S3;
	Sat, 06 Apr 2024 11:49:26 +0800 (CST)
Message-ID: <61737619-c07c-4cef-985a-ae7f55e02e44@loongson.cn>
Date: Sat, 6 Apr 2024 11:49:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: Add dev-tools/kmemleak Chinese translation
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403052552.39292-1-tttturtleruss@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240403052552.39292-1-tttturtleruss@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxWRJGxhBmbCF0AA--.16752S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tF1UXrWUZryDWF4rJF4DWrX_yoW8GryfWo
	Z8uay5Cr4kC3WUXr4aqa15Kr42ka18CF42ka13Cr1DGry5XF18G3Wvqas3CFyrA3s8Gan0
	q3WrGayxCa1jkr9xl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUU5E7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU


在 2024/4/3 13:25, Haoyang Liu 写道:
> Translate dev-tools/kmemleak.rst into Chinese and add it into
> zh_CN/dev-tools/index.rst.
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
> v1 -> v2: Adjust line length and keep consistent with the original content
>
>   .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>   .../translations/zh_CN/dev-tools/kmemleak.rst | 229 ++++++++++++++++++
>   2 files changed, 230 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/dev-tools/kmemleak.rst
>
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
> index c2db3e566b1b..9f52b7f452bd 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -22,6 +22,7 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>      sparse
>      gcov
>      kasan
> +   kmemleak
>      gdb-kernel-debugging
>   
>   Todolist:
> @@ -29,7 +30,6 @@ Todolist:
>    - coccinelle
>    - kcov
>    - ubsan
> - - kmemleak
>    - kcsan
>    - kfence
>    - kgdb
> diff --git a/Documentation/translations/zh_CN/dev-tools/kmemleak.rst b/Documentation/translations/zh_CN/dev-tools/kmemleak.rst
> new file mode 100644
> index 000000000000..d248c8428095
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/dev-tools/kmemleak.rst
> @@ -0,0 +1,229 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/dev-tools/kmemleak.rst
> +:Translator: 刘浩阳 Haoyang Liu <tttturtleruss@hust.edu.cn>
> +
> +内核内存泄露检测器
> +==================
> +
> +Kmemleak 提供了一个类似 `可追踪的垃圾收集器 <https://en.wikipedia.org/wiki/Tra
> +cing_garbage_collection>`_ 的方法来检测可能的内核内存泄漏，不同的是孤立对象不会
> +被释放，而是仅通过 /sys/kernel/debug/kmemleak 报告。Valgrind 工具
> +（``memcheck --leak-check``）使用了一种相似的方法来检测用户空间应用中的内存泄
> +露。
> +
> +用法
> +----
> +
> +"Kernel hacking" 中的 CONFIG_DEBUG_KMEMLEAK 必须被启用。一个内核线程每10分钟
> +（默认情况下）扫描一次内存，并且打印出新发现的未被引用的对象个数。
> +如果 ``debugfs`` 没有挂载，则执行::
> +
> +   # mount -t debugfs nodev /sys/kernel/debug/
> +
> +显示所有扫描出的可能的内存泄漏的细节信息::
> +
> +   # cat /sys/kernel/debug/kmemleak
> +
> +启动一次中等程度的内存扫描::
> +
> +   # echo scan > /sys/kernel/debug/kmemleak
> +
> +清空当前所有可能的内存泄露列表::
> +
> +   # echo clear > /sys/kernel/debug/kmemleak
> +
> +当再次读取 ``/sys/kernel/debug/kmemleak`` 文件时，将会输出自上次扫描以来检测到的
> +新的内存泄露。
> +
> +注意，孤立目标是通过被分配时间来排序的，列表开始的对象可能会导致后续的对象都被
> +识别为孤立对象。
> +
> +可以通过写入 ``/sys/kernel/debug/kmemleak`` 文件在运行时修改内存扫描参数。下面是
> +支持的参数：
> +
> +
> +* off
> +    禁用 kmemleak（不可逆）
> +* stack=on
> +    开启任务栈扫描（默认）
> +* stack=off
> +    禁用任务栈扫描
> +* scan=on
> +    开启自动内存扫描线程（默认）
> +* scan=off
> +    关闭自动内存扫描线程
> +* scan=<secs>;
> +    设定自动内存扫描间隔，以秒为单位（默认值为 600，设置为 0 表示停
> +    止自动扫描）
> +* scan
> +    触发一次内存扫描
> +* clear
> +    通过标记所有当前已报告的未被引用对象为灰，从而清空当前可能的内存泄露列
> +    表；如果 kmemleak 被禁用，则释放所有 kmemleak 对象，。
> +* dump=<addr>
> +    输出存储在 <addr> 中的对象信息
> +
> +可以通过在内核命令行中传递 ``kmemleak=off`` 参数从而在启动时禁用 Kmemleak。
> +
> +在 kmemleak 初始化之前就可能会有内存分配或释放，这些操作被存储在一个早期日志缓
> +冲区中。缓冲区的大小通过 CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE 选项配置。
> +
> +如果 CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF 被启用，则 kmemleak 默认被禁用。在内核命
> +令行中传递 ``kmemleak=on`` 参数来开启这个功能。
> +
> +如果出现 "Error while writing to stdout" 或 "write_loop: Invalid argument" 这样
> +的错误，请确认 kmemleak 被正确启用。
> +
> +基础算法
> +--------
> +
> +通过 :c:func:`kmalloc`, :c:func:`vmalloc`, :c:func:`kmem_cache_alloc` 以及同类
> +函数均被跟踪，指针，包括一些额外的信息如大小和栈追踪等，都被存储在红黑树中。
> +对应的释放函数调用也被追踪，并从 kmemleak 数据结构中移除相应指针。
> +
> +对于一个已分配的内存块，如果通过扫描内存（包括保存寄存器）没有发现任何指针指向
> +它的起始地址或者其中的任何位置，则认为这块内存是孤立的。这意味着内核无法将该内
> +存块的地址传递给一个释放内存函数，这块内存便被认为泄露了。
> +
> +扫描算法步骤：
> +
> +   1. 标记所有对象为白色（最后剩下的白色对象被认为是孤立的）
> +   2. 从数据节和栈开始扫描内存，检测每个值是否是红黑树中存储的地址。如果一个指向
> +      白色对象的指针被检测到，则将该对象标记为灰色。
> +   3. 扫描灰色对象引用的其他对象（有些白色对象可能会变为灰色并被添加到灰名单末尾
> +      ）直到灰名单为空。
> +   4. 剩余的白色对象就被认为是孤立的并通过 /sys/kernel/debug/kmemleak 报告。
> +
> +有些指向已分配的内存块的指针存储在内核内部的数据结构中，它们不能被检测为孤立。
> +为了避免这种情况，kmemleak 也存储了指向需要被查找的内存块范围内的任意地址的地址
> +数量，如此一来这些内存便不会被认为泄露。一个例子是 __vmalloc()。
> +
> +用 kmemleak 测试特定部分
> +------------------------
> +
> +在初始化启动阶段 /sys/kernel/debug/kmemleak 的输出可能会很多，这也可能是你在开发
> +时编写的漏洞百出的代码导致的。为了解决这种情况你可以使用 'clear' 命令来清除
> +/sys/kernel/debug/kmemleak 输出的所有的未引用对象。在执行 'clear' 后执行 'scan'
> +可以发现新的未引用对象，这将会有利你测试代码的特定部分。
> +
> +为了用一个空的 kmemleak 测试一个特定部分，执行::
> +
> +   # echo clear > /sys/kernel/debug/kmemleak
> +   ... 测试你的内核或者模块 ...
> +   # echo scan > /sys/kernel/debug/kmemleak
> +
> +然后像平常一样获得报告::
> +
> +   # cat /sys/kernel/debug/kmemleak
> +
> +释放 kmemleak 内核对象
> +----------------------
> +
> +为了允许访问先前发现的内存泄露，当用户禁用或发生致命错误导致 kmemleak
> +被禁用时，内核中的 kmemleak 对象不会被释放。这些对象可能会占用很大
> +一部分物理内存。
> +
> +在这种情况下，你可以用如下命令回收这些内存::
> +
> +   # echo clear > /sys/kernel/debug/kmemleak
> +
> +Kmemleak API
> +------------
> +
> +在 include/linux/kmemleak.h 头文件中查看函数原型：
> +
> +- ``kmemleak_init`` - 初始化 kmemleak
> +- ``kmemleak_alloc`` - 通知一个内存块的分配
> +- ``kmemleak_alloc_percpu`` - 通知一个 percpu 类型的内存分配
> +- ``kmemleak_vmalloc`` - 通知一个使用 vmalloc() 的内存分配
> +- ``kmemleak_free`` - 通知一个内存块的释放
> +- ``kmemleak_free_part`` - 通知一个部分的内存释放
> +- ``kmemleak_free_percpu`` - 通知一个 percpu 类型的内存释放
> +- ``kmemleak_update_trace`` - 更新分配对象过程的栈追踪
> +- ``kmemleak_not_leak`` - 标记一个对象内存为未泄露的
> +- ``kmemleak_ignore`` - 不要扫描或报告某个对象未泄露的
> +- ``kmemleak_scan_area`` - 在内存块中添加扫描区域
> +- ``kmemleak_no_scan`` - 不扫描某个内存块
> +- ``kmemleak_erase`` - 在指针变量中移除某个旧的值
> +- ``kmemleak_alloc_recursive`` - 和 kmemleak_alloc 效果相同但会检查是否有递归的
> +   内存分配
> +- ``kmemleak_free_recursive`` - 和 kmemleak_free 效果相同但会检查是否有递归的
> +   内存释放
> +
> +下列函数使用一个物理地址作为对象指针并且只在地址有一个 lowmem 映射时做出相应的
> +行为：
> +
> +- ``kmemleak_alloc_phys``
> +- ``kmemleak_free_part_phys``
> +- ``kmemleak_ignore_phys``
> +
> +解决假阳性/假阴性
> +-----------------
> +
> +假阴性是指由于在内存扫描中有值指向该对象导致 kmemleak 没有报告的实际存在的内存
> +泄露（孤立对象）。为了减少假阴性的出现次数，kmemleak 提供了 kmemleak_ignore，
> +kmemleak_scan_area，kmemleak_no_scan 和 kmemleak_erase 函数（见上）。
> +任务栈也会增加假阴性的数量并且默认不开启对它们的扫描。
> +
> +假阳性是对象被误报为内存泄露（孤立对象）。对于已知未泄露的对象，kmemleak
> +提供了 kmemleak_not_leak 函数。同时 kmemleak_ignore 可以用于标记已知不包含任何
> +其他指针的内存块，标记后该内存块不会再被扫描。
> +
> +一些被报告的泄露仅仅是暂时的，尤其是在 SMP（对称多处理）系统中，因为其指针
> +暂存在 CPU 寄存器或栈中。Kmemleak 定义了 MSECS_MIN_AGE（默认值为 1000）
> +来表示一个被报告为内存泄露的对象的最小存活时间。
> +
> +限制和缺点
> +----------
> +
> +主要的缺点是内存分配和释放的性能下降。为了避免其他的损失，只有当
> +/sys/kernel/debug/kmemleak 文件被读取时才会进行内存扫描。无论如何，这个工具是出于
> +调试的目标，性能表现可能不是最重要的。
> +
> +为了保持算法简单，kmemleak 寻找指向某个内存块范围中的任何值。这可能会引发假阴性
> +现象的出现。但是，最后一个真正的内存泄露也会变得明显。
> +
> +非指针值的数据是假阴性的另一个来源。在将来的版本中，kmemleak 仅仅会扫
> +描已分配结构体中的指针成员。这个特性会解决上述很多的假阴性情况。
> +
> +Kmemleak 会报告假阳性。这可能发生在某些被分配的内存块不需要被释放的情况下
> +（某些 init_call 函数中），指针的计算是通过其他方法而不是常规的 container_of 宏
> +或是指针被存储在 kmemleak 没有扫描的地方。
> +
> +页分配和 ioremap 不会被追踪。
> +
> +使用 kmemleak-test 测试
> +-----------------------
> +
> +为了检测是否成功启用了 kmemleak，你可以使用一个故意制造内存泄露的模块
> +kmemleak-test。设置 CONFIG_SAMPLE_KMEMLEAK 为模块（不能作为内建模块使用）
> +并且启动启用了 kmemleak 的内核。加载模块并执行一次扫描::
> +
> +   # modprobe kmemleak-test
> +   # echo scan > /sys/kernel/debug/kmemleak
> +
> +注意你可能无法立刻或在第一次扫描后得到结果。当 kmemleak 得到结果，将会输出日
> +志 ``kmemleak: <count of leaks> new suspected memory leaks`` 。然后通过读取文件
> +获取信息::
> +
> +   # cat /sys/kernel/debug/kmemleak
> +   unreferenced object 0xffff89862ca702e8 (size 32):
> +     comm "modprobe", pid 2088, jiffies 4294680594 (age 375.486s)
> +     hex dump (first 32 bytes):
> +       6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> +       6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
> +     backtrace:
> +       [<00000000e0a73ec7>] 0xffffffffc01d2036
> +       [<000000000c5d2a46>] do_one_initcall+0x41/0x1df
> +       [<0000000046db7e0a>] do_init_module+0x55/0x200
> +       [<00000000542b9814>] load_module+0x203c/0x2480
> +       [<00000000c2850256>] __do_sys_finit_module+0xba/0xe0
> +       [<000000006564e7ef>] do_syscall_64+0x43/0x110
> +       [<000000007c873fa6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> +   ...
> +
> +用 ``rmmod kmemleak_test`` 移除模块时也会触发
> +kmemleak 的结果输出。



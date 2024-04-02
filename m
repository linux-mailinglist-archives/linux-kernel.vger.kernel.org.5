Return-Path: <linux-kernel+bounces-127882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06662895231
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87666286C79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD786996C;
	Tue,  2 Apr 2024 11:47:18 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEA945A;
	Tue,  2 Apr 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058437; cv=none; b=PvBGiRKqdDbi6AD2Cex+9sGGPJ4rjYB1ee4Shgm8XLldTO+oHu0YIPOc1k6vbMhaPheEdcSU4LIXqLELW7HjRUtMQd5duKi4J/sjCLtHuG94GYRrjKxKzELEv9s79JH+w5NwpdXlNsIst/o1mnqFsDy9MhcAvnGOiez1GLyZ9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058437; c=relaxed/simple;
	bh=IAzzj57yUwHW2qxH61XVmpp/heEsg1zYjaSL/SV3WTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhlxVgw+n1FHiuQFNTuszYr/+hddaPAOnd80uybZcV4sS4lfBtTtH0G79Kk9gKCmzS6Fg+c6h2cvJ+QQyJaxZvZy48rcR9zrsVaqabZarsYMldqRfGR1JpjDN/dJEHyh0oCGBGFm7Ahww9fPYLSF8UF+nahNxXvySZYhFF+Cfao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Cxbes98AtmEVAiAA--.13476S3;
	Tue, 02 Apr 2024 19:47:09 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjhM78Atmmc5xAA--.32953S3;
	Tue, 02 Apr 2024 19:47:07 +0800 (CST)
Message-ID: <2932e9f7-5d5f-4331-8043-7aa85e9044a4@loongson.cn>
Date: Tue, 2 Apr 2024 19:47:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: core-api: Update translation of workqueue.rst
 to 6.9-rc1
To: Xingyou Chen <rockrush@rockwork.org>, alexs@kernel.org, corbet@lwn.net
Cc: zhoubinbin@loongson.cn, tj@kernel.org, wangjinchao@xfusion.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240331172116.257780-1-rockrush@rockwork.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240331172116.257780-1-rockrush@rockwork.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjhM78Atmmc5xAA--.32953S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfZF1fAw4DCr1DGrWfJr1fGrX_yoW8KryrAo
	Wava1Ykw48G3Z8t3sFvanrJ34jvw15GF4fAr1kurnIvFy5GwsYv3WkAanFgr4fCr4rKF15
	CFyxX3y5J3WIq3Zxl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzcTmUUUUU

Hi xingyou,

在 2024/4/1 01:21, Xingyou Chen 写道:
> Significant changes have been made to workqueue, and there are staging
> works transferring from tasklet, while the current translation doesn't
> include description around WQ_BH, an update seems to be helpful.
>
> Synchronize translation from upstream commit 3bc1e711c26b
> ("workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1 ordered")
It seems that you cannot pass the build test. You need to find a way to 
silence these warnings


/home/siyanteng/doc/linux/Documentation/core-api/workqueue:776: 
/include/linux/workqueue.h:493: WARNING: Inline literal start-string 
without end-string

..


You need to follow the steps below:

$ ./scripts/sphinx-pre-install

      install them.

$ make cleandocs

$ make htmldocs

     silence warnings



Thanks,

Yanteng

>
> Signed-off-by: Xingyou Chen <rockrush@rockwork.org>
> ---
>   .../translations/zh_CN/core-api/workqueue.rst | 398 ++++++++++++++++--
>   1 file changed, 371 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/core-api/workqueue.rst b/Documentation/translations/zh_CN/core-api/workqueue.rst
> index 7fac6f75d078..0b52e1187151 100644
> --- a/Documentation/translations/zh_CN/core-api/workqueue.rst
> +++ b/Documentation/translations/zh_CN/core-api/workqueue.rst
> @@ -7,12 +7,13 @@
>   
>    司延腾 Yanteng Si <siyanteng@loongson.cn>
>    周彬彬 Binbin Zhou <zhoubinbin@loongson.cn>
> + 陈兴友 Xingyou Chen <rockrush@rockwork.org>
>   
>   .. _cn_workqueue.rst:
>   
> -=========================
> -并发管理的工作队列 (cmwq)
> -=========================
> +========
> +工作队列
> +========
>   
>   :日期: September, 2010
>   :作者: Tejun Heo <tj@kernel.org>
> @@ -22,7 +23,7 @@
>   简介
>   ====
>   
> -在很多情况下，需要一个异步进程的执行环境，工作队列（wq）API是这种情况下
> +在很多情况下，需要一个异步的程序执行环境，工作队列（wq）API是这种情况下
>   最常用的机制。
>   
>   当需要这样一个异步执行上下文时，一个描述将要执行的函数的工作项（work，
> @@ -34,8 +35,8 @@
>   队列时，工作者又开始执行。
>   
>   
> -为什么要cmwq?
> -=============
> +为什么要有并发管理工作队列?
> +===========================
>   
>   在最初的wq实现中，多线程（MT）wq在每个CPU上有一个工作者线程，而单线程
>   （ST）wq在全系统有一个工作者线程。一个MT wq需要保持与CPU数量相同的工
> @@ -73,9 +74,11 @@
>   向该函数的工作项，并在工作队列中排队等待该工作项。（就是挂到workqueue
>   队列里面去）
>   
> -特定目的线程，称为工作线程（工作者），一个接一个地执行队列中的功能。
> -如果没有工作项排队，工作者线程就会闲置。这些工作者线程被管理在所谓
> -的工作者池中。
> +工作项可以在线程或BH(软中断)上下文中执行。
> +
> +对于由线程执行的工作队列，被称为（内核）工作者（[k]worker）的特殊
> +线程会依次执行其中的函数。如果没有工作项排队，工作者线程就会闲置。
> +这些工作者线程被管理在所谓的工作者池中。
>   
>   cmwq设计区分了面向用户的工作队列，子系统和驱动程序在上面排队工作，
>   以及管理工作者池和处理排队工作项的后端机制。
> @@ -84,6 +87,10 @@ cmwq设计区分了面向用户的工作队列，子系统和驱动程序在上
>   优先级的工作项，还有一些额外的工作者池，用于服务未绑定工作队列的工
>   作项目——这些后备池的数量是动态的。
>   
> +BH工作队列使用相同的结构。然而，由于同一时间只可能有一个执行上下文，
> +不需要担心并发问题。每个CPU上的BH工作者池只包含一个用于表示BH执行
> +上下文的虚拟工作者。BH工作队列可以被看作软中断的便捷接口。
> +
>   当他们认为合适的时候，子系统和驱动程序可以通过特殊的
>   ``workqueue API`` 函数创建和排队工作项。他们可以通过在工作队列上
>   设置标志来影响工作项执行方式的某些方面，他们把工作项放在那里。这些
> @@ -95,9 +102,9 @@ cmwq设计区分了面向用户的工作队列，子系统和驱动程序在上
>   否则一个绑定的工作队列的工作项将被排在与发起线程运行的CPU相关的普
>   通或高级工作工作者池的工作项列表中。
>   
> -对于任何工作者池的实施，管理并发水平（有多少执行上下文处于活动状
> -态）是一个重要问题。最低水平是为了节省资源，而饱和水平是指系统被
> -充分使用。
> +对于任何线程池的实施，管理并发水平（有多少执行上下文处于活动状
> +态）是一个重要问题。cmwq试图将并发保持在一个尽可能低且充足的
> +水平。最低水平是为了节省资源，而充足是为了使系统能被充分使用。
>   
>   每个与实际CPU绑定的worker-pool通过钩住调度器来实现并发管理。每当
>   一个活动的工作者被唤醒或睡眠时，工作者池就会得到通知，并跟踪当前可
> @@ -140,6 +147,17 @@ workqueue将自动创建与属性相匹配的后备工作者池。调节并发
>   ``flags``
>   ---------
>   
> +``WQ_BH``
> +  BH工作队列可以被看作软中断的便捷接口。它总是每个CPU一份，
> +  其中的各个工作项也会按在队列中的顺序，被所属CPU在软中断
> +  上下文中执行。
> +
> +  BH工作队列的 ``max_active`` 值必须为0，且只能单独或和
> +  ``WQ_HIGHPRI`` 标志组合使用。
> +
> +  BH工作项不可以睡眠。像延迟排队、冲洗、取消等所有其他特性
> +  都是支持的。
> +
>   ``WQ_UNBOUND``
>     排队到非绑定wq的工作项由特殊的工作者池提供服务，这些工作者不
>     绑定在任何特定的CPU上。这使得wq表现得像一个简单的执行环境提
> @@ -184,25 +202,21 @@ workqueue将自动创建与属性相匹配的后备工作者池。调节并发
>   --------------
>   
>   ``@max_active`` 决定了每个CPU可以分配给wq的工作项的最大执行上
> -下文数量。例如，如果 ``@max_active为16`` ，每个CPU最多可以同
> -时执行16个wq的工作项。
> +下文数量。例如，如果 ``@max_active`` 为16 ，每个CPU最多可以同
> +时执行16个wq的工作项。它总是每CPU属性，即便对于未绑定 wq。
>   
> -目前，对于一个绑定的wq， ``@max_active`` 的最大限制是512，当指
> -定为0时使用的默认值是256。对于非绑定的wq，其限制是512和
> -4 * ``num_possible_cpus()`` 中的较高值。这些值被选得足够高，所
> -以它们不是限制性因素，同时会在失控情况下提供保护。
> +``@max_active`` 的最大限制是512，当指定为0时使用的默认值是256。
> +这些值被选得足够高，所以它们不是限制性因素，同时会在失控情况下提供
> +保护。
>   
>   一个wq的活动工作项的数量通常由wq的用户来调节，更具体地说，是由用
>   户在同一时间可以排列多少个工作项来调节。除非有特定的需求来控制活动
>   工作项的数量，否则建议指定 为"0"。
>   
> -一些用户依赖于ST wq的严格执行顺序。 ``@max_active`` 为1和 ``WQ_UNBOUND``
> -的组合用来实现这种行为。这种wq上的工作项目总是被排到未绑定的工作池
> -中，并且在任何时候都只有一个工作项目处于活动状态，从而实现与ST wq相
> -同的排序属性。
> -
> -在目前的实现中，上述配置只保证了特定NUMA节点内的ST行为。相反，
> -``alloc_ordered_workqueue()`` 应该被用来实现全系统的ST行为。
> +一些用户依赖于任意时刻最多只有一个工作项被执行，且各工作项被按队列中
> +顺序处理带来的严格执行顺序。``@max_active`` 为1和 ``WQ_UNBOUND``
> +的组合曾被用来实现这种行为，现在不用了。请使用
> +``alloc_ordered_workqueue()`` 。
>   
>   
>   执行场景示例
> @@ -285,7 +299,7 @@ And with cmwq with ``@max_active`` >= 3, ::
>   * 除非有特殊需要，建议使用0作为@max_active。在大多数使用情
>     况下，并发水平通常保持在默认限制之下。
>   
> -* 一个wq作为前进进度保证（WQ_MEM_RECLAIM，冲洗（flush）和工
> +* 一个wq作为前进进度保证，``WQ_MEM_RECLAIM`` ，冲洗（flush）和工
>     作项属性的域。不涉及内存回收的工作项，不需要作为工作项组的一
>     部分被刷新，也不需要任何特殊属性，可以使用系统中的一个wq。使
>     用专用wq和系统wq在执行特性上没有区别。
> @@ -294,6 +308,337 @@ And with cmwq with ``@max_active`` >= 3, ::
>     益的，因为wq操作和工作项执行中的定位水平提高了。
>   
>   
> +亲和性作用域
> +==========
> +
> +一个非绑定工作队列根据其亲和性作用域来对CPU进行分组以提高缓存
> +局部性。比如如果一个工作队列使用默认的“cache”亲和性作用域，
> +它将根据最后一级缓存的边界来分组处理器。这个工作队列上的工作项
> +将被分配给一个与发起CPU共用最后级缓存的处理器上的工作者。根据
> +``affinity_strict`` 的设置，工作者在启动后可能被允许移出
> +所在作用域，也可能不被允许。
> +
> +工作队列目前支持以下亲和性作用域。
> +
> +``default``
> +  使用模块参数 ``workqueue.default_affinity_scope`` 指定
> +  的作用域，该参数总是会被设为以下作用域中的一个。
> +
> +``cpu``
> +  CPU不被分组。一个CPU上发起的工作项会被同一CPU上的工作者执行。
> +  这使非绑定工作队列表现得像是不含并发管理的每CPU工作队列。
> +
> +``smt``
> +  CPU被按SMT边界分组。这通常意味着每个物理CPU核上的各逻辑CPU会
> +  被分进同一组。
> +
> +``cache``
> +  CPU被按缓存边界分组。采用哪个缓存边界由架构代码决定。很多情况
> +  下会使用L3。这是默认的亲和性作用域。
> +
> +``numa``
> +  CPU被按NUMA边界分组。
> +
> +``system``
> +  所有CPU被放在同一组。工作队列不尝试在临近发起CPU的CPU上运行
> +  工作项。
> +
> +默认的亲和性作用域可以被模块参数 ``workqueue.default_affinity_scope``
> +修改，特定工作队列的亲和性作用域可以通过 ``apply_workqueue_attrs()``
> +被更改。
> +
> +如果设置了 ``WQ_SYSFS`` ，工作队列会在它的 ``/sys/devices/virtual/workqueue/WQ_NAME/``
> +目录中有以下亲和性作用域相关的接口文件。
> +
> +``affinity_scope``
> +  读操作以查看当前的亲和性作用域。写操作用于更改设置。
> +
> +  当前作用域是默认值时，当前生效的作用域也可以被从这个文件中
> +  读到（小括号内），例如 ``default (cache)`` 。
> +
> +``affinity_strict``
> +  默认值0表明亲和性作用域不是严格的。当一个工作项开始执行时，
> +  工作队列尽量尝试使工作者处于亲和性作用域内，称为遣返。启动后，
> +  调度器可以自由地将工作者调度到系统中任意它认为合适的地方去。
> +  这使得在保留使用其他CPU（如果必需且有可用）能力的同时，
> +  还能从作用域局部性上获益。
> +
> +  如果设置为1，作用域内的所有工作者将被保证总是处于作用域内。
> +  这在跨亲和性作用域会导致如功耗、负载隔离等方面的潜在影响时
> +  会有用。严格的NUMA作用域也可用于和旧版内核中工作队列的行为
> +  保持一致。
> +
> +
> +亲和性作用域与性能
> +===============
> +
> +如果非绑定工作队列的行为对绝大多数使用场景来说都是最优的，
> +不需要更多调节，就完美了。很不幸，在当前内核中，重度使用
> +工作队列时，需要在局部性和利用率间显式地作一个明显的权衡。
> +
> +更高的局部性带来更高效率，也就是相同数量的CPU周期内可以做
> +更多工作。然而，如果发起者没能将工作项充分地分散在亲和性
> +作用域间，更高的局部性也可能带来更低的整体系统利用率。以下
> +dm-crypt 的性能测试清楚地阐明了这一取舍。
> +
> +测试运行在一个12核24线程、4个L3缓存的处理器（AMD Ryzen
> +9 3900x）上。为保持一致性，关闭CPU超频。 ``/dev/dm-0``
> +是NVME SSD（三星 990 PRO）上创建，用 ``cryptsetup``
> +以默认配置打开的一个 dm-crypt 设备。
> +
> +
> +场景 1: 机器上遍布着有充足的发起者和工作量
> +------------------------------------
> +
> +使用命令：::
> +
> +  $ fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k --ioengine=libaio \
> +    --iodepth=64 --runtime=60 --numjobs=24 --time_based --group_reporting \
> +    --name=iops-test-job --verify=sha512
> +
> +这里有24个发起者，每个同时发起64个IO。 ``--verify=sha512``
> +使得 ``fio`` 每次生成和读回内容受发起者和 ``kcryptd``
> +间的执行局部性影响。下面是基于不同 ``kcryptd`` 的亲和性
> +作用域设置，各经过五次测试得到的读取带宽和CPU利用率数据。
> +
> +.. list-table::
> +   :widths: 16 20 20
> +   :header-rows: 1
> +
> +   * - 亲和性
> +     - 带宽 (MiBps)
> +     - CPU利用率（%）
> +
> +   * - system
> +     - 1159.40 ±1.34
> +     - 99.31 ±0.02
> +
> +   * - cache
> +     - 1166.40 ±0.89
> +     - 99.34 ±0.01
> +
> +   * - cache (strict)
> +     - 1166.00 ±0.71
> +     - 99.35 ±0.01
> +
> +在系统中分布着足够多发起者的情况下，不论严格与否，“cache”
> +没有表现得更差。三种配置均使整个机器达到饱和，但由于提高了
> +局部性，缓存相关的两种有0.6%的（带宽）提升。
> +
> +
> +场景 2: 更少发起者，足以达到饱和的工作量
> +----------------------------------
> +
> +使用命令：::
> +
> +  $ fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
> +    --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=8 \
> +    --time_based --group_reporting --name=iops-test-job --verify=sha512
> +
> +与上一个场景唯一的区别是 ``--numjobs=8``。 发起者数量
> +减少为三分之一，但仍然有足以使系统达到饱和的工作总量。
> +
> +.. list-table::
> +   :widths: 16 20 20
> +   :header-rows: 1
> +
> +   * - 亲和性
> +     - 带宽 (MiBps)
> +     - CPU利用率（%）
> +
> +   * - system
> +     - 1155.40 ±0.89
> +     - 97.41 ±0.05
> +
> +   * - cache
> +     - 1154.40 ±1.14
> +     - 96.15 ±0.09
> +
> +   * - cache (strict)
> +     - 1112.00 ±4.64
> +     - 93.26 ±0.35
> +
> +这里有超过使系统达到饱和所需的工作量。“system”和“cache”
> +都接近但并未使机器完全饱和。“cache”消耗更少的CPU但更高的
> +效率使其得到和“system”相同的带宽。
> +
> +八个发起者盘桓在四个L3缓存作用域间仍然允许“cache (strict)”
> +几乎使机器饱和，但缺少对工作的保持（不移到空闲处理器上）
> +开始带来3.7%的带宽损失。
> +
> +
> +场景 3: 更少发起者，不充足的工作量
> +-----------------------------
> +
> +使用命令：::
> +
> +  $ fio --filename=/dev/dm-0 --direct=1 --rw=randrw --bs=32k \
> +    --ioengine=libaio --iodepth=64 --runtime=60 --numjobs=4 \
> +    --time_based --group_reporting --name=iops-test-job --verify=sha512
> +
> +再次，唯一的区别是 ``--numjobs=4``。由于发起者减少到四个，
> +现在没有足以使系统饱和的工作量，带宽变得依赖于完成时延。
> +
> +.. list-table::
> +   :widths: 16 20 20
> +   :header-rows: 1
> +
> +   * - 亲和性
> +     - 带宽 (MiBps)
> +     - CPU利用率（%）
> +
> +   * - system
> +     - 993.60 ±1.82
> +     - 75.49 ±0.06
> +
> +   * - cache
> +     - 973.40 ±1.52
> +     - 74.90 ±0.07
> +
> +   * - cache (strict)
> +     - 828.20 ±4.49
> +     - 66.84 ±0.29
> +
> +现在，局部性和利用率间的权衡更清晰了。“cache”展示出相比
> +“system”2%的带宽损失，而“cache (strict)”跌到20%。
> +
> +
> +结论和建议
> +---------
> +
> +在以上试验中，虽然一致并且也明显，但“cache”亲和性作用域
> +相比“system”的性能优势并不大。然而，这影响是依赖于作用域
> +间距离的，在更复杂的处理器拓扑下可能有更明显的影响。
> +
> +虽然这些情形下缺少工作保持是有坏处的，但比“cache (strict)”
> +好多了，而且最大化工作队列利用率的需求也并不常见。因此，
> +“cache”是非绑定池的默认亲和性作用域。
> +
> +* 由于不存在一个适用于大多数场景的选择，对于可能需要消耗
> +  大量CPU的工作队列，建议通过 ``apply_workqueue_attrs()``
> +  进行（专门）配置，并考虑是否启用 ``WQ_SYSFS``。
> +
> +* 设置了严格“cpu”亲和性作用域的非绑定工作队列，它的行为与
> +  ``WQ_CPU_INTENSIVE`` 每CPU工作队列一样。后者没有真正
> +  优势，而前者提供了大幅度的灵活性。
> +
> +* 亲和性作用域是从Linux v6.5起引入的。为了模拟旧版行为，
> +  可以使用严格的“numa”亲和性作用域。
> +
> +* 不严格的亲和性作用域中，缺少工作保持大概缘于调度器。内核
> +  为什么没能维护好大多数场景下的工作保持，把事情作对，还没有
> +  理论上的解释。因此，未来调度器的改进可能会使我们不再需要
> +  这些调节项。
> +
> +
> +检查配置
> +=======
> +
> +使用 tools/workqueue/wq_dump.py（drgn脚本） 来检查未
> +绑定CPU的亲和性配置，工作者池，以及工作队列如何映射到池上: ::
> +
> +  $ tools/workqueue/wq_dump.py
> +  Affinity Scopes
> +  ===============
> +  wq_unbound_cpumask=0000000f
> +
> +  CPU
> +    nr_pods  4
> +    pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008
> +    pod_node [0]=0 [1]=0 [2]=1 [3]=1
> +    cpu_pod  [0]=0 [1]=1 [2]=2 [3]=3
> +
> +  SMT
> +    nr_pods  4
> +    pod_cpus [0]=00000001 [1]=00000002 [2]=00000004 [3]=00000008
> +    pod_node [0]=0 [1]=0 [2]=1 [3]=1
> +    cpu_pod  [0]=0 [1]=1 [2]=2 [3]=3
> +
> +  CACHE (default)
> +    nr_pods  2
> +    pod_cpus [0]=00000003 [1]=0000000c
> +    pod_node [0]=0 [1]=1
> +    cpu_pod  [0]=0 [1]=0 [2]=1 [3]=1
> +
> +  NUMA
> +    nr_pods  2
> +    pod_cpus [0]=00000003 [1]=0000000c
> +    pod_node [0]=0 [1]=1
> +    cpu_pod  [0]=0 [1]=0 [2]=1 [3]=1
> +
> +  SYSTEM
> +    nr_pods  1
> +    pod_cpus [0]=0000000f
> +    pod_node [0]=-1
> +    cpu_pod  [0]=0 [1]=0 [2]=0 [3]=0
> +
> +  Worker Pools
> +  ============
> +  pool[00] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  0
> +  pool[01] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  0
> +  pool[02] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  1
> +  pool[03] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  1
> +  pool[04] ref= 1 nice=  0 idle/workers=  4/  4 cpu=  2
> +  pool[05] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  2
> +  pool[06] ref= 1 nice=  0 idle/workers=  3/  3 cpu=  3
> +  pool[07] ref= 1 nice=-20 idle/workers=  2/  2 cpu=  3
> +  pool[08] ref=42 nice=  0 idle/workers=  6/  6 cpus=0000000f
> +  pool[09] ref=28 nice=  0 idle/workers=  3/  3 cpus=00000003
> +  pool[10] ref=28 nice=  0 idle/workers= 17/ 17 cpus=0000000c
> +  pool[11] ref= 1 nice=-20 idle/workers=  1/  1 cpus=0000000f
> +  pool[12] ref= 2 nice=-20 idle/workers=  1/  1 cpus=00000003
> +  pool[13] ref= 2 nice=-20 idle/workers=  1/  1 cpus=0000000c
> +
> +  Workqueue CPU -> pool
> +  =====================
> +  [    workqueue \ CPU              0  1  2  3 dfl]
> +  events                   percpu   0  2  4  6
> +  events_highpri           percpu   1  3  5  7
> +  events_long              percpu   0  2  4  6
> +  events_unbound           unbound  9  9 10 10  8
> +  events_freezable         percpu   0  2  4  6
> +  events_power_efficient   percpu   0  2  4  6
> +  events_freezable_power_  percpu   0  2  4  6
> +  rcu_gp                   percpu   0  2  4  6
> +  rcu_par_gp               percpu   0  2  4  6
> +  slub_flushwq             percpu   0  2  4  6
> +  netns                    ordered  8  8  8  8  8
> +  ...
> +
> +参见命令的帮助消息以获取更多信息。
> +
> +
> +监视
> +====
> +
> +使用 tools/workqueue/wq_monitor.py 来监视工作队列的运行： ::
> +
> +  $ tools/workqueue/wq_monitor.py events
> +                              total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
> +  events                      18545     0      6.1       0       5       -       -
> +  events_highpri                  8     0      0.0       0       0       -       -
> +  events_long                     3     0      0.0       0       0       -       -
> +  events_unbound              38306     0      0.1       -       7       -       -
> +  events_freezable                0     0      0.0       0       0       -       -
> +  events_power_efficient      29598     0      0.2       0       0       -       -
> +  events_freezable_power_        10     0      0.0       0       0       -       -
> +  sock_diag_events                0     0      0.0       0       0       -       -
> +
> +                              total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
> +  events                      18548     0      6.1       0       5       -       -
> +  events_highpri                  8     0      0.0       0       0       -       -
> +  events_long                     3     0      0.0       0       0       -       -
> +  events_unbound              38322     0      0.1       -       7       -       -
> +  events_freezable                0     0      0.0       0       0       -       -
> +  events_power_efficient      29603     0      0.2       0       0       -       -
> +  events_freezable_power_        10     0      0.0       0       0       -       -
> +  sock_diag_events                0     0      0.0       0       0       -       -
> +
> +  ...
> +
> +参见命令的帮助消息以获取更多信息。
> +
> +
>   调试
>   ====
>   
> @@ -330,7 +675,6 @@ And with cmwq with ``@max_active`` >= 3, ::
>   
>   工作队列保证，如果在工作项排队后满足以下条件，则工作项不能重入：
>   
> -
>           1. 工作函数没有被改变。
>           2. 没有人将该工作项排到另一个工作队列中。
>           3. 该工作项尚未被重新启动。



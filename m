Return-Path: <linux-kernel+bounces-102849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B143987B7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A306B1C20DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53642072;
	Thu, 14 Mar 2024 05:59:59 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2823C464;
	Thu, 14 Mar 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395998; cv=none; b=euqaF1998KZfw3I2rH3V8iB36++kcbj9L1CZLeu330iNjRMZMPq8CCmX2J9IBNttdZIaHO36vPEA5jjn4pnUUYywdHVY7R3ztUviM9DiWknzPD6ZncJXDGZTeaQSihW9EiqM3zum2gyk65uVwSazczdQl+rRfbnShvSJp88zeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395998; c=relaxed/simple;
	bh=1B4t1nZ+bMa1THF1ZkPv7BtvBPdoV1xxKH8iSMbROto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncMvWKrjbNKXVRwF6rTYw2F+lb/qJpPGQIJeeXCx0lKoWJnIx1MNvu6DfKNwM6w6ux/UHumfrHIF+kQ6xj2pTMu7By1nmumuXj0ibCQG80FgT7Hz9iF/3brupayrp0bJuBBHiA4E9CLpTM3mu7QNUJGd/oT1AGtRfZYUj2Dw5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAAnXoIgkvJl6QLYAw--.37422S2;
	Thu, 14 Mar 2024 13:58:56 +0800 (CST)
Received: from [172.19.193.108] (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCXkL8ckvJl0hP9AA--.49473S2;
	Thu, 14 Mar 2024 13:58:53 +0800 (CST)
Message-ID: <421183dd-73d4-43b1-bfb3-f7c7db7d82cb@hust.edu.cn>
Date: Thu, 14 Mar 2024 13:58:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Add dev-tools/ubsan Chinese translation
To: Yanteng Si <siyanteng@loongson.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240302140058.1527765-1-dzm91@hust.edu.cn>
 <26730f76-871d-4a6d-8b16-ea3e52ef5357@loongson.cn>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <26730f76-871d-4a6d-8b16-ea3e52ef5357@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAAnXoIgkvJl6QLYAw--.37422S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1rCr1kGF15ArW7tw4UXFb_yoW7Kw15pr
	n5KFWxGrW8JryrJr1UKF15JFyjyr18A3ZrJrn2qF1jqF1qkr1Yqr12qryqgr9rWrW8AFy7
	JFnFgF42vr12k3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26F4j6r4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Kg43UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

ping?

On 2024/3/6 17:15, Yanteng Si wrote:
>
> 在 2024/3/2 22:00, Dongliang Mu 写道:
>> Translate dev-tools/ubsan.rst into Chinese, add it into
>> zh_CN/dev-tools/index.rst.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>
>
> Thanks,
>
> Yanteng
>
>> ---
>>   .../translations/zh_CN/dev-tools/index.rst    |  2 +-
>>   .../translations/zh_CN/dev-tools/ubsan.rst    | 91 +++++++++++++++++++
>>   2 files changed, 92 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> Documentation/translations/zh_CN/dev-tools/ubsan.rst
>>
>> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst 
>> b/Documentation/translations/zh_CN/dev-tools/index.rst
>> index c2db3e566b1b..c4463f0750f0 100644
>> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
>> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
>> @@ -22,13 +22,13 @@ 
>> Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>>      sparse
>>      gcov
>>      kasan
>> +   ubsan
>>      gdb-kernel-debugging
>>
>>   Todolist:
>>
>>    - coccinelle
>>    - kcov
>> - - ubsan
>>    - kmemleak
>>    - kcsan
>>    - kfence
>> diff --git a/Documentation/translations/zh_CN/dev-tools/ubsan.rst 
>> b/Documentation/translations/zh_CN/dev-tools/ubsan.rst
>> new file mode 100644
>> index 000000000000..2487696b3772
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/dev-tools/ubsan.rst
>> @@ -0,0 +1,91 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/dev-tools/ubsan.rst
>> +:Translator: Dongliang Mu <dzm91@hust.edu.cn>
>> +
>> +未定义行为消毒剂 - UBSAN
>> +====================================
>> +
>> +UBSAN是一种动态未定义行为检查工具。
>> +
>> +UBSAN使用编译时插桩捕捉未定义行为。编译器在可能导致未定义行为的操作前插入特定 
>>
>> +检测代码。如果检查失败，即检测到未定义行为，__ubsan_handle_* 
>> 函数将被调用打印
>> +错误信息。
>> +
>> +GCC自4.9.x [1_] （详见 ``-fsanitize=undefined`` 
>> 选项及其子选项）版本后引入这
>> +一特性。GCC 5.x 版本实现了更多检查器 [2_]。
>> +
>> +报告样例
>> +--------------
>> +
>> +::
>> +
>> + 
>> ================================================================================
>> +     UBSAN: Undefined behaviour in ../include/linux/bitops.h:110:33
>> +     shift exponent 32 is to large for 32-bit type 'unsigned int'
>> +     CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.0-rc1+ #26
>> +      0000000000000000 ffffffff82403cc8 ffffffff815e6cd6 
>> 0000000000000001
>> +      ffffffff82403cf8 ffffffff82403ce0 ffffffff8163a5ed 
>> 0000000000000020
>> +      ffffffff82403d78 ffffffff8163ac2b ffffffff815f0001 
>> 0000000000000002
>> +     Call Trace:
>> +      [<ffffffff815e6cd6>] dump_stack+0x45/0x5f
>> +      [<ffffffff8163a5ed>] ubsan_epilogue+0xd/0x40
>> +      [<ffffffff8163ac2b>] 
>> __ubsan_handle_shift_out_of_bounds+0xeb/0x130
>> +      [<ffffffff815f0001>] ? radix_tree_gang_lookup_slot+0x51/0x150
>> +      [<ffffffff8173c586>] _mix_pool_bytes+0x1e6/0x480
>> +      [<ffffffff83105653>] ? dmi_walk_early+0x48/0x5c
>> +      [<ffffffff8173c881>] add_device_randomness+0x61/0x130
>> +      [<ffffffff83105b35>] ? dmi_save_one_device+0xaa/0xaa
>> +      [<ffffffff83105653>] dmi_walk_early+0x48/0x5c
>> +      [<ffffffff831066ae>] dmi_scan_machine+0x278/0x4b4
>> +      [<ffffffff8111d58a>] ? vprintk_default+0x1a/0x20
>> +      [<ffffffff830ad120>] ? early_idt_handler_array+0x120/0x120
>> +      [<ffffffff830b2240>] setup_arch+0x405/0xc2c
>> +      [<ffffffff830ad120>] ? early_idt_handler_array+0x120/0x120
>> +      [<ffffffff830ae053>] start_kernel+0x83/0x49a
>> +      [<ffffffff830ad120>] ? early_idt_handler_array+0x120/0x120
>> +      [<ffffffff830ad386>] x86_64_start_reservations+0x2a/0x2c
>> +      [<ffffffff830ad4f3>] x86_64_start_kernel+0x16b/0x17a
>> + 
>> ================================================================================
>> +
>> +用法
>> +-----
>> +
>> +使用如下内核配置启用UBSAN::
>> +
>> +    CONFIG_UBSAN=y
>> +
>> +使用如下内核配置检查整个内核::
>> +
>> +        CONFIG_UBSAN_SANITIZE_ALL=y
>> +
>> +为了在特定文件或目录启动代码插桩，需要在相应的内核Makefile中添加一行类似内容: 
>>
>> +
>> +- 单文件（如main.o）::
>> +
>> +    UBSAN_SANITIZE_main.o := y
>> +
>> +- 一个目录中的所有文件::
>> +
>> +    UBSAN_SANITIZE := y
>> +
>> +即使设置了``CONFIG_UBSAN_SANITIZE_ALL=y``，为了避免文件被插桩，可使用::
>> +
>> +  UBSAN_SANITIZE_main.o := n
>> +
>> +与::
>> +
>> +  UBSAN_SANITIZE := n
>> +
>> +未对齐的内存访问检测可通过开启独立选项 - CONFIG_UBSAN_ALIGNMENT 检测。
>> +该选项在支持未对齐访问的架构上(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y) 
>>
>> +默认为关闭。该选项仍可通过内核配置启用，但它将产生大量的UBSAN报告。
>> +
>> +参考文献
>> +----------
>> +
>> +.. _1: 
>> https://gcc.gnu.org/onlinedocs/gcc-4.9.0/gcc/Debugging-Options.html
>> +.. _2: https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
>> +.. _3: https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html
>> -- 
>> 2.39.2
>>
>>



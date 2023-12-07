Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6580864A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378688AbjLGJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378781AbjLGJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:32:41 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C80A910D1;
        Thu,  7 Dec 2023 01:32:08 -0800 (PST)
Received: from loongson.cn (unknown [112.20.109.254])
        by gateway (Coremail) with SMTP id _____8CxNvEVkXFlmZg_AA--.61338S3;
        Thu, 07 Dec 2023 17:32:05 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.254])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzdwRkXFlzmJXAA--.62155S3;
        Thu, 07 Dec 2023 17:32:01 +0800 (CST)
Message-ID: <8423dcba-9238-438f-b8eb-159262d20175@loongson.cn>
Date:   Thu, 7 Dec 2023 17:32:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Translated the RISC-V architecture boot documentation.
Content-Language: en-US
To:     longjin <longjin@dragonos.org>, alexs@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org
References: <20231206140748.1675409-1-longjin@DragonOS.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20231206140748.1675409-1-longjin@DragonOS.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxzdwRkXFlzmJXAA--.62155S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3JrW3Cry3GF47XFW5KFW3Arc_yoWfKrykpF
        Z3KryxJF13Ary5KF9rKryUu3W8AryfGay7KF18Jry8JrW0yrZrJwsxKFyrG39rWryfAr97
        trW5uFy0yw17C3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8uuWJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Longjin

在 2023/12/6 22:07, longjin 写道:
> The patch adds a new file boot.rst to the Documentation/translations/zh_CN/
> arch/riscv/ directory, and adds a reference to the new file
> in the index.rst file.
>
> Signed-off-by: longjin <longjin@dragonos.org>
>
> ---
>   .../translations/zh_CN/arch/riscv/boot.rst    | 144 ++++++++++++++++++
>   .../translations/zh_CN/arch/riscv/index.rst   |   1 +
>   2 files changed, 145 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/arch/riscv/boot.rst
>
> diff --git a/Documentation/translations/zh_CN/arch/riscv/boot.rst b/Documentation/translations/zh_CN/arch/riscv/boot.rst
> new file mode 100644
> index 000000000000..0fe8fcfc5601
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/arch/riscv/boot.rst
> @@ -0,0 +1,144 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/arch/riscv/boot.rst
> +
> +:翻译:
> +
> + 龙进 Jin Long <longjin@dragonos.org>
> +
> +===============================================
> +RISC-V内核启动要求和约束
> +===============================================

One Chinese char two "=".

One English char one "=".


All subtitle in the following text need to be aligned.

> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +这份文档描述了RISC-V内核对引导加载程序和固件的期望，以及任何开发者在接触早期启动过程时必须
> +牢记的约束。在这份文档中， ``早期启动过程`` 指的是在最终虚拟映射设置之前运行的任何代码。
> +
> +内核预加载的要求和约束
How about 内核预加载的要求和限制？
> +=======================================
> +
> +RISC-V内核对引导加载程序和平台固件有以下要求：
> +
> +寄存器状态
> +--------------
> +
> +RISC-V内核期望：
> +
> +  * ``$a0`` 应包含当前核心的hartid。
> +  * ``$a1`` 应包含内存中设备树的地址。
> +
> +CSR 寄存器状态
> +---------

This can cause errors during document compilation, and it is necessary 
to build testing before sending patches.


see Documentation/translations/zh_CN/doc-guide/sphinx.rst or English of 
sphinx.rst.

> +
> +RISC-V内核期望：
> +
> +  * ``$satp = 0``： 如果存在MMU，必须将其禁用。
> +
> +为常驻固件保留的内存
> +-------------------------------------
> +
> +RISC-V内核在直接映射中不能映射任何常驻内存或用PMPs保护的内存，
> +因此固件必须根据设备树规范 和/或 UEFI规范正确标记这些区域。
> +
> +内核的位置
> +---------------
> +
> +RISC-V内核期望被放置在PMD边界（对于rv64为2MB对齐，对于rv32为4MB对齐）。
> +请注意，如果不是这样，EFI stub 将重定位内核。
> +
> +硬件描述
> +--------------------
> +
> +固件可以将设备树或ACPI表传递给RISC-V内核。
> +
> +设备树可以直接从前一阶段通过$a1寄存器传递给内核，或者在使用UEFI启动时，可以通过EFI配置表传递。
> +
> +ACPI表通过EFI配置表传递给内核。在这种情况下，EFI stub 仍然会创建一个小的设备树。
> +请参阅下面的"EFI stub 和设备树"部分，了解这个设备树的详细信息。
> +
> +内核入口
> +------------
> +
> +在SMP系统中，有两种方法可以进入内核：
> +
> +在SMP系统中，有两种方法可以进入内核：
Remove one.
> +
> +- ``RISCV_BOOT_SPINWAIT``：固件在内核中释放所有的hart，一个hart赢得抽奖并执行早期启动代码，
> +而其他的hart则停在那里等待初始化完成。这种方法主要用于支持没有SBI HSM扩展和M模式RISC-V内核的旧固件。
We need a space here, otherwise the compiled result will not be what we 
expect.
> +- ``有序启动``：固件只释放一个将执行初始化阶段的hart，然后使用SBI HSM扩展启动所有其他的hart。
> +有序启动方法是启动RISC-V内核的首选启动方法，因为它可以支持CPU热插拔和kexec。
> +
> +UEFI
> +----
> +
> +UEFI 内存映射
> +~~~~~~~~~~~~~~~
> +
> +使用UEFI启动时，RISC-V内核将只使用EFI内存映射来填充系统内存。
> +
> +UEFI固件必须解析 ``/reserved-memory`` 设备树节点的子节点，并遵守设备树规范，将这些子节点的属性
> +（ ``no-map`` 和 ``reusable`` ）转换为其正确的EFI等价物（参见设备树规范v0.4-rc1的"3.5.4
> +/reserved-memory和UEFI"部分）。
> +
> +RISCV_EFI_BOOT_PROTOCOL
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +使用UEFI启动时，EFI stub 需要引导hartid以便将其传递给 ``$a1`` 中的RISC-V内核。
> +EFI stub使用以下方法之一获取引导hartid：
> +
> +- ``RISCV_EFI_BOOT_PROTOCOL``（**首选**）。
> +- ``boot-hartid``设备树子节点（**已弃用**）。
> +
> +任何新的固件都必须实现 ``RISCV_EFI_BOOT_PROTOCOL``，因为基于设备树的方法现已被弃用。
> +
> +早期启动的要求和约束
> +=======================================
> +
> +RISC-V内核的早期启动过程遵循以下约束：
> +
> +EFI stub 和设备树
> +-----------------------
> +
> +使用UEFI启动时，EFI stub 会用与arm64相同的参数补充（或创建）设备树，
> +这些参数在Documentation/arch/arm/uefi.rst中的"UEFI kernel support on ARM"段落中有描述。
> +
> +虚拟映射安装
> +----------------------------
> +
> +在RISC-V内核中，虚拟映射的安装分为两步进行：
> +
> +1. ``setup_vm()``在 ``early_pg_dir``中安装一个临时的内核映射，这允许发现系统内存。
> +此时只有内核文本/数据被映射。在建立这个映射时，不能进行分配（因为系统内存还未知），所以
内核代码/数据被映射
> +``early_pg_dir``页表是静态分配的（每个级别只使用一个表）。
> +
> +2. ``setup_vm_final()``在 ``swapper_pg_dir``中创建最终的内核映射，并利用发现的系统内存
> +创建线性映射。在建立这个映射时，内核可以分配内存，但不能直接访问它（因为直接映射还不存在），
> +所以它使用fixmap区域的临时映射来访问新分配的页表级别。
Please refer to the layout and format of the English document and ensure 
consistency.
> +
> +为了让 ``virt_to_phys()``和 ``phys_to_virt()``能够正确地将直接映射地址转换为物理地址，
> +它们需要知道DRAM的起始位置。这发生在步骤1之后，就在步骤2安装直接映射之前
> +（参见arch/riscv/mm/init.c中的 ``setup_bootmem()``函数）。在安装最终虚拟映射之前使用
> +这些宏必须仔细检查。

这些宏时必须仔细检查。

> +
> +通过fixmap进行设备树映射
> +-----------------------------
> +
> +由于 ``reserved_mem``数组是用 ``setup_vm()``建立的虚拟地址初始化的，并且与
> +``setup_vm_final()``建立的映射一起使用，RISC-V内核使用fixmap区域来映射设备树。
> +这确保设备树可以通过两种虚拟映射访问。
> +
> +Pre-MMU执行
> +-----------------
> +
> +在建立第一个虚拟映射之前，需要运行一些代码。这些包括第一个虚拟映射的安装本身，早期替代方案的修补，
> +以及内核命令行的早期解析。这些代码必须非常小心地编译，因为：
> +
> +- ``-fno-pie``：这对于使用``-fPIE``的可重定位内核是必需的，否则，任何对全局符号的访问都将通过
> +GOT进行，而GOT只是虚拟地重新定位。
> +- ``-mcmodel=medany``：任何对全局符号的访问都必须是PC相对的，以避免在设置MMU之前发生任何重定位。
> +- *所有* 的仪表化功能也必须被禁用（包括KASAN，ftrace和其他）。
> +
> +由于使用来自不同编译单元的符号需要用这些标志编译该单元，我们建议尽可能不要使用外部符号。
> diff --git a/Documentation/translations/zh_CN/arch/riscv/index.rst b/Documentation/translations/zh_CN/arch/riscv/index.rst
> index 3b041c116169..96573459105e 100644
> --- a/Documentation/translations/zh_CN/arch/riscv/index.rst
> +++ b/Documentation/translations/zh_CN/arch/riscv/index.rst
> @@ -17,6 +17,7 @@ RISC-V 体系结构
>   .. toctree::
>       :maxdepth: 1
>   
> +    boot
>       boot-image-header
>       vm-layout
>       patch-acceptance

Finally, please adjust the length of each row to make it the same 
length. Each line should be less than 40 characters.


Others,

1, you also need to ./scripts/checkpatch.pl <your patch>

    silence all warnings and errors.

2, Set up your email client without any extra parts.



Thanks,

Yanteng


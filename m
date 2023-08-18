Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D057808C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359308AbjHRJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359363AbjHRJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:38:59 -0400
Received: from email.cn (m218-153.88.com [110.43.218.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2723C23;
        Fri, 18 Aug 2023 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=From:To:Date; bh=9lcI/VTcO7u3Jfok4rz7Q7p8zfxcmR2oP5L13
        pSlhGk=; b=NdeAFIk5+qunpugAYXGcqr1CtNNNTcVOB957rPcqE6fRXHoOCJoNz
        885erK6rPbXHHwfZWLQ+5DJXWLxojIYzxrtcRt8P4XxfteuPbIct+oJR/QvsKYHI
        vs6pjvXCllM8C0tIDPY9D/TVLDN0aHmahyGAnx57LxYBMOnrBhqJe4=
Received: from localhost (unknown [119.3.119.8])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBHwXjlO99kUCwqAA--.20331S3;
        Fri, 18 Aug 2023 17:37:42 +0800 (CST)
From:   Liang Li <liliang6@email.cn>
To:     alexs@kernel.org, siyanteng@loongson.cn, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/mm/zh_CN: a few native ZH revisements
Date:   Fri, 18 Aug 2023 17:37:41 +0800
Message-Id: <20230818093741.359419-1-liliang6@email.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GiKnCgBHwXjlO99kUCwqAA--.20331S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr4xXr1xJF45urW3XrWxCrg_yoW8Wr48Go
        WfAanxCr4kXr45Ga40qayqyFy7ur4vkFs3GwsrGrnFvrZxXr15Ca1kX347AFyqkr98CFn8
        tF1xWa13G3ZFkasxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5-7k0a2IF6w4xM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
        0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
        IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vE
        x4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr4
        1l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUUOz
        VUUUUUU==
X-Originating-IP: [119.3.119.8]
X-CM-SenderInfo: 5oloxttqjwqvhpdlzhdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise some ZH sentences to be more zh-native and try to add blank
space between English words and Chinese chars.

Signed-off-by: Liang Li <liliang6@email.cn>
---
 .../translations/zh_CN/mm/memory-model.rst    | 142 +++++++++---------
 1 file changed, 75 insertions(+), 67 deletions(-)

diff --git a/Documentation/translations/zh_CN/mm/memory-model.rst b/Documentation/translations/zh_CN/mm/memory-model.rst
index 77ec149a970c..a93eaacc286b 100644
--- a/Documentation/translations/zh_CN/mm/memory-model.rst
+++ b/Documentation/translations/zh_CN/mm/memory-model.rst
@@ -13,62 +13,64 @@
 物理内存模型
 ============
 
-系统中的物理内存可以用不同的方式进行寻址。最简单的情况是，物理内存从地址0开
-始，跨越一个连续的范围，直到最大的地址。然而，这个范围可能包含CPU无法访问的
-小孔隙。那么，在完全不同的地址可能有几个连续的范围。而且，别忘了NUMA，即不
-同的内存库连接到不同的CPU。
+系统中的物理内存可以用不同的方式进行寻址。最简单的情况是，物理内存从地址 0 开
+始，跨越一个连续的范围，直到最大的物理内存地址。然而，这个地址范围中可能包含
+CPU 无法访问的小孔隙。那么，物理内存的地址范围可能呈现为几个不同的连续地址范
+围。而且，还有 NUMA，即不同的内存器件连接到不同的 CPU 这种情况。
 
-Linux使用两种内存模型中的一种对这种多样性进行抽象。FLATMEM和SPARSEM。每
-个架构都定义了它所支持的内存模型，默认的内存模型是什么，以及是否有可能手动
-覆盖该默认值。
+Linux 使用两种内存模型中的一种对这种多样性进行抽象：FLATMEM 和 SPARSEMEM。
+每个 Linux 支持的架构都定义了架构所支持的内存模型；默认的内存模型，以及是否
+有可能手动覆盖该默认值。
 
-所有的内存模型都使用排列在一个或多个数组中的 `struct page` 来跟踪物理页
-帧的状态。
+所有的内存模型都使用排列在一个或多个数组中的 `struct page` 来跟踪物理页框的
+状态。
 
 无论选择哪种内存模型，物理页框号（PFN）和相应的 `struct page` 之间都存
 在一对一的映射关系。
 
 每个内存模型都定义了 :c:func:`pfn_to_page` 和 :c:func:`page_to_pfn`
-帮助函数，允许从PFN到 `struct page` 的转换，反之亦然。
+帮助函数，实现 PFN 和 `struct page` 之间的双向转换。
 
 FLATMEM
 =======
 
-最简单的内存模型是FLATMEM。这个模型适用于非NUMA系统的连续或大部分连续的
+最简单的内存模型是 FLATMEM。这个模型适用于非 NUMA 系统的连续或大部分连续的
 物理内存。
 
-在FLATMEM内存模型中，有一个全局的 `mem_map` 数组来映射整个物理内存。对
-于大多数架构，孔隙在 `mem_map` 数组中都有条目。与孔洞相对应的 `struct page`
-对象从未被完全初始化。
+在 FLATMEM 内存模型中，有一个全局的 `mem_map` 数组来映射整个物理内存。对
+于大多数架构，如果存在‘内存空洞’，则‘空洞’在 `mem_map` 数组中都有条目。与
+空洞相对应的 `struct page` 对象不会被完全初始化。
 
-为了分配 `mem_map` 数组，架构特定的设置代码应该调用free_area_init()函数。
-然而，在调用memblock_free_all()函数之前，映射数组是不能使用的，该函数
-将所有的内存交给页分配器。
+为了分配 `mem_map` 数组，架构特定的初始化代码(mem_init)应该调用
+free_area_init() 函数。并且，在 memblock_free_all() 函数被调用之前，mem_map
+数组是不能使用的。在 memblock_free_all 函数中，将所有的内存交给伙伴分配器。
 
-一个架构可能会释放 `mem_map` 数组中不包括实际物理页的部分。在这种情况下，特
-定架构的 :c:func:`pfn_valid` 实现应该考虑到 `mem_map` 中的孔隙。
+特定架构的实现可能会释放 `mem_map` 数组中不包括实际物理页的部分。此时，架构
+特定的 :c:func:`pfn_valid` 实现应该考虑到识别 `mem_map` 中存在的‘空洞’并恰当
+的处理之。
 
-使用FLATMEM，PFN和 `struct page` 之间的转换是直接的。 `PFN - ARCH_PFN_OFFSET`
-是 `mem_map` 数组的一个索引。
-
-`ARCH_PFN_OFFSET` 定义了物理内存起始地址不同于0的系统的第一个页框号。
+使用 FLATMEM 模型，PFN 和 `struct page` 之间的转换很简便：
+`PFN - ARCH_PFN_OFFSET` 可以直接作为 `mem_map` 数组的索引使用。
+架构特定的定义：
+`ARCH_PFN_OFFSET` 定义了物理内存起始地址对应的第一个页框号。当然如果物理内存
+的起始地址是 0 那么这个宏可能不会定义。
 
 SPARSEMEM
 =========
 
-SPARSEMEM是Linux中最通用的内存模型，它是唯一支持若干高级功能的内存模型，
-如物理内存的热插拔、非易失性内存设备的替代内存图和较大系统的内存图的延迟
-初始化。
+SPARSEMEM 是 Linux 内核中最通用的内存模型，若干高级功能如物理内存的热插拔、非
+易失性内存设备的替代内存图以及大系统的内存图延迟初始化等都只基于 SPARSEMEM 内
+存模型实现。
 
-SPARSEMEM模型将物理内存显示为一个部分的集合。一个区段用mem_section结构
+SPARSEMEM 模型将物理内存显式分为内存区段的集合。内存区段用 mem_section 结构
 体表示，它包含 `section_mem_map` ，从逻辑上讲，它是一个指向 `struct page`
-阵列的指针。然而，它被存储在一些其他的magic中，以帮助分区管理。区段的大小
-和最大区段数是使用 `SECTION_SIZE_BITS` 和 `MAX_PHYSMEM_BITS` 常量
-来指定的，这两个常量是由每个支持SPARSEMEM的架构定义的。 `MAX_PHYSMEM_BITS`
-是一个架构所支持的物理地址的实际宽度，而 `SECTION_SIZE_BITS` 是一个任
-意的值。
+阵列的指针。然而，在这个 section_mem_map 中还编码了其他用以帮助分区管理的数值。
+区段的大小和最大区段数使用 `SECTION_SIZE_BITS` 和 `MAX_PHYSMEM_BITS` 常量
+来指定，这两个常量由每个支持 SPARSEMEM 的架构定义。 `MAX_PHYSMEM_BITS`
+是特定架构所支持的物理地址的实际宽度，而 `SECTION_SIZE_BITS` 是交由特定架构自由
+发挥。
 
-最大的段数表示为 `NR_MEM_SECTIONS` ，定义为
+最大的段数表示为 `NR_MEM_SECTIONS` ，定义为:
 
 .. math::
 
@@ -83,53 +85,59 @@ SPARSEMEM模型将物理内存显示为一个部分的集合。一个区段用me
   每一行包含价值 `PAGE_SIZE` 的 `mem_section` 对象，行数的计算是为了适应所有的
   内存区。
 
-架构设置代码应该调用sparse_init()来初始化内存区和内存映射。
+架构特定的设置代码需要调用 sparse_init() 来初始化内存区和内存映射。
 
-通过SPARSEMEM，有两种可能的方式将PFN转换为相应的 `struct page` --"classic sparse"和
- "sparse vmemmap"。选择是在构建时进行的，它由 `CONFIG_SPARSEMEM_VMEMMAP` 的
- 值决定。
+基于 SPARSEMEM 模型，有两种可能的方式将 PFN 转换为相应的 `struct page` --
+"classic sparse" 和 "sparse vmemmap"。具体选择哪一种由内核配置选项
+`CONFIG_SPARSEMEM_VMEMMAP` 的值决定。在内核构建之前需要选择是哪一种。
 
-Classic sparse在page->flags中编码了一个页面的段号，并使用PFN的高位来访问映射该页
-框的段。在一个区段内，PFN是指向页数组的索引。
+Classic sparse 在 page->flags 中编码了一个页面的段号，并使用 PFN 的高位来访问
+映射该页框的区段。在一个区段内，PFN 是指向页数组的索引。
 
-Sparse vmemmapvmemmap使用虚拟映射的内存映射来优化pfn_to_page和page_to_pfn操
+Sparse vmemmap 使用虚拟映射的内存映射来优化 pfn_to_page 和 page_to_pfn 操
 作。有一个全局的 `struct page *vmemmap` 指针，指向一个虚拟连续的 `struct page`
-对象阵列。PFN是该数组的一个索引，`struct page` 从 `vmemmap` 的偏移量是该页的PFN。
+数组对象。PFN 是该数组的索引，`struct page` 在 `vmemmap` 中的偏移量就是该页的
+PFN。
 
-为了使用vmemmap，一个架构必须保留一个虚拟地址的范围，以映射包含内存映射的物理页，并
-确保 `vmemmap`指向该范围。此外，架构应该实现 :c:func:`vmemmap_populate` 方法，
-它将分配物理内存并为虚拟内存映射创建页表。如果一个架构对vmemmap映射没有任何特殊要求，
-它可以使用通用内存管理提供的默认 :c:func:`vmemmap_populate_basepages`。
+为了使用 vmemmap，特定架构必须保留一段虚拟地址围，以映射包含内存映射图的物理页，
+并确保 `vmemmap` 指向该范围。此外，架构特定代码需要实现
+:c:func:`vmemmap_populate` 方法，在这个方法中，需要分配物理内存并为虚拟内存映
+射图创建页表。如果特定架构对 vmemmap 映射没有任何特殊要求，它可以使用通用内存
+管理提供的默认实现 :c:func:`vmemmap_populate_basepages`。
 
-虚拟映射的内存映射允许将持久性内存设备的 `struct page` 对象存储在这些设备上预先分
-配的存储中。这种存储用vmem_altmap结构表示，最终通过一长串的函数调用传递给
-vmemmap_populate()。vmemmap_populate()实现可以使用 `vmem_altmap` 和
-:c:func:`vmemmap_alloc_block_buf` 助手来分配持久性内存设备上的内存映射。
+虚拟映射的内存映射图允许将持久性内存设备的 `struct page` 对象存储在这些设备上
+预先分配好的（内存）存储中。这种存储用 vmem_altmap 数据结构表示，最终通过一长
+串的函数调用传递给 vmemmap_populate() 函数。vmemmap_populate() 的实现里面可
+使用 `vmem_altmap` 和 :c:func:`vmemmap_alloc_block_buf` 助手函数来从持久性内
+存设备上为内存映射图分配内存。
 
 ZONE_DEVICE
 ===========
 `ZONE_DEVICE` 设施建立在 `SPARSEM_VMEMMAP` 之上，为设备驱动识别的物理地址范
-围提供 `struct page` `mem_map` 服务。 `ZONE_DEVICE` 的 "设备" 方面与以下
-事实有关：这些地址范围的页面对象从未被在线标记过，而且必须对设备进行引用，而不仅仅
-是页面，以保持内存被“锁定”以便使用。 `ZONE_DEVICE` ，通过 :c:func:`devm_memremap_pages` ，
-为给定的pfns范围执行足够的内存热插拔来开启 :c:func:`pfn_to_page`，
-:c:func:`page_to_pfn`, ，和 :c:func:`get_user_pages` 服务。由于页面引
-用计数永远不会低于1，所以页面永远不会被追踪为空闲内存，页面的 `struct list_head lru`
-空间被重新利用，用于向映射该内存的主机设备/驱动程序进行反向引用。
-
-虽然 `SPARSEMEM` 将内存作为一个区段的集合，可以选择收集并合成内存块，但
-`ZONE_DEVICE` 用户需要更小的颗粒度来填充 `mem_map` 。鉴于 `ZONE_DEVICE`
-内存从未被在线标记，因此它的内存范围从未通过sysfs内存热插拔api暴露在内存块边界
-上。这个实现依赖于这种缺乏用户接口的约束，允许子段大小的内存范围被指定给
-:c:func:`arch_add_memory` ，即内存热插拔的上半部分。子段支持允许2MB作为
+围提供 `struct page` 和 `mem_map` 服务。 `ZONE_DEVICE` 的 "设备" 方面与以下
+事实有关：这些地址范围的页面对象不会被标记为在线；并且必须增加对设备的引用计
+数，而不仅仅是页面的引用计数，以保持相关数据被“锁定”在内存中。
+`ZONE_DEVICE` ，通过 :c:func:`devm_memremap_pages` ，为给定 pfns 范围内的内
+存提供足够的内存热插拔支持来开启 :c:func:`pfn_to_page`，
+:c:func:`page_to_pfn`, 和 :c:func:`get_user_pages` 服务。由于页面引
+用计数永远不会低于 1，所以页面永远不会被标记为空闲内存，页面的
+`struct list_head lru` 空间被重新利用，用于向映射该内存的主机设备/驱动程序进
+行反向引用。
+
+虽然 `SPARSEMEM` 将全部内存抽象为区段的集合，可以选择收集并合成内存块，但
+`ZONE_DEVICE` 用户需要更小的颗粒度来用作 `mem_map` 。鉴于 `ZONE_DEVICE`
+内存从未被标记为在线，因此它的内存范围不会通过 sysfs 内存热插拔 api 暴露在
+内存块边界上。这个实现依赖于这种缺乏用户接口的约束，允许小于段大小的内存范围被
+指定给 :c:func:`arch_add_memory` ，即内存热插拔的上半部分。子段支持 2MB 作为
 :c:func:`devm_memremap_pages` 的跨架构通用对齐颗粒度。
 
-`ZONE_DEVICE` 的用户是:
+`ZONE_DEVICE` 的用户有:
 
-* pmem: 通过DAX映射将平台持久性内存作为直接I/O目标使用。
+* pmem: 通过 DAX 映射使用平台持久性内存作为直接 I/O 的目标。
 
 * hmm: 用 `->page_fault()` 和 `->page_free()` 事件回调扩展 `ZONE_DEVICE` ，
-  以允许设备驱动程序协调与设备内存相关的内存管理事件，通常是GPU内存。参见Documentation/mm/hmm.rst。
+  以允许设备驱动程序协调与设备内存相关的内存管理事件，典型的设备内存有 GPU 内
+  存等。详情可参考 Documentation/mm/hmm.rst。
 
-* p2pdma: 创建 `struct page` 对象，允许PCI/E拓扑结构中的peer设备协调它们之间的
-  直接DMA操作，即绕过主机内存。
+* p2pdma: 创建 `struct page` 对象，允许 PCI/-E 设备拓扑结构中的 peer 设备协
+  调它们之间的直接 DMA 操作，比如：绕过主机内存在 peer 之间直接 DMA。
-- 
2.34.1


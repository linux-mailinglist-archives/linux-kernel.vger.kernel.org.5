Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639CC7BF9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJJLcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjJJLb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:31:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0617B94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696937517; x=1728473517;
  h=date:from:to:cc:subject:message-id;
  bh=tNt1PAbuhRjpc4lWavDHe92vl1Otp08Do6gTbfMfGTI=;
  b=RqJwUi2a6S8lyAAfC85++vf8dT2TVzypsezlZAK2ASta1bL4xhzlDGKx
   dGXQfXnrXN+3UDagCNGywW0yduOXSUmFOsxH65TPzBWFCY03LhC/QnOAW
   tY+j4q4L6x82fAtRBy+60P8fW3ehzJwlRuxYpV5h9OqO+1uFyuN0GEHSI
   PG73GdFAjpy7RJJ6OYhvrU/LGuMzy8O3LGwRUZ4qR+hQeb6Ht81NpuYiz
   hMmTgzKeQSjsFd1ZrktjZekcNgvxnk0XH4CTXQcJnk8mIJ4uZl8yIcW+o
   x+NaXcnlGcjOn5+gYoLf4dTeYHnr1mJBTnIBxdV0DcsTMMckEEWewGQ/2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470634198"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="470634198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869653066"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="869653066"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2023 04:31:55 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqAxt-0000Kn-25;
        Tue, 10 Oct 2023 11:31:53 +0000
Date:   Tue, 10 Oct 2023 19:29:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 a3c7a64f9b764e200338130253dfe4488db03f4f
Message-ID: <202310101947.gTSXmEnC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: a3c7a64f9b764e200338130253dfe4488db03f4f  x86/percpu: Disable named address spaces for KASAN

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/include/asm/desc.h:197:32: sparse: sparse: too many errors
arch/x86/include/asm/preempt.h:104:16: sparse:    int preempt_offset
arch/x86/include/asm/tlbflush.h:262:45: sparse: sparse: too many errors
arch/x86/kernel/tsc_sync.c:100:33: sparse: sparse: too many errors
include/linux/context_tracking_state.h:92:16: sparse: sparse: too many errors
include/linux/percpu-refcount.h:205:17: sparse: sparse: too many errors
include/linux/sched/mm.h:415:23: sparse: sparse: too many errors
include/linux/seqlock.h:269:9: sparse: sparse: too many errors
include/linux/u64_stats_sync.h:145:9: sparse: sparse: too many errors
kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: too many errors
kernel/locking/osq_lock.c:94:31: sparse: sparse: too many errors
lib/flex_proportions.c:73:9: sparse: sparse: too many errors

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-063-20231005
|   |-- arch-x86-include-asm-desc.h:sparse:sparse:too-many-errors
|   |-- arch-x86-include-asm-tlbflush.h:sparse:sparse:too-many-errors
|   |-- include-linux-context_tracking_state.h:sparse:sparse:too-many-errors
|   |-- include-linux-percpu-refcount.h:sparse:sparse:too-many-errors
|   |-- include-linux-sched-mm.h:sparse:sparse:too-many-errors
|   |-- include-linux-seqlock.h:sparse:sparse:too-many-errors
|   |-- include-linux-u64_stats_sync.h:sparse:sparse:too-many-errors
|   |-- kernel-bpf-percpu_freelist.c:sparse:sparse:too-many-errors
|   |-- kernel-locking-osq_lock.c:sparse:sparse:too-many-errors
|   `-- lib-flex_proportions.c:sparse:sparse:too-many-errors
`-- x86_64-randconfig-123-20231009
    |-- arch-x86-include-asm-preempt.h:sparse:int-preempt_offset
    `-- arch-x86-kernel-tsc_sync.c:sparse:sparse:too-many-errors

elapsed time: 1001m

configs tested: 52
configs skipped: 102

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231010   gcc  
i386         buildonly-randconfig-002-20231010   gcc  
i386         buildonly-randconfig-003-20231010   gcc  
i386         buildonly-randconfig-004-20231010   gcc  
i386         buildonly-randconfig-005-20231010   gcc  
i386         buildonly-randconfig-006-20231010   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231010   gcc  
i386                  randconfig-002-20231010   gcc  
i386                  randconfig-003-20231010   gcc  
i386                  randconfig-004-20231010   gcc  
i386                  randconfig-005-20231010   gcc  
i386                  randconfig-006-20231010   gcc  
i386                  randconfig-011-20231010   gcc  
i386                  randconfig-012-20231010   gcc  
i386                  randconfig-013-20231010   gcc  
i386                  randconfig-014-20231010   gcc  
i386                  randconfig-015-20231010   gcc  
i386                  randconfig-016-20231010   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231010   gcc  
x86_64       buildonly-randconfig-002-20231010   gcc  
x86_64       buildonly-randconfig-003-20231010   gcc  
x86_64       buildonly-randconfig-004-20231010   gcc  
x86_64       buildonly-randconfig-005-20231010   gcc  
x86_64       buildonly-randconfig-006-20231010   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231010   gcc  
x86_64                randconfig-002-20231010   gcc  
x86_64                randconfig-003-20231010   gcc  
x86_64                randconfig-004-20231010   gcc  
x86_64                randconfig-005-20231010   gcc  
x86_64                randconfig-006-20231010   gcc  
x86_64                randconfig-011-20231010   gcc  
x86_64                randconfig-012-20231010   gcc  
x86_64                randconfig-013-20231010   gcc  
x86_64                randconfig-014-20231010   gcc  
x86_64                randconfig-015-20231010   gcc  
x86_64                randconfig-016-20231010   gcc  
x86_64                randconfig-071-20231010   gcc  
x86_64                randconfig-072-20231010   gcc  
x86_64                randconfig-073-20231010   gcc  
x86_64                randconfig-074-20231010   gcc  
x86_64                randconfig-075-20231010   gcc  
x86_64                randconfig-076-20231010   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

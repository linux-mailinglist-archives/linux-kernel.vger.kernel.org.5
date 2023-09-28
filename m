Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372737B23E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjI1R3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1R3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:29:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD01C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922160; x=1727458160;
  h=date:from:to:cc:subject:message-id;
  bh=bFM6R44kCvqBNDMUIdT0xXyHoUwrjDmkbrYXa5jMJZM=;
  b=RPDoeQI6KwME57+YEaM1rdYN9MeJu/+Tcu8lwJXJ181N8HAbRLbrUHog
   mkYSx3c9dT3Cw1CAIdXFd+M5dhLA78lkdj1zf33g6pJkqrqFC6VDvjI8z
   OXdJXzwEgWYKDZQV/4gAh/DzlAbvZ7B5zYo80cV08Tn0+IDsEVvQdjaTd
   CT4yrnhmOhFMehZgP0nl2JAWDUNtqa6XTMLmo8544Tl8TWQxgd0SsI+DQ
   ZTI2x9CRNw7D+dZK29vQJt6yGGXx3tLzfm1XB0SgLEIyAUu9U5eZgIf1O
   n/yYLyqCovTTO65SBWYg24D9DLsGfI7DYc3WFO2WFCyU7j8fz9Rv2VtuZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="382029118"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="382029118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="778982756"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="778982756"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2023 10:29:18 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlupA-0001ka-0M;
        Thu, 28 Sep 2023 17:29:16 +0000
Date:   Fri, 29 Sep 2023 01:28:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 1a6a464774947920dcedcf7409be62495c7cedd0
Message-ID: <202309290128.DhiP51da-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 1a6a464774947920dcedcf7409be62495c7cedd0  timers: Tag (hr)timer softirq as hotplug safe

elapsed time: 1584m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230928   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                        neponset_defconfig   clang
arm                   randconfig-001-20230928   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230928   gcc  
i386         buildonly-randconfig-002-20230928   gcc  
i386         buildonly-randconfig-003-20230928   gcc  
i386         buildonly-randconfig-004-20230928   gcc  
i386         buildonly-randconfig-005-20230928   gcc  
i386         buildonly-randconfig-006-20230928   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230928   gcc  
i386                  randconfig-002-20230928   gcc  
i386                  randconfig-003-20230928   gcc  
i386                  randconfig-004-20230928   gcc  
i386                  randconfig-005-20230928   gcc  
i386                  randconfig-006-20230928   gcc  
i386                  randconfig-011-20230928   gcc  
i386                  randconfig-012-20230928   gcc  
i386                  randconfig-013-20230928   gcc  
i386                  randconfig-014-20230928   gcc  
i386                  randconfig-015-20230928   gcc  
i386                  randconfig-016-20230928   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230927   gcc  
loongarch             randconfig-001-20230928   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   clang
mips                       rbtx49xx_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                    socrates_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230928   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230928   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230928   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230928   gcc  
x86_64       buildonly-randconfig-002-20230928   gcc  
x86_64       buildonly-randconfig-003-20230928   gcc  
x86_64       buildonly-randconfig-004-20230928   gcc  
x86_64       buildonly-randconfig-005-20230928   gcc  
x86_64       buildonly-randconfig-006-20230928   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230928   gcc  
x86_64                randconfig-002-20230928   gcc  
x86_64                randconfig-003-20230928   gcc  
x86_64                randconfig-004-20230928   gcc  
x86_64                randconfig-005-20230928   gcc  
x86_64                randconfig-006-20230928   gcc  
x86_64                randconfig-011-20230928   gcc  
x86_64                randconfig-012-20230928   gcc  
x86_64                randconfig-013-20230928   gcc  
x86_64                randconfig-014-20230928   gcc  
x86_64                randconfig-015-20230928   gcc  
x86_64                randconfig-016-20230928   gcc  
x86_64                randconfig-071-20230928   gcc  
x86_64                randconfig-072-20230928   gcc  
x86_64                randconfig-073-20230928   gcc  
x86_64                randconfig-074-20230928   gcc  
x86_64                randconfig-075-20230928   gcc  
x86_64                randconfig-076-20230928   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

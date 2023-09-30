Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9BE7B3F35
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjI3IcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3IcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:32:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8173195
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696062732; x=1727598732;
  h=date:from:to:cc:subject:message-id;
  bh=VdAh14denq7jsBOWJYWpSWsv16tw7gADtzf2iu9jkCY=;
  b=mHTen1c7fuZSnvmSaPBQcsZwhz0x5uxZJxrxFPqESoRux1lgYQ5GlV3C
   9tN2ad7dOa0OZvxo+9fFrwWTlppS0oj/B+QVwtO0crN5baBIRkpVAHQmB
   PNrWm7bdo3w7ebVXShf4py3zNNOczk6QNJKgLt2tGbwOhRZh8vw6Bw1nz
   sAzDbbJwXlBZoVWAmk71VEfU7P9pbUCSJBN0ro1uT5MzjFfYWqb1/VOQq
   sdclYli6RsG9vTXJBHejP79jrvC8wmYwbCK+pdvHDdIXP3FjAsIacTe4B
   yqgguNOD13/6h6x+x4MR9OzUSoLnHfx9KtIKjF5mJsrXzbD+dkbr3pfT6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="448923997"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="448923997"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 01:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="820401193"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="820401193"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2023 01:32:10 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmVOS-0003ur-0c;
        Sat, 30 Sep 2023 08:32:08 +0000
Date:   Sat, 30 Sep 2023 16:31:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 15874a3d27e6405e9d17595f83bd3ca1b6cab16d
Message-ID: <202309301640.BEn4SvNJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 15874a3d27e6405e9d17595f83bd3ca1b6cab16d  sched/debug: Add new tracepoint to track compute energy computation

elapsed time: 1435m

configs tested: 200
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
arc                   randconfig-001-20230929   gcc  
arc                   randconfig-001-20230930   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20230930   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230929   gcc  
i386         buildonly-randconfig-001-20230930   gcc  
i386         buildonly-randconfig-002-20230929   gcc  
i386         buildonly-randconfig-002-20230930   gcc  
i386         buildonly-randconfig-003-20230929   gcc  
i386         buildonly-randconfig-003-20230930   gcc  
i386         buildonly-randconfig-004-20230929   gcc  
i386         buildonly-randconfig-004-20230930   gcc  
i386         buildonly-randconfig-005-20230929   gcc  
i386         buildonly-randconfig-005-20230930   gcc  
i386         buildonly-randconfig-006-20230929   gcc  
i386         buildonly-randconfig-006-20230930   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230929   gcc  
i386                  randconfig-001-20230930   gcc  
i386                  randconfig-002-20230929   gcc  
i386                  randconfig-002-20230930   gcc  
i386                  randconfig-003-20230929   gcc  
i386                  randconfig-003-20230930   gcc  
i386                  randconfig-004-20230929   gcc  
i386                  randconfig-004-20230930   gcc  
i386                  randconfig-005-20230929   gcc  
i386                  randconfig-005-20230930   gcc  
i386                  randconfig-006-20230929   gcc  
i386                  randconfig-006-20230930   gcc  
i386                  randconfig-011-20230929   gcc  
i386                  randconfig-011-20230930   gcc  
i386                  randconfig-012-20230929   gcc  
i386                  randconfig-012-20230930   gcc  
i386                  randconfig-013-20230929   gcc  
i386                  randconfig-013-20230930   gcc  
i386                  randconfig-014-20230929   gcc  
i386                  randconfig-014-20230930   gcc  
i386                  randconfig-015-20230929   gcc  
i386                  randconfig-015-20230930   gcc  
i386                  randconfig-016-20230929   gcc  
i386                  randconfig-016-20230930   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230929   gcc  
loongarch             randconfig-001-20230930   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   clang
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230929   gcc  
riscv                 randconfig-001-20230930   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230929   gcc  
s390                  randconfig-001-20230930   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230930   gcc  
sparc64                          alldefconfig   gcc  
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
x86_64       buildonly-randconfig-001-20230929   gcc  
x86_64       buildonly-randconfig-001-20230930   gcc  
x86_64       buildonly-randconfig-002-20230929   gcc  
x86_64       buildonly-randconfig-002-20230930   gcc  
x86_64       buildonly-randconfig-003-20230929   gcc  
x86_64       buildonly-randconfig-003-20230930   gcc  
x86_64       buildonly-randconfig-004-20230929   gcc  
x86_64       buildonly-randconfig-004-20230930   gcc  
x86_64       buildonly-randconfig-005-20230929   gcc  
x86_64       buildonly-randconfig-005-20230930   gcc  
x86_64       buildonly-randconfig-006-20230929   gcc  
x86_64       buildonly-randconfig-006-20230930   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230930   gcc  
x86_64                randconfig-002-20230930   gcc  
x86_64                randconfig-003-20230930   gcc  
x86_64                randconfig-004-20230930   gcc  
x86_64                randconfig-005-20230930   gcc  
x86_64                randconfig-006-20230930   gcc  
x86_64                randconfig-011-20230930   gcc  
x86_64                randconfig-012-20230930   gcc  
x86_64                randconfig-013-20230930   gcc  
x86_64                randconfig-014-20230930   gcc  
x86_64                randconfig-015-20230930   gcc  
x86_64                randconfig-016-20230930   gcc  
x86_64                randconfig-071-20230930   gcc  
x86_64                randconfig-072-20230930   gcc  
x86_64                randconfig-073-20230930   gcc  
x86_64                randconfig-074-20230930   gcc  
x86_64                randconfig-075-20230930   gcc  
x86_64                randconfig-076-20230930   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

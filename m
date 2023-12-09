Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA080B603
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjLITWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLITWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:22:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF077AC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702149729; x=1733685729;
  h=date:from:to:cc:subject:message-id;
  bh=zA29k8e3GDEOVJEfTXsr7Y60GWxr37fFHJkRrDG7BQU=;
  b=A3ghHogSDerK5kEUqNzotGjDxmqbRNW4XAztIscLoD4WrE+1J+zqacik
   XmtSlf2qQ8aIiZFYxz36bXk+pUaJ5a/YImT9F0kM1VtKf2HMtM59VXczJ
   xnx5FxrJdr34HzH5nzUm7+0HSGLdQYSpgIClZEmwNkm2MDHFq08O0MBeJ
   4EQOl9Zv9YsutpwAa110kBpuFZNaqHcdKZvLdp3cQNKoH0r2USGQMBmT1
   Ob83H7klHbb/MlASjE/5aeur0VAjM2aevGULRaFHiPJMTnc3rIL6GkipZ
   4UPv2TJWd3QmyVtXS+azjMFcXH90/jOaQJPQG69UHBvk+DP5Tlvlx2M+l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1367023"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="1367023"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 11:22:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="765843083"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="765843083"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2023 11:22:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC2tp-000FpN-2V;
        Sat, 09 Dec 2023 19:22:05 +0000
Date:   Sun, 10 Dec 2023 03:21:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 981cf568a8644161c2f15c02278ebc2834b51ba6
Message-ID: <202312100304.t0RkgBLw-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 981cf568a8644161c2f15c02278ebc2834b51ba6  selftests/sgx: Skip non X86_64 platform

elapsed time: 1484m

configs tested: 182
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231209   gcc  
arc                   randconfig-002-20231209   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231209   gcc  
arm                   randconfig-002-20231209   gcc  
arm                   randconfig-003-20231209   gcc  
arm                   randconfig-004-20231209   gcc  
arm                           sama5_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231209   gcc  
arm64                 randconfig-002-20231209   gcc  
arm64                 randconfig-003-20231209   gcc  
arm64                 randconfig-004-20231209   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231209   gcc  
csky                  randconfig-002-20231209   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231209   gcc  
i386         buildonly-randconfig-002-20231209   gcc  
i386         buildonly-randconfig-003-20231209   gcc  
i386         buildonly-randconfig-004-20231209   gcc  
i386         buildonly-randconfig-005-20231209   gcc  
i386         buildonly-randconfig-006-20231209   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231209   gcc  
i386                  randconfig-002-20231209   gcc  
i386                  randconfig-003-20231209   gcc  
i386                  randconfig-004-20231209   gcc  
i386                  randconfig-005-20231209   gcc  
i386                  randconfig-006-20231209   gcc  
i386                  randconfig-011-20231209   clang
i386                  randconfig-012-20231209   clang
i386                  randconfig-013-20231209   clang
i386                  randconfig-014-20231209   clang
i386                  randconfig-015-20231209   clang
i386                  randconfig-016-20231209   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231209   gcc  
loongarch             randconfig-002-20231209   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231209   gcc  
nios2                 randconfig-002-20231209   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231209   gcc  
parisc                randconfig-002-20231209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20231209   gcc  
powerpc               randconfig-002-20231209   gcc  
powerpc               randconfig-003-20231209   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20231209   gcc  
powerpc64             randconfig-002-20231209   gcc  
powerpc64             randconfig-003-20231209   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231209   gcc  
riscv                 randconfig-002-20231209   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231209   gcc  
sh                    randconfig-002-20231209   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231209   gcc  
sparc64               randconfig-002-20231209   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231209   gcc  
um                    randconfig-002-20231209   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231209   gcc  
x86_64       buildonly-randconfig-002-20231209   gcc  
x86_64       buildonly-randconfig-003-20231209   gcc  
x86_64       buildonly-randconfig-004-20231209   gcc  
x86_64       buildonly-randconfig-005-20231209   gcc  
x86_64       buildonly-randconfig-006-20231209   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231209   gcc  
x86_64                randconfig-012-20231209   gcc  
x86_64                randconfig-013-20231209   gcc  
x86_64                randconfig-014-20231209   gcc  
x86_64                randconfig-015-20231209   gcc  
x86_64                randconfig-016-20231209   gcc  
x86_64                randconfig-071-20231209   gcc  
x86_64                randconfig-072-20231209   gcc  
x86_64                randconfig-073-20231209   gcc  
x86_64                randconfig-074-20231209   gcc  
x86_64                randconfig-075-20231209   gcc  
x86_64                randconfig-076-20231209   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231209   gcc  
xtensa                randconfig-002-20231209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

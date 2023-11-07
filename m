Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182E57E3210
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjKGAMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjKGAMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:12:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E7BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699315971; x=1730851971;
  h=date:from:to:cc:subject:message-id;
  bh=e8a4/dE7fp5uGLmtd3xne+eo3BBs04lG2ZJaxiF/L0w=;
  b=XT9lP5UgO7ble1zCINhkUEeT4SpRBc3z/N9jpVCZDFOPsC5oMY9r92Ip
   p3bCPuTgHTKF3NZVTlEucCTKjvPrmXIsj4/smk2FFtTBvxEJuoLuxaQKS
   2NagyoaBs4LkWT62VjrJg+s7cB3i/hjgpJUIHiCzOTB9Lr+TuCEtGnhz/
   Ofh6+yRGi0v+lZ/ihIwKw1aQGHOfrVf7z/7abSt4gDUmKyK/tuEgdmJDW
   vpra/OO460a/+ScyDZTYzSpd3u72WB/UVemLkBuVOlZJ9hPipAWHF2WFR
   If2AC0+l7lKSUi/cdL4zMPXBFy+eLunr80pP+z30z74S0/JLtigfFRNOj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2318525"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2318525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="10225315"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2023 16:12:50 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r09i2-0006ps-1H;
        Tue, 07 Nov 2023 00:12:46 +0000
Date:   Tue, 07 Nov 2023 08:12:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 ecaf76f3b2958b7cf67a59540b7a6d82d4bfc965
Message-ID: <202311070808.O7072gBS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: ecaf76f3b2958b7cf67a59540b7a6d82d4bfc965  Merge branch 'perf/urgent' into perf/core, to pick up fix

elapsed time: 1814m

configs tested: 151
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
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231106   gcc  
arc                   randconfig-002-20231106   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231106   gcc  
arm                   randconfig-002-20231106   gcc  
arm                   randconfig-003-20231106   gcc  
arm                   randconfig-004-20231106   gcc  
arm64                 randconfig-001-20231106   gcc  
arm64                 randconfig-002-20231106   gcc  
arm64                 randconfig-003-20231106   gcc  
arm64                 randconfig-004-20231106   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231106   gcc  
csky                  randconfig-002-20231106   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231106   gcc  
i386         buildonly-randconfig-002-20231106   gcc  
i386         buildonly-randconfig-003-20231106   gcc  
i386         buildonly-randconfig-004-20231106   gcc  
i386         buildonly-randconfig-005-20231106   gcc  
i386         buildonly-randconfig-006-20231106   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231106   gcc  
i386                  randconfig-002-20231106   gcc  
i386                  randconfig-003-20231106   gcc  
i386                  randconfig-004-20231106   gcc  
i386                  randconfig-005-20231106   gcc  
i386                  randconfig-006-20231106   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231106   gcc  
loongarch             randconfig-002-20231106   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
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
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20231106   gcc  
powerpc               randconfig-002-20231106   gcc  
powerpc               randconfig-003-20231106   gcc  
powerpc64             randconfig-001-20231106   gcc  
powerpc64             randconfig-002-20231106   gcc  
powerpc64             randconfig-003-20231106   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20231106   gcc  
x86_64       buildonly-randconfig-002-20231106   gcc  
x86_64       buildonly-randconfig-003-20231106   gcc  
x86_64       buildonly-randconfig-004-20231106   gcc  
x86_64       buildonly-randconfig-005-20231106   gcc  
x86_64       buildonly-randconfig-006-20231106   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231106   gcc  
x86_64                randconfig-002-20231106   gcc  
x86_64                randconfig-003-20231106   gcc  
x86_64                randconfig-004-20231106   gcc  
x86_64                randconfig-005-20231106   gcc  
x86_64                randconfig-006-20231106   gcc  
x86_64                randconfig-011-20231106   gcc  
x86_64                randconfig-012-20231106   gcc  
x86_64                randconfig-013-20231106   gcc  
x86_64                randconfig-014-20231106   gcc  
x86_64                randconfig-015-20231106   gcc  
x86_64                randconfig-016-20231106   gcc  
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

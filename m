Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153047EFB94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjKQWrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbjKQWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:47:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA25D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700261236; x=1731797236;
  h=date:from:to:cc:subject:message-id;
  bh=NFG5ObjFO8JOnXZbJZzmHrseGSp2/XIA+T0Kx39H6to=;
  b=bL9EI97j4NvaLxhA8aZcsnc1TNO7tsNom6JaFkrtQ1fv/CkO3Yi/rqDh
   3JUaiku7QJkHjFPdVXLwpFgMRtF62pOIiV0TecRWci3Yffu/hQ9FfAAqn
   D0dpnILoBVM9DDQDsIZAEp08s/g+DktpTf2BcBiIjqAoprMH7s4UmoePF
   fHOts6pOEfYEYMcjF0qnF155fTaR0+9serymL/OLsTtC7Ge5J+MMh8NRf
   tfsDk298nbg2Q8FOVpHAKqALxx/8MVuFhmSYvBldneWhTm4RU3hJVqF88
   ARGAXaSiLV8PtG65Nbo+upNCJkmXNCipinGKecJHwj2A1Tj9reCWc0hrf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="457882106"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="457882106"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 14:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="13618280"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2023 14:47:16 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r47cG-0003DO-2q;
        Fri, 17 Nov 2023 22:47:12 +0000
Date:   Sat, 18 Nov 2023 06:46:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 612905e13b8769caca7ec4194a8aceb24efa4d5c
Message-ID: <202311180620.kQsx0FgE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git ras/core
branch HEAD: 612905e13b8769caca7ec4194a8aceb24efa4d5c  x86/mce: Remove redundant check from mce_device_create()

elapsed time: 3230m

configs tested: 373
configs skipped: 188

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
arc                   randconfig-001-20231116   gcc  
arc                   randconfig-001-20231117   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-002-20231116   gcc  
arc                   randconfig-002-20231117   gcc  
arc                   randconfig-002-20231118   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                           h3600_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231116   gcc  
arm                   randconfig-001-20231117   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-002-20231116   gcc  
arm                   randconfig-002-20231117   gcc  
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-003-20231116   gcc  
arm                   randconfig-003-20231117   gcc  
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-004-20231116   gcc  
arm                   randconfig-004-20231117   gcc  
arm                   randconfig-004-20231118   gcc  
arm                         s3c6400_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231116   gcc  
arm64                 randconfig-001-20231117   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-002-20231116   gcc  
arm64                 randconfig-002-20231117   gcc  
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-003-20231116   gcc  
arm64                 randconfig-003-20231117   gcc  
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-004-20231116   gcc  
arm64                 randconfig-004-20231117   gcc  
arm64                 randconfig-004-20231118   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231116   gcc  
csky                  randconfig-001-20231117   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-002-20231116   gcc  
csky                  randconfig-002-20231117   gcc  
csky                  randconfig-002-20231118   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231116   gcc  
i386         buildonly-randconfig-001-20231117   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-002-20231116   gcc  
i386         buildonly-randconfig-002-20231117   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-003-20231116   gcc  
i386         buildonly-randconfig-003-20231117   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-004-20231116   gcc  
i386         buildonly-randconfig-004-20231117   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-005-20231116   gcc  
i386         buildonly-randconfig-005-20231117   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-006-20231116   gcc  
i386         buildonly-randconfig-006-20231117   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231116   gcc  
i386                  randconfig-001-20231117   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-002-20231116   gcc  
i386                  randconfig-002-20231117   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-003-20231116   gcc  
i386                  randconfig-003-20231117   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-004-20231116   gcc  
i386                  randconfig-004-20231117   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-005-20231116   gcc  
i386                  randconfig-005-20231117   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-006-20231116   gcc  
i386                  randconfig-006-20231117   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-011-20231116   gcc  
i386                  randconfig-011-20231117   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-012-20231116   gcc  
i386                  randconfig-012-20231117   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-013-20231116   gcc  
i386                  randconfig-013-20231117   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-014-20231116   gcc  
i386                  randconfig-014-20231117   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-015-20231116   gcc  
i386                  randconfig-015-20231117   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-016-20231116   gcc  
i386                  randconfig-016-20231117   gcc  
i386                  randconfig-016-20231118   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231116   gcc  
loongarch             randconfig-001-20231117   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-002-20231116   gcc  
loongarch             randconfig-002-20231117   gcc  
loongarch             randconfig-002-20231118   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231116   gcc  
nios2                 randconfig-001-20231117   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-002-20231116   gcc  
nios2                 randconfig-002-20231117   gcc  
nios2                 randconfig-002-20231118   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231116   gcc  
parisc                randconfig-001-20231117   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-002-20231116   gcc  
parisc                randconfig-002-20231117   gcc  
parisc                randconfig-002-20231118   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc               randconfig-001-20231116   gcc  
powerpc               randconfig-001-20231117   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-002-20231116   gcc  
powerpc               randconfig-002-20231117   gcc  
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-003-20231116   gcc  
powerpc               randconfig-003-20231117   gcc  
powerpc               randconfig-003-20231118   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231116   gcc  
powerpc64             randconfig-001-20231117   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-002-20231116   gcc  
powerpc64             randconfig-002-20231117   gcc  
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-003-20231116   gcc  
powerpc64             randconfig-003-20231117   gcc  
powerpc64             randconfig-003-20231118   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231116   gcc  
riscv                 randconfig-001-20231117   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-002-20231116   gcc  
riscv                 randconfig-002-20231117   gcc  
riscv                 randconfig-002-20231118   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231116   gcc  
s390                  randconfig-001-20231117   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-002-20231116   gcc  
s390                  randconfig-002-20231117   gcc  
s390                  randconfig-002-20231118   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231116   gcc  
sh                    randconfig-001-20231117   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-002-20231116   gcc  
sh                    randconfig-002-20231117   gcc  
sh                    randconfig-002-20231118   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231116   gcc  
sparc64               randconfig-001-20231117   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-002-20231116   gcc  
sparc64               randconfig-002-20231117   gcc  
sparc64               randconfig-002-20231118   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231116   gcc  
um                    randconfig-001-20231117   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-002-20231116   gcc  
um                    randconfig-002-20231117   gcc  
um                    randconfig-002-20231118   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231116   gcc  
x86_64       buildonly-randconfig-001-20231117   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-002-20231116   gcc  
x86_64       buildonly-randconfig-002-20231117   gcc  
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-003-20231116   gcc  
x86_64       buildonly-randconfig-003-20231117   gcc  
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-004-20231116   gcc  
x86_64       buildonly-randconfig-004-20231117   gcc  
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-005-20231116   gcc  
x86_64       buildonly-randconfig-005-20231117   gcc  
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-006-20231116   gcc  
x86_64       buildonly-randconfig-006-20231117   gcc  
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231116   gcc  
x86_64                randconfig-001-20231117   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-002-20231116   gcc  
x86_64                randconfig-002-20231117   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-003-20231116   gcc  
x86_64                randconfig-003-20231117   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-004-20231116   gcc  
x86_64                randconfig-004-20231117   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-005-20231116   gcc  
x86_64                randconfig-005-20231117   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-006-20231116   gcc  
x86_64                randconfig-006-20231117   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-011-20231116   gcc  
x86_64                randconfig-011-20231117   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-012-20231116   gcc  
x86_64                randconfig-012-20231117   gcc  
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-013-20231116   gcc  
x86_64                randconfig-013-20231117   gcc  
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-014-20231116   gcc  
x86_64                randconfig-014-20231117   gcc  
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-015-20231116   gcc  
x86_64                randconfig-015-20231117   gcc  
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-016-20231116   gcc  
x86_64                randconfig-016-20231117   gcc  
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-071-20231116   gcc  
x86_64                randconfig-071-20231117   gcc  
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-072-20231116   gcc  
x86_64                randconfig-072-20231117   gcc  
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-073-20231116   gcc  
x86_64                randconfig-073-20231117   gcc  
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-074-20231116   gcc  
x86_64                randconfig-074-20231117   gcc  
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-075-20231116   gcc  
x86_64                randconfig-075-20231117   gcc  
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-076-20231116   gcc  
x86_64                randconfig-076-20231117   gcc  
x86_64                randconfig-076-20231118   gcc  
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                randconfig-001-20231116   gcc  
xtensa                randconfig-001-20231117   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-002-20231116   gcc  
xtensa                randconfig-002-20231117   gcc  
xtensa                randconfig-002-20231118   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

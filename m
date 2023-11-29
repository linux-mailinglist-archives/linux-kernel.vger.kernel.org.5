Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FED7FCD12
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjK2Cum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjK2Cuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:50:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C681988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701226247; x=1732762247;
  h=date:from:to:cc:subject:message-id;
  bh=q1vdOOcjcyDBwSnhst4Agxh1zG5gbCIGicr6iXkahz8=;
  b=e8sjUANi+33R/m3fA4SAPcHp+/RysKKYJ6w0rU4KnbrKqQnOlImdl3bW
   4ZkhITCjppn9sj4jWH3FrShafautIlOFuunyrkpNsX88TNQh+XODrXzhr
   TR6n7vvV4+d3zugQkt7kcf+Bv5lHoMZ5N0XrejRA5WHtsxemgQ86zTULv
   YXafQ6zbEWSRG2Nu1i1FkeSCfners882q6RqVgxsw+RTlRj7sIko7R/hY
   OhhQ2AyP5FtF8C2vX41+2YLWctP1p9jB8rU/ELBZVRkNkqKtx3cF4z9F6
   prCzS6ptx8XIRpryFPMIpUiHWKdf98P49/WuW8bAWxkShpPA79hLDhNOi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="459580743"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="459580743"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 18:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016115028"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016115028"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Nov 2023 18:50:45 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Aex-0008UE-0B;
        Wed, 29 Nov 2023 02:50:43 +0000
Date:   Wed, 29 Nov 2023 10:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 c64545594daf748422fa083389b062d0a16fb477
Message-ID: <202311291018.TdTJs1ef-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: c64545594daf748422fa083389b062d0a16fb477  x86/Kconfig: Remove obsolete config X86_32_SMP

elapsed time: 734m

configs tested: 182
configs skipped: 135

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
arc                   randconfig-001-20231129   gcc  
arc                   randconfig-002-20231129   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231129   gcc  
arm                   randconfig-002-20231129   gcc  
arm                   randconfig-003-20231129   gcc  
arm                   randconfig-004-20231129   gcc  
arm                             rpc_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231129   gcc  
arm64                 randconfig-002-20231129   gcc  
arm64                 randconfig-003-20231129   gcc  
arm64                 randconfig-004-20231129   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231129   gcc  
csky                  randconfig-002-20231129   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231128   gcc  
i386                  randconfig-011-20231129   clang
i386                  randconfig-012-20231128   gcc  
i386                  randconfig-012-20231129   clang
i386                  randconfig-013-20231128   gcc  
i386                  randconfig-013-20231129   clang
i386                  randconfig-014-20231128   gcc  
i386                  randconfig-014-20231129   clang
i386                  randconfig-015-20231128   gcc  
i386                  randconfig-015-20231129   clang
i386                  randconfig-016-20231128   gcc  
i386                  randconfig-016-20231129   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231129   gcc  
loongarch             randconfig-002-20231129   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                           rs90_defconfig   clang
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231129   gcc  
nios2                 randconfig-002-20231129   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231129   gcc  
parisc                randconfig-002-20231129   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20231129   gcc  
powerpc               randconfig-002-20231129   gcc  
powerpc               randconfig-003-20231129   gcc  
powerpc64             randconfig-001-20231129   gcc  
powerpc64             randconfig-002-20231129   gcc  
powerpc64             randconfig-003-20231129   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231129   gcc  
riscv                 randconfig-002-20231129   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231129   gcc  
sh                    randconfig-002-20231129   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231129   gcc  
sparc64               randconfig-002-20231129   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231129   gcc  
um                    randconfig-002-20231129   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231129   gcc  
x86_64       buildonly-randconfig-002-20231129   gcc  
x86_64       buildonly-randconfig-003-20231129   gcc  
x86_64       buildonly-randconfig-004-20231129   gcc  
x86_64       buildonly-randconfig-005-20231129   gcc  
x86_64       buildonly-randconfig-006-20231129   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231129   gcc  
x86_64                randconfig-012-20231129   gcc  
x86_64                randconfig-013-20231129   gcc  
x86_64                randconfig-014-20231129   gcc  
x86_64                randconfig-015-20231129   gcc  
x86_64                randconfig-016-20231129   gcc  
x86_64                randconfig-071-20231129   gcc  
x86_64                randconfig-072-20231129   gcc  
x86_64                randconfig-073-20231129   gcc  
x86_64                randconfig-074-20231129   gcc  
x86_64                randconfig-075-20231129   gcc  
x86_64                randconfig-076-20231129   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20231129   gcc  
xtensa                randconfig-002-20231129   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

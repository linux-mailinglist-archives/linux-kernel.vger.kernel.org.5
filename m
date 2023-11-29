Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4B37FE39E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjK2WuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjK2Wt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:49:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEFD69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701298194; x=1732834194;
  h=date:from:to:cc:subject:message-id;
  bh=CvUWGgFXgBAlSZRLMgbm04Ye1dYWjncD5CNjEB/AlWM=;
  b=CoqYJQ+awwBAOIAh1EL/3IwJj4SajiKygYh7Gf0KiXwCGU7ShhoHEJgC
   Kb+nghIzH7veQ/PoxPqtkXn9R/bYV7VPxmQwhtmZEnsie3+ySdAcrp5CE
   4MVBcinHx0Ci9cdYooXi4cHWBjWA2QbdUCClh2ilAO20/guzK1HvEJmym
   9bi99a+NX3T5KsxzLOL/olzFrL/1/0mkIZHHOLCZQ6BXeBWnPYEbdWU6v
   IJX3VChIMeUUFWxnMPK2BjprMYl/9JLhk0k/wJwpOEtYlVk2wxrg5JAZq
   ZOV3KPLdR4oAfg4fjgQvBtarqi7+Un07Gk0EI4wqZIZoKLQF0xKp6Gt0T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="223058"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="223058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942486744"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="942486744"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2023 14:49:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8TNN-00012Y-2j;
        Wed, 29 Nov 2023 22:49:49 +0000
Date:   Thu, 30 Nov 2023 06:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 89741e7e42f6ab203fe50d80887f6feded326160
Message-ID: <202311300602.s5zBMyYw-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 89741e7e42f6ab203fe50d80887f6feded326160  Makefile: Enable -Wstringop-overflow globally

elapsed time: 1472m

configs tested: 234
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231129   gcc  
arc                   randconfig-002-20231129   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231129   gcc  
arm                   randconfig-002-20231129   gcc  
arm                   randconfig-003-20231129   gcc  
arm                   randconfig-004-20231129   gcc  
arm                        realview_defconfig   gcc  
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
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231129   clang
i386                  randconfig-011-20231130   clang
i386                  randconfig-012-20231129   clang
i386                  randconfig-012-20231130   clang
i386                  randconfig-013-20231129   clang
i386                  randconfig-013-20231130   clang
i386                  randconfig-014-20231129   clang
i386                  randconfig-014-20231130   clang
i386                  randconfig-015-20231129   clang
i386                  randconfig-015-20231130   clang
i386                  randconfig-016-20231129   clang
i386                  randconfig-016-20231130   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231129   gcc  
loongarch             randconfig-002-20231129   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                      loongson3_defconfig   gcc  
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
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231129   gcc  
parisc                randconfig-002-20231129   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc               randconfig-001-20231129   gcc  
powerpc               randconfig-002-20231129   gcc  
powerpc               randconfig-003-20231129   gcc  
powerpc64             randconfig-001-20231129   gcc  
powerpc64             randconfig-002-20231129   gcc  
powerpc64             randconfig-003-20231129   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
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
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231129   gcc  
sparc64               randconfig-002-20231129   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
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
x86_64       buildonly-randconfig-001-20231130   gcc  
x86_64       buildonly-randconfig-002-20231129   gcc  
x86_64       buildonly-randconfig-002-20231130   gcc  
x86_64       buildonly-randconfig-003-20231129   gcc  
x86_64       buildonly-randconfig-003-20231130   gcc  
x86_64       buildonly-randconfig-004-20231129   gcc  
x86_64       buildonly-randconfig-004-20231130   gcc  
x86_64       buildonly-randconfig-005-20231129   gcc  
x86_64       buildonly-randconfig-005-20231130   gcc  
x86_64       buildonly-randconfig-006-20231129   gcc  
x86_64       buildonly-randconfig-006-20231130   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231129   gcc  
x86_64                randconfig-011-20231130   gcc  
x86_64                randconfig-012-20231129   gcc  
x86_64                randconfig-012-20231130   gcc  
x86_64                randconfig-013-20231129   gcc  
x86_64                randconfig-013-20231130   gcc  
x86_64                randconfig-014-20231129   gcc  
x86_64                randconfig-014-20231130   gcc  
x86_64                randconfig-015-20231129   gcc  
x86_64                randconfig-015-20231130   gcc  
x86_64                randconfig-016-20231129   gcc  
x86_64                randconfig-016-20231130   gcc  
x86_64                randconfig-071-20231129   gcc  
x86_64                randconfig-071-20231130   gcc  
x86_64                randconfig-072-20231129   gcc  
x86_64                randconfig-072-20231130   gcc  
x86_64                randconfig-073-20231129   gcc  
x86_64                randconfig-073-20231130   gcc  
x86_64                randconfig-074-20231129   gcc  
x86_64                randconfig-074-20231130   gcc  
x86_64                randconfig-075-20231129   gcc  
x86_64                randconfig-075-20231130   gcc  
x86_64                randconfig-076-20231129   gcc  
x86_64                randconfig-076-20231130   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231129   gcc  
xtensa                randconfig-002-20231129   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

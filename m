Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A37F8A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 11:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjKYKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 05:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 05:49:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71C910EB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 02:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700909353; x=1732445353;
  h=date:from:to:cc:subject:message-id;
  bh=u8H3LkwuYZwO/5PMlxSKskyr3Mzn3qKVjrQ5wuXni14=;
  b=JuADE6l8vs7xjL12dT0KaeShjAbWFEW2V3gXtt018agsVI0oZvk7MBTm
   4SIb9Ipwxp3EGCCX3yECTaoz5Rjooyb4DH/8owRN8FpQwB54zJ16vaPJx
   ILw0b0H3n90bWfK5Yf01cGOjQY2ll3CngHYEa755HNl+NRAht22sw5JG0
   /SMSmYgusovgQHUq3EEsXOHCHSZjMkS8XqhPmGk/jZZB3p3Ip7emBsC/K
   gm+aX6BxoxJfJ95fFCbcwLvlb1ldReld4ATEyIbdD4O0hc8JizRBnyBZO
   jPIxSGikyVKNpRsRQBIVse46YjzBznsclWNuIi0C/FjqqgmnhovB7K/XN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="11202457"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="11202457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 02:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="761180259"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="761180259"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2023 02:49:09 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6qDi-0003sX-2m;
        Sat, 25 Nov 2023 10:49:06 +0000
Date:   Sat, 25 Nov 2023 18:48:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 bca4104b00fec60be330cd32818dd5c70db3d469
Message-ID: <202311251837.MuwVRAiX-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: bca4104b00fec60be330cd32818dd5c70db3d469  lockdep: Fix block chain corruption

elapsed time: 1458m

configs tested: 242
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231124   gcc  
arc                   randconfig-001-20231125   gcc  
arc                   randconfig-002-20231124   gcc  
arc                   randconfig-002-20231125   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231125   gcc  
arm                   randconfig-002-20231125   gcc  
arm                   randconfig-003-20231125   gcc  
arm                   randconfig-004-20231125   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231125   gcc  
arm64                 randconfig-002-20231125   gcc  
arm64                 randconfig-003-20231125   gcc  
arm64                 randconfig-004-20231125   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231124   gcc  
csky                  randconfig-001-20231125   gcc  
csky                  randconfig-002-20231124   gcc  
csky                  randconfig-002-20231125   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231124   gcc  
i386                  randconfig-011-20231125   clang
i386                  randconfig-012-20231124   gcc  
i386                  randconfig-012-20231125   clang
i386                  randconfig-013-20231124   gcc  
i386                  randconfig-013-20231125   clang
i386                  randconfig-014-20231124   gcc  
i386                  randconfig-014-20231125   clang
i386                  randconfig-015-20231124   gcc  
i386                  randconfig-015-20231125   clang
i386                  randconfig-016-20231124   gcc  
i386                  randconfig-016-20231125   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231124   gcc  
loongarch             randconfig-001-20231125   gcc  
loongarch             randconfig-002-20231124   gcc  
loongarch             randconfig-002-20231125   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231124   gcc  
nios2                 randconfig-001-20231125   gcc  
nios2                 randconfig-002-20231124   gcc  
nios2                 randconfig-002-20231125   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231124   gcc  
parisc                randconfig-001-20231125   gcc  
parisc                randconfig-002-20231124   gcc  
parisc                randconfig-002-20231125   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231125   gcc  
powerpc               randconfig-002-20231125   gcc  
powerpc               randconfig-003-20231125   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64             randconfig-001-20231125   gcc  
powerpc64             randconfig-002-20231125   gcc  
powerpc64             randconfig-003-20231125   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231125   gcc  
riscv                 randconfig-002-20231125   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231124   gcc  
s390                  randconfig-002-20231124   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231124   gcc  
sh                    randconfig-001-20231125   gcc  
sh                    randconfig-002-20231124   gcc  
sh                    randconfig-002-20231125   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231124   gcc  
sparc64               randconfig-001-20231125   gcc  
sparc64               randconfig-002-20231124   gcc  
sparc64               randconfig-002-20231125   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231125   gcc  
um                    randconfig-002-20231125   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231124   clang
x86_64       buildonly-randconfig-001-20231125   gcc  
x86_64       buildonly-randconfig-002-20231124   clang
x86_64       buildonly-randconfig-002-20231125   gcc  
x86_64       buildonly-randconfig-003-20231124   clang
x86_64       buildonly-randconfig-003-20231125   gcc  
x86_64       buildonly-randconfig-004-20231124   clang
x86_64       buildonly-randconfig-004-20231125   gcc  
x86_64       buildonly-randconfig-005-20231124   clang
x86_64       buildonly-randconfig-005-20231125   gcc  
x86_64       buildonly-randconfig-006-20231124   clang
x86_64       buildonly-randconfig-006-20231125   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231124   clang
x86_64                randconfig-011-20231125   gcc  
x86_64                randconfig-012-20231124   clang
x86_64                randconfig-012-20231125   gcc  
x86_64                randconfig-013-20231124   clang
x86_64                randconfig-013-20231125   gcc  
x86_64                randconfig-014-20231124   clang
x86_64                randconfig-014-20231125   gcc  
x86_64                randconfig-015-20231124   clang
x86_64                randconfig-015-20231125   gcc  
x86_64                randconfig-016-20231124   clang
x86_64                randconfig-016-20231125   gcc  
x86_64                randconfig-071-20231124   clang
x86_64                randconfig-071-20231125   gcc  
x86_64                randconfig-072-20231124   clang
x86_64                randconfig-072-20231125   gcc  
x86_64                randconfig-073-20231124   clang
x86_64                randconfig-073-20231125   gcc  
x86_64                randconfig-074-20231124   clang
x86_64                randconfig-074-20231125   gcc  
x86_64                randconfig-075-20231124   clang
x86_64                randconfig-075-20231125   gcc  
x86_64                randconfig-076-20231124   clang
x86_64                randconfig-076-20231125   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231124   gcc  
xtensa                randconfig-001-20231125   gcc  
xtensa                randconfig-002-20231124   gcc  
xtensa                randconfig-002-20231125   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

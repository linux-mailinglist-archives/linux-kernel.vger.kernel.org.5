Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E67973D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjIGPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245669AbjIGP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302A10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100568; x=1725636568;
  h=date:from:to:cc:subject:message-id;
  bh=2xh3aU29XBAJa6QUcNOep/sDljLAqvEmP3ABeBDn9kw=;
  b=Zj/27tWMdhS3YQSktzAPZ/nsoomryXIV1Ff2VXJvzKwOlb0vjM5LsQm9
   qG2sg8hH9FvnjFfWhqxTCmCyY9/iib4SJyQ+d8CUEEu51wy9UT4weg4g+
   Y3NPW2RZYiq9kfAyDUiyQ/jvCOvofloq4BhkBgjvw1aJuDqaXUpQNr23M
   ke4EX91xyPhf3D1YhAgUWh4/uarg/XH2aDgcSrn3r+EscZfqhLmAHFQ0Y
   u4Wlo+FPQGwogO14M+rDzMmskxLfxm8RK2pztPIlgy3AFhkGXS/rAO3OL
   6unnW28qC0RNnhGTsci2kRHN8K+VDOToqPOyBU7SivFhwcMpZJxuGWk0k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="381113484"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="381113484"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 04:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741989023"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="741989023"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2023 04:35:02 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeDHn-0001Ay-2Y;
        Thu, 07 Sep 2023 11:34:59 +0000
Date:   Thu, 07 Sep 2023 19:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5a76e238b9046c76cff3cf4a1db5369cdaddc2ba
Message-ID: <202309071929.FC0onFGH-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5a76e238b9046c76cff3cf4a1db5369cdaddc2ba  Merge branch into tip/master: 'x86/asm'

elapsed time: 726m

configs tested: 210
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230907   gcc  
alpha                randconfig-r033-20230907   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20230907   gcc  
arc                  randconfig-r005-20230907   gcc  
arc                  randconfig-r014-20230907   gcc  
arc                  randconfig-r032-20230907   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                   randconfig-001-20230907   clang
arm                         s5pv210_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230907   gcc  
csky                 randconfig-r022-20230907   gcc  
hexagon               randconfig-001-20230907   clang
hexagon               randconfig-002-20230907   clang
hexagon              randconfig-r004-20230907   clang
hexagon              randconfig-r034-20230907   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230907   clang
i386         buildonly-randconfig-002-20230907   clang
i386         buildonly-randconfig-003-20230907   clang
i386         buildonly-randconfig-004-20230907   clang
i386         buildonly-randconfig-005-20230907   clang
i386         buildonly-randconfig-006-20230907   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230907   clang
i386                  randconfig-002-20230907   clang
i386                  randconfig-003-20230907   clang
i386                  randconfig-004-20230907   clang
i386                  randconfig-005-20230907   clang
i386                  randconfig-006-20230907   clang
i386                  randconfig-011-20230907   gcc  
i386                  randconfig-012-20230907   gcc  
i386                  randconfig-013-20230907   gcc  
i386                  randconfig-014-20230907   gcc  
i386                  randconfig-015-20230907   gcc  
i386                  randconfig-016-20230907   gcc  
i386                 randconfig-r036-20230907   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230907   gcc  
loongarch            randconfig-r023-20230907   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r013-20230907   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r031-20230907   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        maltaup_defconfig   clang
mips                 randconfig-r015-20230907   clang
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230907   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r011-20230907   gcc  
openrisc             randconfig-r035-20230907   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230907   gcc  
parisc               randconfig-r034-20230907   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r012-20230907   gcc  
powerpc              randconfig-r014-20230907   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm5200_defconfig   clang
powerpc64            randconfig-r016-20230907   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20230907   clang
riscv                randconfig-r006-20230907   clang
riscv                randconfig-r031-20230907   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230907   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r002-20230907   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230907   gcc  
sparc                randconfig-r025-20230907   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r011-20230907   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230907   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230907   clang
x86_64       buildonly-randconfig-002-20230907   clang
x86_64       buildonly-randconfig-003-20230907   clang
x86_64       buildonly-randconfig-004-20230907   clang
x86_64       buildonly-randconfig-005-20230907   clang
x86_64       buildonly-randconfig-006-20230907   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230907   gcc  
x86_64                randconfig-002-20230907   gcc  
x86_64                randconfig-003-20230907   gcc  
x86_64                randconfig-004-20230907   gcc  
x86_64                randconfig-005-20230907   gcc  
x86_64                randconfig-006-20230907   gcc  
x86_64                randconfig-011-20230907   clang
x86_64                randconfig-012-20230907   clang
x86_64                randconfig-013-20230907   clang
x86_64                randconfig-014-20230907   clang
x86_64                randconfig-015-20230907   clang
x86_64                randconfig-016-20230907   clang
x86_64                randconfig-071-20230907   clang
x86_64                randconfig-072-20230907   clang
x86_64                randconfig-073-20230907   clang
x86_64                randconfig-074-20230907   clang
x86_64                randconfig-075-20230907   clang
x86_64                randconfig-076-20230907   clang
x86_64               randconfig-r036-20230907   clang
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
xtensa               randconfig-r013-20230907   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

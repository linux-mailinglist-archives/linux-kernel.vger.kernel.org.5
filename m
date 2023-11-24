Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B37F727E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbjKXLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKXLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:12:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA2D67
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700824372; x=1732360372;
  h=date:from:to:cc:subject:message-id;
  bh=J+K8sgFWcUID/V6Vx36LO1aQm7j+Q5PwhKWiAJGN/pA=;
  b=bVhO8jEV/NZa8+vjG+gtJcwVqQg6xtOpz1BT8jUxjvjzR2ZM2aN8KSQe
   N78MwyGAvGWomxjTXKeb/rSqfGLfEkc9TrgVNhwpKb4n57uZTs5TO9EUJ
   cp8nStPeceWrGRiX00IRStGYRfRko9vG08Xn3db2EhZQLJFZhrIoYH2nu
   PCfMEQ8dLT3jJb68Wga0ou0/nHebtS20k5BdaHCpju3pYmG5imGCsnzHd
   iES4bakMaowz4Xbn2VppLTpJvP5nnamPCavbIjltdJrQxGnP0jGY4Z7iN
   S1E0/6shku5UlTzwHslEn9BmKoK2RLvL3LARlhpVEd57ok0DIYMcd8K4j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5563409"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="5563409"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="9106773"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Nov 2023 03:12:17 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6U6Z-0002fw-0P;
        Fri, 24 Nov 2023 11:12:15 +0000
Date:   Fri, 24 Nov 2023 19:11:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp] BUILD SUCCESS
 1b56c90018f0e2bc76064ed6c90d146d5a7f998f
Message-ID: <202311241947.heVg8Qmm-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 1b56c90018f0e2bc76064ed6c90d146d5a7f998f  Makefile: Enable -Wstringop-overflow globally

elapsed time: 3767m

configs tested: 210
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                   randconfig-001-20231122   gcc  
arc                   randconfig-001-20231123   gcc  
arc                   randconfig-002-20231122   gcc  
arc                   randconfig-002-20231123   gcc  
arm                              allmodconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231123   gcc  
arm                   randconfig-002-20231123   gcc  
arm                   randconfig-003-20231123   gcc  
arm                   randconfig-004-20231123   gcc  
arm                           sunxi_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allmodconfig   clang
arm64                            allyesconfig   clang
arm64                 randconfig-001-20231123   gcc  
arm64                 randconfig-002-20231123   gcc  
arm64                 randconfig-003-20231123   gcc  
arm64                 randconfig-004-20231123   gcc  
csky                  randconfig-001-20231122   gcc  
csky                  randconfig-001-20231123   gcc  
csky                  randconfig-002-20231122   gcc  
csky                  randconfig-002-20231123   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231122   gcc  
i386                  randconfig-011-20231123   clang
i386                  randconfig-012-20231122   gcc  
i386                  randconfig-012-20231123   clang
i386                  randconfig-013-20231122   gcc  
i386                  randconfig-013-20231123   clang
i386                  randconfig-014-20231122   gcc  
i386                  randconfig-014-20231123   clang
i386                  randconfig-015-20231122   gcc  
i386                  randconfig-015-20231123   clang
i386                  randconfig-016-20231122   gcc  
i386                  randconfig-016-20231123   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231122   gcc  
loongarch             randconfig-001-20231123   gcc  
loongarch             randconfig-002-20231122   gcc  
loongarch             randconfig-002-20231123   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231122   gcc  
nios2                 randconfig-001-20231123   gcc  
nios2                 randconfig-002-20231122   gcc  
nios2                 randconfig-002-20231123   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231122   gcc  
parisc                randconfig-001-20231123   gcc  
parisc                randconfig-002-20231122   gcc  
parisc                randconfig-002-20231123   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20231123   gcc  
powerpc               randconfig-002-20231123   gcc  
powerpc               randconfig-003-20231123   gcc  
powerpc64                           defconfig   gcc  
powerpc64             randconfig-001-20231123   gcc  
powerpc64             randconfig-002-20231123   gcc  
powerpc64             randconfig-003-20231123   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231123   gcc  
riscv                 randconfig-002-20231123   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231122   gcc  
s390                  randconfig-002-20231122   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231122   gcc  
sh                    randconfig-001-20231123   gcc  
sh                    randconfig-002-20231122   gcc  
sh                    randconfig-002-20231123   gcc  
sh                           se7724_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231122   gcc  
sparc64               randconfig-001-20231123   gcc  
sparc64               randconfig-002-20231122   gcc  
sparc64               randconfig-002-20231123   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231123   gcc  
um                    randconfig-002-20231123   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-001-20231123   gcc  
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-002-20231123   gcc  
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-003-20231123   gcc  
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-004-20231123   gcc  
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-005-20231123   gcc  
x86_64       buildonly-randconfig-006-20231122   clang
x86_64       buildonly-randconfig-006-20231123   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231122   clang
x86_64                randconfig-011-20231123   gcc  
x86_64                randconfig-012-20231122   clang
x86_64                randconfig-012-20231123   gcc  
x86_64                randconfig-013-20231122   clang
x86_64                randconfig-013-20231123   gcc  
x86_64                randconfig-014-20231122   clang
x86_64                randconfig-014-20231123   gcc  
x86_64                randconfig-015-20231122   clang
x86_64                randconfig-015-20231123   gcc  
x86_64                randconfig-016-20231122   clang
x86_64                randconfig-016-20231123   gcc  
x86_64                randconfig-071-20231122   clang
x86_64                randconfig-071-20231123   gcc  
x86_64                randconfig-072-20231122   clang
x86_64                randconfig-072-20231123   gcc  
x86_64                randconfig-073-20231122   clang
x86_64                randconfig-073-20231123   gcc  
x86_64                randconfig-074-20231122   clang
x86_64                randconfig-074-20231123   gcc  
x86_64                randconfig-075-20231122   clang
x86_64                randconfig-075-20231123   gcc  
x86_64                randconfig-076-20231122   clang
x86_64                randconfig-076-20231123   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231122   gcc  
xtensa                randconfig-001-20231123   gcc  
xtensa                randconfig-002-20231122   gcc  
xtensa                randconfig-002-20231123   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

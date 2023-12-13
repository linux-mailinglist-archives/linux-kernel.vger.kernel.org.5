Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506A811D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjLMSnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:43:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14620D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702493038; x=1734029038;
  h=date:from:to:cc:subject:message-id;
  bh=avLQDMbZBffj9fLsdFLaWaAvIcxb0Otq6r2+dUlAHYU=;
  b=PVKh67GdKEcyK+mpUfD8JfVwmvgL9Sq5OmnbzClD1ILpkDEKMePauOGp
   pbDpSMTwuA6hNshmLB5fZxowaWKu9bYWsH8NUb02mgJ4NOGnEI9k/PHaR
   R4WuI6J3kO0GiMWNXnXBAlIxp5gUSgG6bRWKJ/PSXrGeQdCaWFTg3wpW/
   9T8NRHuT1MtFJKo4kZbIzGPbwo8IM/zpSr17mBeTh8m1tnjkq6UKkKz2d
   Ux722jywrDAK7h73STBfwcQ54jbYBnVa4Ld/MVy7nWeEIFfAPAouYFlhk
   xnh1LTvrLpGw3G18BPwS/UdCY0HTHUXgHGVG3f4L+HmbJtLo1M9NWpmqa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2092996"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2092996"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:43:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777600038"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="777600038"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Dec 2023 10:43:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDUD3-000L1H-0x;
        Wed, 13 Dec 2023 18:43:53 +0000
Date:   Thu, 14 Dec 2023 02:43:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 b99b7500cad2195b8f16e29986735ea884fa4a7a
Message-ID: <202312140245.MHuMAQU6-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: b99b7500cad2195b8f16e29986735ea884fa4a7a  Merge branch 'x86/tdx' into x86/merge, to ease integration testing

elapsed time: 1475m

configs tested: 198
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231213   gcc  
arc                   randconfig-002-20231213   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231213   clang
arm                   randconfig-002-20231213   clang
arm                   randconfig-003-20231213   clang
arm                   randconfig-004-20231213   clang
arm                             rpc_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231213   clang
arm64                 randconfig-002-20231213   clang
arm64                 randconfig-003-20231213   clang
arm64                 randconfig-004-20231213   clang
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231213   gcc  
csky                  randconfig-002-20231213   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231213   clang
hexagon               randconfig-002-20231213   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231213   clang
i386         buildonly-randconfig-002-20231213   clang
i386         buildonly-randconfig-003-20231213   clang
i386         buildonly-randconfig-004-20231213   clang
i386         buildonly-randconfig-005-20231213   clang
i386         buildonly-randconfig-006-20231213   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231213   clang
i386                  randconfig-002-20231213   clang
i386                  randconfig-003-20231213   clang
i386                  randconfig-004-20231213   clang
i386                  randconfig-005-20231213   clang
i386                  randconfig-006-20231213   clang
i386                  randconfig-011-20231213   gcc  
i386                  randconfig-012-20231213   gcc  
i386                  randconfig-013-20231213   gcc  
i386                  randconfig-014-20231213   gcc  
i386                  randconfig-015-20231213   gcc  
i386                  randconfig-016-20231213   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231213   gcc  
loongarch             randconfig-002-20231213   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                           rs90_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231213   gcc  
nios2                 randconfig-002-20231213   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231213   gcc  
parisc                randconfig-002-20231213   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231213   clang
powerpc               randconfig-002-20231213   clang
powerpc               randconfig-003-20231213   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc64             randconfig-001-20231213   clang
powerpc64             randconfig-002-20231213   clang
powerpc64             randconfig-003-20231213   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231213   clang
riscv                 randconfig-002-20231213   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231213   gcc  
s390                  randconfig-002-20231213   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231213   gcc  
sh                    randconfig-002-20231213   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231213   gcc  
sparc64               randconfig-002-20231213   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231213   clang
um                    randconfig-002-20231213   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231213   clang
x86_64       buildonly-randconfig-002-20231213   clang
x86_64       buildonly-randconfig-003-20231213   clang
x86_64       buildonly-randconfig-004-20231213   clang
x86_64       buildonly-randconfig-005-20231213   clang
x86_64       buildonly-randconfig-006-20231213   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231213   gcc  
x86_64                randconfig-002-20231213   gcc  
x86_64                randconfig-003-20231213   gcc  
x86_64                randconfig-004-20231213   gcc  
x86_64                randconfig-005-20231213   gcc  
x86_64                randconfig-006-20231213   gcc  
x86_64                randconfig-011-20231213   clang
x86_64                randconfig-012-20231213   clang
x86_64                randconfig-013-20231213   clang
x86_64                randconfig-014-20231213   clang
x86_64                randconfig-015-20231213   clang
x86_64                randconfig-016-20231213   clang
x86_64                randconfig-071-20231213   clang
x86_64                randconfig-072-20231213   clang
x86_64                randconfig-073-20231213   clang
x86_64                randconfig-074-20231213   clang
x86_64                randconfig-075-20231213   clang
x86_64                randconfig-076-20231213   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231213   gcc  
xtensa                randconfig-002-20231213   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFF8028F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjLCXYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjLCXYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:24:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9FDD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 15:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701645862; x=1733181862;
  h=date:from:to:cc:subject:message-id;
  bh=VJsSimC9WYOprzVuiQOq2FhMR3jpBkE7EI8C6mP2W/8=;
  b=fJyfY56k329xEWLNYjmao4fOjTlHngjm5sYjaotxqh+aANqC1dTPqhFZ
   4R0uJY30Wflba7LxqiYFxkGWzZC+D/P09pp3f3bWe/1/MlVXnWObBAjzZ
   0AXn7PK+5uSrrWauudvGM8UJyYbS60cDsYdGl0v9+eh+Yj+2SxITXORz4
   6go+x7UhiVMoh/JzIIz4TxSs4bNdkOI++5K+8VcdA4SRi6GnjWGrFcS8x
   6fteA0YibmPcTaryB9tj9/J/ZwSVd6JkB5MKYYH6YkSxOSawLa5u9YkWb
   ZFeFz+NphWVzta6A5TbmmuMjgrDvSoI90uI1oxtnKwY01bun11Y4lkUy4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="397550895"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="397550895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 15:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="799407351"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="799407351"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2023 15:24:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9vov-0007Di-2L;
        Sun, 03 Dec 2023 23:24:17 +0000
Date:   Mon, 04 Dec 2023 07:24:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 9c21ea53e6bd1104c637b80a0688040f184cc761
Message-ID: <202312040705.wmUxWaZL-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 9c21ea53e6bd1104c637b80a0688040f184cc761  x86/microcode/intel: Set new revision only after a successful update

elapsed time: 722m

configs tested: 127
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arm                               allnoconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231203   gcc  
i386         buildonly-randconfig-002-20231203   gcc  
i386         buildonly-randconfig-003-20231203   gcc  
i386         buildonly-randconfig-004-20231203   gcc  
i386         buildonly-randconfig-005-20231203   gcc  
i386         buildonly-randconfig-006-20231203   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231203   gcc  
i386                  randconfig-002-20231203   gcc  
i386                  randconfig-003-20231203   gcc  
i386                  randconfig-004-20231203   gcc  
i386                  randconfig-005-20231203   gcc  
i386                  randconfig-006-20231203   gcc  
i386                  randconfig-011-20231203   clang
i386                  randconfig-012-20231203   clang
i386                  randconfig-013-20231203   clang
i386                  randconfig-014-20231203   clang
i386                  randconfig-015-20231203   clang
i386                  randconfig-016-20231203   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip32_defconfig   gcc  
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
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231203   gcc  
x86_64       buildonly-randconfig-002-20231203   gcc  
x86_64       buildonly-randconfig-003-20231203   gcc  
x86_64       buildonly-randconfig-004-20231203   gcc  
x86_64       buildonly-randconfig-005-20231203   gcc  
x86_64       buildonly-randconfig-006-20231203   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231203   clang
x86_64                randconfig-002-20231203   clang
x86_64                randconfig-003-20231203   clang
x86_64                randconfig-004-20231203   clang
x86_64                randconfig-005-20231203   clang
x86_64                randconfig-006-20231203   clang
x86_64                randconfig-011-20231203   gcc  
x86_64                randconfig-012-20231203   gcc  
x86_64                randconfig-013-20231203   gcc  
x86_64                randconfig-014-20231203   gcc  
x86_64                randconfig-015-20231203   gcc  
x86_64                randconfig-016-20231203   gcc  
x86_64                randconfig-071-20231203   gcc  
x86_64                randconfig-072-20231203   gcc  
x86_64                randconfig-073-20231203   gcc  
x86_64                randconfig-074-20231203   gcc  
x86_64                randconfig-075-20231203   gcc  
x86_64                randconfig-076-20231203   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

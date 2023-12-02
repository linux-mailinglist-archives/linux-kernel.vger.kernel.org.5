Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97A2801F47
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjLBW65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBW64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:58:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F3F3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701557943; x=1733093943;
  h=date:from:to:cc:subject:message-id;
  bh=ohlk2l0CqQH3Po+K44/VMEOqcUfNklw4hlPwmpOdaX8=;
  b=M9ZJW+Au/kIc7X4oRKkoScpzWmJOdNI8UoDFN+BqCvVj171mSu2K1l44
   p+GTPOIZqxfkjRwteEzTvet4WmJAGoFP+YMg4Uj9OoFMCzMSsoYgrX3KG
   ZpDwd8JVO7BM4iH/tnQfDaAM/8f6prh/XNqqO4078bqJK9QaEJ/a3yv8Q
   HleNVq79ezFaaVlQHytgaZqC/J6x0K6xjrlLfDnv3TnHVJG4wlGmcuzLl
   OlmgBXzHlZrtLGJAt/1THYXoJmm8LOZPAUkcVkTiwW1g7tJ847hqQq8a1
   pMD8PRIewJ3XbOrEKXruYxrkqse9pkW7sc5jpjG0EtjMPr3jeFyg74nHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="664259"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="664259"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 14:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770104445"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770104445"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 14:59:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9Ywt-0005tx-0M;
        Sat, 02 Dec 2023 22:58:59 +0000
Date:   Sun, 03 Dec 2023 06:58:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9b8493dc43044376716d789d07699f17d538a7c4
Message-ID: <202312030623.ueQh3OZI-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9b8493dc43044376716d789d07699f17d538a7c4  x86/CPU/AMD: Check vendor in the AMD microcode callback

elapsed time: 728m

configs tested: 182
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231202   gcc  
arc                   randconfig-002-20231202   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231202   gcc  
csky                  randconfig-002-20231202   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231202   clang
i386         buildonly-randconfig-002-20231202   clang
i386         buildonly-randconfig-003-20231202   clang
i386         buildonly-randconfig-004-20231202   clang
i386         buildonly-randconfig-005-20231202   clang
i386         buildonly-randconfig-006-20231202   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231202   clang
i386                  randconfig-002-20231202   clang
i386                  randconfig-003-20231202   clang
i386                  randconfig-004-20231202   clang
i386                  randconfig-005-20231202   clang
i386                  randconfig-006-20231202   clang
i386                  randconfig-011-20231202   gcc  
i386                  randconfig-011-20231203   clang
i386                  randconfig-012-20231202   gcc  
i386                  randconfig-012-20231203   clang
i386                  randconfig-013-20231202   gcc  
i386                  randconfig-013-20231203   clang
i386                  randconfig-014-20231202   gcc  
i386                  randconfig-014-20231203   clang
i386                  randconfig-015-20231202   gcc  
i386                  randconfig-015-20231203   clang
i386                  randconfig-016-20231202   gcc  
i386                  randconfig-016-20231203   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231202   gcc  
loongarch             randconfig-002-20231202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231202   gcc  
nios2                 randconfig-002-20231202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231202   gcc  
parisc                randconfig-002-20231202   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231202   gcc  
s390                  randconfig-002-20231202   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20231202   gcc  
sh                    randconfig-002-20231202   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231202   gcc  
sparc64               randconfig-002-20231202   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231202   clang
x86_64       buildonly-randconfig-001-20231203   gcc  
x86_64       buildonly-randconfig-002-20231202   clang
x86_64       buildonly-randconfig-002-20231203   gcc  
x86_64       buildonly-randconfig-003-20231202   clang
x86_64       buildonly-randconfig-003-20231203   gcc  
x86_64       buildonly-randconfig-004-20231202   clang
x86_64       buildonly-randconfig-004-20231203   gcc  
x86_64       buildonly-randconfig-005-20231202   clang
x86_64       buildonly-randconfig-005-20231203   gcc  
x86_64       buildonly-randconfig-006-20231202   clang
x86_64       buildonly-randconfig-006-20231203   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231202   gcc  
x86_64                randconfig-002-20231202   gcc  
x86_64                randconfig-003-20231202   gcc  
x86_64                randconfig-004-20231202   gcc  
x86_64                randconfig-005-20231202   gcc  
x86_64                randconfig-006-20231202   gcc  
x86_64                randconfig-011-20231202   clang
x86_64                randconfig-011-20231203   gcc  
x86_64                randconfig-012-20231202   clang
x86_64                randconfig-012-20231203   gcc  
x86_64                randconfig-013-20231202   clang
x86_64                randconfig-013-20231203   gcc  
x86_64                randconfig-014-20231202   clang
x86_64                randconfig-014-20231203   gcc  
x86_64                randconfig-015-20231202   clang
x86_64                randconfig-015-20231203   gcc  
x86_64                randconfig-016-20231202   clang
x86_64                randconfig-016-20231203   gcc  
x86_64                randconfig-071-20231202   clang
x86_64                randconfig-071-20231203   gcc  
x86_64                randconfig-072-20231202   clang
x86_64                randconfig-072-20231203   gcc  
x86_64                randconfig-073-20231202   clang
x86_64                randconfig-073-20231203   gcc  
x86_64                randconfig-074-20231202   clang
x86_64                randconfig-074-20231203   gcc  
x86_64                randconfig-075-20231202   clang
x86_64                randconfig-075-20231203   gcc  
x86_64                randconfig-076-20231202   clang
x86_64                randconfig-076-20231203   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20231202   gcc  
xtensa                randconfig-002-20231202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

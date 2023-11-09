Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700A7E71E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbjKITE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKITEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:04:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47F3C11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699556693; x=1731092693;
  h=date:from:to:cc:subject:message-id;
  bh=xERuk/lX4mdGwW6ZLOUNVd9mCc0zQB3h2lhNsQqH4XA=;
  b=fe6pEl8gWPLdw3Qtf3tZQYUPuC41m5I7DysoQg8qYmk00nVVIFNvkf97
   MoquVIbnbXu/JCjMLDpIqxvPBy28LLsXu5InJE/s9/QodVy2PHUPzDqYV
   7vGq652PDx/d8RVwvU7tEsjmtCggAhYH0B3dXeZaOczZCGdyrtRI0GDOc
   DsEgqaIUAeLRLV0wexOkkbjeoEThsxn+xlfP84l32kHoma/qbYznVnAQo
   3sfaIZ+slCG8ScCEytE9enFQLQQ1XUvMf3yr1nLW7jxZpXs7Pzb6s6N29
   emEJ45iFyoGnkTb2SQsAq/mGXDWbXHMCBsauEviPoGh3bvXgA5SGkzfs+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3090629"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="3090629"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:04:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="756981250"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="756981250"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2023 11:04:51 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1AKf-00094C-0W;
        Thu, 09 Nov 2023 19:04:49 +0000
Date:   Fri, 10 Nov 2023 03:04:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 25448a9ea9e3ad1bc83be87c218367289672865b
Message-ID: <202311100330.bFwvoTbL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 25448a9ea9e3ad1bc83be87c218367289672865b  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1455m

configs tested: 192
configs skipped: 3

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
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231109   gcc  
arm                   randconfig-002-20231109   gcc  
arm                   randconfig-003-20231109   gcc  
arm                   randconfig-004-20231109   gcc  
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   clang
arm                       versatile_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231109   gcc  
arm64                 randconfig-002-20231109   gcc  
arm64                 randconfig-003-20231109   gcc  
arm64                 randconfig-004-20231109   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231109   gcc  
i386         buildonly-randconfig-002-20231109   gcc  
i386         buildonly-randconfig-003-20231109   gcc  
i386         buildonly-randconfig-004-20231109   gcc  
i386         buildonly-randconfig-005-20231109   gcc  
i386         buildonly-randconfig-006-20231109   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231109   gcc  
i386                  randconfig-002-20231109   gcc  
i386                  randconfig-003-20231109   gcc  
i386                  randconfig-004-20231109   gcc  
i386                  randconfig-005-20231109   gcc  
i386                  randconfig-006-20231109   gcc  
i386                  randconfig-011-20231109   gcc  
i386                  randconfig-012-20231109   gcc  
i386                  randconfig-013-20231109   gcc  
i386                  randconfig-014-20231109   gcc  
i386                  randconfig-015-20231109   gcc  
i386                  randconfig-016-20231109   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231109   gcc  
nios2                 randconfig-002-20231109   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231109   gcc  
parisc                randconfig-002-20231109   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc               randconfig-001-20231109   gcc  
powerpc               randconfig-002-20231109   gcc  
powerpc               randconfig-003-20231109   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231109   gcc  
powerpc64             randconfig-002-20231109   gcc  
powerpc64             randconfig-003-20231109   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231109   gcc  
riscv                 randconfig-002-20231109   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231109   gcc  
s390                  randconfig-002-20231109   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231109   gcc  
sh                    randconfig-002-20231109   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231109   gcc  
sparc                 randconfig-002-20231109   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231109   gcc  
sparc64               randconfig-002-20231109   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231109   gcc  
um                    randconfig-002-20231109   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231109   gcc  
x86_64       buildonly-randconfig-002-20231109   gcc  
x86_64       buildonly-randconfig-003-20231109   gcc  
x86_64       buildonly-randconfig-004-20231109   gcc  
x86_64       buildonly-randconfig-005-20231109   gcc  
x86_64       buildonly-randconfig-006-20231109   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231109   gcc  
x86_64                randconfig-002-20231109   gcc  
x86_64                randconfig-003-20231109   gcc  
x86_64                randconfig-004-20231109   gcc  
x86_64                randconfig-005-20231109   gcc  
x86_64                randconfig-006-20231109   gcc  
x86_64                randconfig-011-20231109   gcc  
x86_64                randconfig-012-20231109   gcc  
x86_64                randconfig-013-20231109   gcc  
x86_64                randconfig-014-20231109   gcc  
x86_64                randconfig-015-20231109   gcc  
x86_64                randconfig-016-20231109   gcc  
x86_64                randconfig-071-20231109   gcc  
x86_64                randconfig-072-20231109   gcc  
x86_64                randconfig-073-20231109   gcc  
x86_64                randconfig-074-20231109   gcc  
x86_64                randconfig-075-20231109   gcc  
x86_64                randconfig-076-20231109   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231109   gcc  
xtensa                randconfig-002-20231109   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

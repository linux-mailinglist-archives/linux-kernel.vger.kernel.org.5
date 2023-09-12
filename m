Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073F79D9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjILTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjILTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:49:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4F115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694548159; x=1726084159;
  h=date:from:to:cc:subject:message-id;
  bh=Sldk+VtcX1HO+8/mWVVlVMHXfUquYirvKPZ5VHmYOb4=;
  b=W1UxwyrbC3lmb3dlE6rcdYGFTD9JpiDBG4m76KUNpGuprjkNjZ5lEcoR
   07yM8lboHxShFvXUV7RkSmgQfqMe/jz8YWOEvyer307SbIN33IB2i765I
   zy7/l23NqzdUvycCLyAkU4qVCYZsxBMvZMGjVxLERxkNeRCDrY2oaB+1Y
   Yj54okDNvRzuNUfgSA9rGrYj+IJOHf5mY3eAs0NnJ+23DCsaKDznYB6Py
   qGm61Fdy4Lw5JzZw57ldpHYVideO1O6O0ygm/hE96pZE5Zog0TVC6CrM1
   ee0AmvVR1T2z3oLmbeZjN0UxUtSEcJBSdHi8rZR0ZyurnZdTIYVELCLBc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381177198"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="381177198"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 12:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="813973470"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="813973470"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2023 12:49:17 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg9Nr-0000CY-0g;
        Tue, 12 Sep 2023 19:49:15 +0000
Date:   Wed, 13 Sep 2023 03:49:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f4245833f91ce183a8dc43ef8adebaf333b272be
Message-ID: <202309130308.vo5XOTDS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f4245833f91ce183a8dc43ef8adebaf333b272be  Merge branch into tip/master: 'x86/tdx'

elapsed time: 734m

configs tested: 243
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230912   gcc  
alpha                randconfig-r014-20230913   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r015-20230912   gcc  
arc                  randconfig-r036-20230912   gcc  
arc                        vdk_hs38_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20230912   clang
arm                  randconfig-r004-20230913   clang
arm                  randconfig-r035-20230912   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230912   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230912   gcc  
csky                 randconfig-r025-20230912   gcc  
hexagon               randconfig-001-20230912   clang
hexagon               randconfig-001-20230913   clang
hexagon               randconfig-002-20230912   clang
hexagon               randconfig-002-20230913   clang
hexagon              randconfig-r005-20230913   clang
hexagon              randconfig-r022-20230912   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230912   clang
i386         buildonly-randconfig-001-20230913   gcc  
i386         buildonly-randconfig-002-20230912   clang
i386         buildonly-randconfig-002-20230913   gcc  
i386         buildonly-randconfig-003-20230912   clang
i386         buildonly-randconfig-003-20230913   gcc  
i386         buildonly-randconfig-004-20230912   clang
i386         buildonly-randconfig-004-20230913   gcc  
i386         buildonly-randconfig-005-20230912   clang
i386         buildonly-randconfig-005-20230913   gcc  
i386         buildonly-randconfig-006-20230912   clang
i386         buildonly-randconfig-006-20230913   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230912   clang
i386                  randconfig-001-20230913   gcc  
i386                  randconfig-002-20230912   clang
i386                  randconfig-002-20230913   gcc  
i386                  randconfig-003-20230912   clang
i386                  randconfig-003-20230913   gcc  
i386                  randconfig-004-20230912   clang
i386                  randconfig-004-20230913   gcc  
i386                  randconfig-005-20230912   clang
i386                  randconfig-005-20230913   gcc  
i386                  randconfig-006-20230912   clang
i386                  randconfig-006-20230913   gcc  
i386                  randconfig-011-20230912   gcc  
i386                  randconfig-011-20230913   clang
i386                  randconfig-012-20230912   gcc  
i386                  randconfig-012-20230913   clang
i386                  randconfig-013-20230912   gcc  
i386                  randconfig-013-20230913   clang
i386                  randconfig-014-20230912   gcc  
i386                  randconfig-014-20230913   clang
i386                  randconfig-015-20230912   gcc  
i386                  randconfig-015-20230913   clang
i386                  randconfig-016-20230912   gcc  
i386                  randconfig-016-20230913   clang
i386                 randconfig-r015-20230912   gcc  
i386                 randconfig-r021-20230912   gcc  
i386                 randconfig-r032-20230912   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230912   gcc  
loongarch             randconfig-001-20230913   gcc  
loongarch            randconfig-r011-20230912   gcc  
loongarch            randconfig-r014-20230912   gcc  
loongarch            randconfig-r031-20230912   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r011-20230912   gcc  
microblaze           randconfig-r015-20230913   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                 randconfig-r006-20230913   clang
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230912   gcc  
nios2                randconfig-r022-20230912   gcc  
nios2                randconfig-r033-20230913   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r013-20230913   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230912   gcc  
parisc               randconfig-r035-20230913   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc              randconfig-r013-20230912   gcc  
powerpc              randconfig-r026-20230912   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc64            randconfig-r016-20230912   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20230912   clang
riscv                randconfig-r011-20230912   gcc  
riscv                randconfig-r014-20230912   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230913   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r034-20230912   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230913   gcc  
sparc                randconfig-r036-20230913   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230912   gcc  
sparc64              randconfig-r015-20230912   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230913   clang
um                   randconfig-r023-20230912   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230912   clang
x86_64       buildonly-randconfig-001-20230913   gcc  
x86_64       buildonly-randconfig-002-20230912   clang
x86_64       buildonly-randconfig-002-20230913   gcc  
x86_64       buildonly-randconfig-003-20230912   clang
x86_64       buildonly-randconfig-003-20230913   gcc  
x86_64       buildonly-randconfig-004-20230912   clang
x86_64       buildonly-randconfig-004-20230913   gcc  
x86_64       buildonly-randconfig-005-20230912   clang
x86_64       buildonly-randconfig-005-20230913   gcc  
x86_64       buildonly-randconfig-006-20230912   clang
x86_64       buildonly-randconfig-006-20230913   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230912   gcc  
x86_64                randconfig-002-20230912   gcc  
x86_64                randconfig-003-20230912   gcc  
x86_64                randconfig-004-20230912   gcc  
x86_64                randconfig-005-20230912   gcc  
x86_64                randconfig-006-20230912   gcc  
x86_64                randconfig-011-20230912   clang
x86_64                randconfig-011-20230913   gcc  
x86_64                randconfig-012-20230912   clang
x86_64                randconfig-012-20230913   gcc  
x86_64                randconfig-013-20230912   clang
x86_64                randconfig-013-20230913   gcc  
x86_64                randconfig-014-20230912   clang
x86_64                randconfig-014-20230913   gcc  
x86_64                randconfig-015-20230912   clang
x86_64                randconfig-015-20230913   gcc  
x86_64                randconfig-016-20230912   clang
x86_64                randconfig-016-20230913   gcc  
x86_64                randconfig-071-20230912   clang
x86_64                randconfig-071-20230913   gcc  
x86_64                randconfig-072-20230912   clang
x86_64                randconfig-072-20230913   gcc  
x86_64                randconfig-073-20230912   clang
x86_64                randconfig-073-20230913   gcc  
x86_64                randconfig-074-20230912   clang
x86_64                randconfig-074-20230913   gcc  
x86_64                randconfig-075-20230912   clang
x86_64                randconfig-075-20230913   gcc  
x86_64                randconfig-076-20230912   clang
x86_64                randconfig-076-20230913   gcc  
x86_64               randconfig-r031-20230912   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r016-20230913   gcc  
xtensa               randconfig-r024-20230912   gcc  
xtensa               randconfig-r032-20230912   gcc  
xtensa               randconfig-r034-20230913   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

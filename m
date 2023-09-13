Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6E79E0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjIMHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjIMHdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:33:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDA11728
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694590390; x=1726126390;
  h=date:from:to:cc:subject:message-id;
  bh=Uddu2VJbJj0ExbkwxeI8/BZF5I0bi4/V0s4z+X2TzZ4=;
  b=J+qNOVpl1/kPBs4HxDxFuwmgQ/8MMXRctvI41T8F9FXsHJ/lMk7CgJaz
   XuC977TguL1k0k6X9TS0UN7ji7qti3v/ZV0RKA9hkwbGyBZ7nGcPyivAF
   WlGgASlmRRcUT/ODMcpjXzJV49M8CwhVOS8fFFkE9A94nFChS98ov73P3
   yMLMihDI5Zapiej47wnBPsze3w2B295rpuoKfH7PSiAxgwtQ8eSV9IW9C
   gmlQ5ux5NvSKvyaOBKg/YY4g2MshO2JvfVR5NbQvZOIwqicDwDXmBAjlo
   IiLiglGvviCs2iL0bVou1NZPQO/N5cz494qPJcrHA6VnU/SagfUJz022b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409537861"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="409537861"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737401094"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="737401094"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2023 00:33:07 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgKMy-0000D5-05;
        Wed, 13 Sep 2023 07:33:04 +0000
Date:   Wed, 13 Sep 2023 15:30:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7575e5a35267983dcbeb1e0d3a49d21ae3cf0b82
Message-ID: <202309131532.d2A2ngqz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7575e5a35267983dcbeb1e0d3a49d21ae3cf0b82  x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()

elapsed time: 924m

configs tested: 231
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230913   gcc  
alpha                randconfig-r015-20230913   gcc  
alpha                randconfig-r021-20230913   gcc  
alpha                randconfig-r036-20230913   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20230913   gcc  
arc                  randconfig-r013-20230913   gcc  
arc                  randconfig-r035-20230913   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20230913   gcc  
arm                  randconfig-r015-20230913   gcc  
arm                  randconfig-r016-20230913   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230913   gcc  
arm64                randconfig-r035-20230913   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230913   gcc  
csky                 randconfig-r021-20230913   gcc  
hexagon               randconfig-001-20230913   clang
hexagon               randconfig-002-20230913   clang
hexagon              randconfig-r022-20230913   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230913   gcc  
i386         buildonly-randconfig-002-20230913   gcc  
i386         buildonly-randconfig-003-20230913   gcc  
i386         buildonly-randconfig-004-20230913   gcc  
i386         buildonly-randconfig-005-20230913   gcc  
i386         buildonly-randconfig-006-20230913   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230913   gcc  
i386                  randconfig-002-20230913   gcc  
i386                  randconfig-003-20230913   gcc  
i386                  randconfig-004-20230913   gcc  
i386                  randconfig-005-20230913   gcc  
i386                  randconfig-006-20230913   gcc  
i386                  randconfig-011-20230913   clang
i386                  randconfig-012-20230913   clang
i386                  randconfig-013-20230913   clang
i386                  randconfig-014-20230913   clang
i386                  randconfig-015-20230913   clang
i386                  randconfig-016-20230913   clang
i386                 randconfig-r005-20230913   gcc  
i386                 randconfig-r006-20230913   gcc  
i386                 randconfig-r035-20230913   gcc  
i386                 randconfig-r036-20230913   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230913   gcc  
loongarch            randconfig-r004-20230913   gcc  
loongarch            randconfig-r006-20230913   gcc  
loongarch            randconfig-r026-20230913   gcc  
loongarch            randconfig-r032-20230913   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                 randconfig-r003-20230913   gcc  
m68k                 randconfig-r004-20230913   gcc  
m68k                 randconfig-r012-20230913   gcc  
m68k                 randconfig-r014-20230913   gcc  
m68k                 randconfig-r022-20230913   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r002-20230913   gcc  
microblaze           randconfig-r013-20230913   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                 randconfig-r016-20230913   gcc  
mips                 randconfig-r025-20230913   gcc  
mips                 randconfig-r036-20230913   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230913   gcc  
nios2                randconfig-r031-20230913   gcc  
nios2                randconfig-r033-20230913   gcc  
nios2                randconfig-r034-20230913   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r016-20230913   gcc  
openrisc             randconfig-r031-20230913   gcc  
openrisc             randconfig-r032-20230913   gcc  
openrisc             randconfig-r033-20230913   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230913   gcc  
parisc               randconfig-r024-20230913   gcc  
parisc               randconfig-r035-20230913   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r016-20230913   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc64            randconfig-r001-20230913   gcc  
powerpc64            randconfig-r024-20230913   clang
powerpc64            randconfig-r031-20230913   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20230913   gcc  
riscv                randconfig-r001-20230913   gcc  
riscv                randconfig-r033-20230913   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230913   clang
s390                 randconfig-r023-20230913   clang
s390                 randconfig-r031-20230913   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r002-20230913   gcc  
sh                   randconfig-r011-20230913   gcc  
sh                   randconfig-r015-20230913   gcc  
sh                   randconfig-r036-20230913   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230913   gcc  
sparc                randconfig-r033-20230913   gcc  
sparc                randconfig-r036-20230913   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230913   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r025-20230913   gcc  
um                   randconfig-r026-20230913   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230913   gcc  
x86_64       buildonly-randconfig-002-20230913   gcc  
x86_64       buildonly-randconfig-003-20230913   gcc  
x86_64       buildonly-randconfig-004-20230913   gcc  
x86_64       buildonly-randconfig-005-20230913   gcc  
x86_64       buildonly-randconfig-006-20230913   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230913   clang
x86_64                randconfig-002-20230913   clang
x86_64                randconfig-003-20230913   clang
x86_64                randconfig-004-20230913   clang
x86_64                randconfig-005-20230913   clang
x86_64                randconfig-006-20230913   clang
x86_64                randconfig-011-20230913   gcc  
x86_64                randconfig-012-20230913   gcc  
x86_64                randconfig-013-20230913   gcc  
x86_64                randconfig-014-20230913   gcc  
x86_64                randconfig-015-20230913   gcc  
x86_64                randconfig-016-20230913   gcc  
x86_64                randconfig-071-20230913   gcc  
x86_64                randconfig-072-20230913   gcc  
x86_64                randconfig-073-20230913   gcc  
x86_64                randconfig-074-20230913   gcc  
x86_64                randconfig-075-20230913   gcc  
x86_64                randconfig-076-20230913   gcc  
x86_64               randconfig-r032-20230913   gcc  
x86_64               randconfig-r034-20230913   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r011-20230913   gcc  
xtensa               randconfig-r014-20230913   gcc  
xtensa               randconfig-r034-20230913   gcc  
xtensa               randconfig-r035-20230913   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

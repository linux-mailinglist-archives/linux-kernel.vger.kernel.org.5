Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6D78A387
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjH0Xn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0XnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:43:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84288D9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693179787; x=1724715787;
  h=date:from:to:cc:subject:message-id;
  bh=JPjzG4bGn2vEyRugSyLweEQ3bfX6V1NNpuTIs6DQeSs=;
  b=il94BweM5X3DKTyIQqNSOsrupCI2gRxWWRO5Ch8K5gvpOVWdwxltxi/G
   gWeZVvxuM0LNlXBO2Rbmu7nYu7NSUTfT4Amma30A5PETkJ7TCCs+NW9FU
   vUvbYPwiJh8sm2vgneQ6yLbG2IUMS43YDnbxjj5YMcENPU8Dtp0NX6WkJ
   BnGNi4bumrHEogJYrI6cm7O7LrYgeZNHWAZ4ewiJMe9T+DOAEoIL9XKQ8
   wzs5wr6rN5FAgI+LfzNlV0TPu6a2j5nbS2DA/T6ceb208zRSDDMH6O2SW
   ITC5fwHjrTwpnk9sz6h+IPwycAGwsK/jmYwxh6m2uQbKAob6lIG9WBvz9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="359973813"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="359973813"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 16:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="741174598"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="741174598"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2023 16:43:06 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaPPN-0006JR-17;
        Sun, 27 Aug 2023 23:43:05 +0000
Date:   Mon, 28 Aug 2023 07:42:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c43963bb847e50d32e48a348036afd1198ca08bb
Message-ID: <202308280726.cg1SYwq9-lkp@intel.com>
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
branch HEAD: c43963bb847e50d32e48a348036afd1198ca08bb  Merge branch into tip/master: 'x86/sev'

elapsed time: 1734m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230827   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230827   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230827   clang
arm                  randconfig-r013-20230827   clang
arm                  randconfig-r016-20230827   clang
arm                  randconfig-r031-20230827   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230827   gcc  
arm64                randconfig-r021-20230827   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230827   gcc  
hexagon               randconfig-001-20230827   clang
hexagon               randconfig-002-20230827   clang
i386         buildonly-randconfig-001-20230827   clang
i386         buildonly-randconfig-002-20230827   clang
i386         buildonly-randconfig-003-20230827   clang
i386         buildonly-randconfig-004-20230827   clang
i386         buildonly-randconfig-005-20230827   clang
i386         buildonly-randconfig-006-20230827   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230827   clang
i386                  randconfig-002-20230827   clang
i386                  randconfig-003-20230827   clang
i386                  randconfig-004-20230827   clang
i386                  randconfig-005-20230827   clang
i386                  randconfig-006-20230827   clang
i386                  randconfig-011-20230827   gcc  
i386                  randconfig-012-20230827   gcc  
i386                  randconfig-013-20230827   gcc  
i386                  randconfig-014-20230827   gcc  
i386                  randconfig-015-20230827   gcc  
i386                  randconfig-016-20230827   gcc  
i386                 randconfig-r003-20230827   clang
i386                 randconfig-r014-20230827   gcc  
i386                 randconfig-r023-20230827   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230827   gcc  
loongarch            randconfig-r006-20230827   gcc  
loongarch            randconfig-r036-20230827   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r034-20230827   gcc  
openrisc             randconfig-r035-20230827   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230827   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc64            randconfig-r026-20230827   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230827   clang
riscv                randconfig-r005-20230827   clang
riscv                randconfig-r022-20230827   gcc  
riscv                randconfig-r033-20230827   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230827   gcc  
s390                 randconfig-r002-20230827   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r001-20230827   gcc  
sh                   randconfig-r004-20230827   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230827   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230827   clang
x86_64       buildonly-randconfig-002-20230827   clang
x86_64       buildonly-randconfig-003-20230827   clang
x86_64       buildonly-randconfig-004-20230827   clang
x86_64       buildonly-randconfig-005-20230827   clang
x86_64       buildonly-randconfig-006-20230827   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230827   gcc  
x86_64                randconfig-002-20230827   gcc  
x86_64                randconfig-003-20230827   gcc  
x86_64                randconfig-004-20230827   gcc  
x86_64                randconfig-005-20230827   gcc  
x86_64                randconfig-006-20230827   gcc  
x86_64                randconfig-011-20230827   clang
x86_64                randconfig-012-20230827   clang
x86_64                randconfig-013-20230827   clang
x86_64                randconfig-014-20230827   clang
x86_64                randconfig-015-20230827   clang
x86_64                randconfig-016-20230827   clang
x86_64                randconfig-071-20230827   clang
x86_64                randconfig-072-20230827   clang
x86_64                randconfig-073-20230827   clang
x86_64                randconfig-074-20230827   clang
x86_64                randconfig-075-20230827   clang
x86_64                randconfig-076-20230827   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r025-20230827   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

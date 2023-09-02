Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183017908A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjIBQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjIBQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:21:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F274E5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693671687; x=1725207687;
  h=date:from:to:cc:subject:message-id;
  bh=DG5hrnS1zrA0hC8kpxAw5zy2Al+BF2Gdulo0DeSakhE=;
  b=ZT7qXcokybqRbsHSf+w15zuPVWuGkW2dIL9SppH5bJQU3mRPDyKeXPLd
   +lQYg9S1EvQE728gbWpFHSjct9q9dEak1exej24Zbzv3MvAuv7EDoylU7
   AzMSb7AVbXpEWd91n1MwpvwmSEtOXtQrYDk+WjV3r7OFadFxEj/QpTA8W
   O1RaCp36qKowBY4f/bSv/QM8DVFO4rQOMmFd0HkRYSR/tymEPHde141hy
   MYxwjTtZ15+yLMCeacbm4dlXmpxFvVlLEtB+7wvSYVl0rXx0NsSwFFwbI
   vb6x5hoBMdxsL/7USvqKAQz+0c/tYvSHltB9njo6viEeRc1Gp/aCuGOPo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="376312479"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="376312479"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 09:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="775342147"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="775342147"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2023 09:21:25 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcTNC-0002Sn-36;
        Sat, 02 Sep 2023 16:21:22 +0000
Date:   Sun, 03 Sep 2023 00:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 6ea7bb00c1ba180f8bf8320b8d59b532501c5271
Message-ID: <202309030031.msIkWkry-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 6ea7bb00c1ba180f8bf8320b8d59b532501c5271  selftests/x86: Update map_shadow_stack syscall nr

elapsed time: 1099m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230902   gcc  
alpha                randconfig-r025-20230902   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230902   gcc  
arc                  randconfig-r002-20230902   gcc  
arc                  randconfig-r021-20230902   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230902   gcc  
arm                  randconfig-r031-20230902   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230902   gcc  
arm64                randconfig-r014-20230902   clang
arm64                randconfig-r036-20230902   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230902   gcc  
hexagon               randconfig-001-20230902   clang
hexagon               randconfig-002-20230902   clang
hexagon              randconfig-r034-20230902   clang
hexagon              randconfig-r035-20230902   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230902   gcc  
i386         buildonly-randconfig-002-20230902   gcc  
i386         buildonly-randconfig-003-20230902   gcc  
i386         buildonly-randconfig-004-20230902   gcc  
i386         buildonly-randconfig-005-20230902   gcc  
i386         buildonly-randconfig-006-20230902   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230902   gcc  
i386                  randconfig-002-20230902   gcc  
i386                  randconfig-003-20230902   gcc  
i386                  randconfig-004-20230902   gcc  
i386                  randconfig-005-20230902   gcc  
i386                  randconfig-006-20230902   gcc  
i386                  randconfig-011-20230902   clang
i386                  randconfig-012-20230902   clang
i386                  randconfig-013-20230902   clang
i386                  randconfig-014-20230902   clang
i386                  randconfig-015-20230902   clang
i386                  randconfig-016-20230902   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230902   gcc  
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
mips                 randconfig-r005-20230902   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230902   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r013-20230902   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230902   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230902   gcc  
riscv                randconfig-r012-20230902   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230902   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r011-20230902   gcc  
sh                   randconfig-r024-20230902   gcc  
sh                   randconfig-r032-20230902   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230902   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230902   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r026-20230902   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230902   gcc  
x86_64       buildonly-randconfig-002-20230902   gcc  
x86_64       buildonly-randconfig-003-20230902   gcc  
x86_64       buildonly-randconfig-004-20230902   gcc  
x86_64       buildonly-randconfig-005-20230902   gcc  
x86_64       buildonly-randconfig-006-20230902   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230902   clang
x86_64                randconfig-002-20230902   clang
x86_64                randconfig-003-20230902   clang
x86_64                randconfig-004-20230902   clang
x86_64                randconfig-005-20230902   clang
x86_64                randconfig-006-20230902   clang
x86_64                randconfig-011-20230902   gcc  
x86_64                randconfig-012-20230902   gcc  
x86_64                randconfig-013-20230902   gcc  
x86_64                randconfig-014-20230902   gcc  
x86_64                randconfig-015-20230902   gcc  
x86_64                randconfig-016-20230902   gcc  
x86_64                randconfig-071-20230902   gcc  
x86_64                randconfig-072-20230902   gcc  
x86_64                randconfig-073-20230902   gcc  
x86_64                randconfig-074-20230902   gcc  
x86_64                randconfig-075-20230902   gcc  
x86_64                randconfig-076-20230902   gcc  
x86_64               randconfig-r006-20230902   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r033-20230902   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

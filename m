Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67879266A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbjIEQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbjIECNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:13:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D09CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693880028; x=1725416028;
  h=date:from:to:cc:subject:message-id;
  bh=vCr0EwOK8zKZP5+3J2+mD9voGKjt2ccH5e/7/tNjFY0=;
  b=T1xqxF08wDB+3SLrk/6HNGsR0V9V5meXwSB1y07wuVC3k7AcGOvYaLB1
   2rfE5C0ItIwmEk2YDhdNkKlJfRTaJHf6vI9GMTde0bXR2GZc8hYc8YQZa
   VboqxX+6ojeQj93eXHhW2kHPsIUZFkGyTa4AwhpJ1UhwdO7CSMokAtuBv
   7ojFjVFisl8lfakBmbX/Bu45cUxqnIwu5cfNyutANbLpv526GAci9ZGDI
   1QQrjATVHSBEn0JKJeWr/HfMl7GWzeYRT7Uhgfp9xv76FVxs2ogQJ7cr+
   8DBLcfPSQxEHXZraWxr04Jm0uVgVKkD9JRLCNqL+U1MTWfgQCFu17rLnT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="463052913"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="463052913"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 19:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="987648022"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="987648022"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2023 19:13:45 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdLUs-00017v-34;
        Tue, 05 Sep 2023 02:10:36 +0000
Date:   Tue, 05 Sep 2023 10:08:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 3f874c9b2aae8e30463efc1872bea4baa9ed25dc
Message-ID: <202309051050.LCLBd8dQ-lkp@intel.com>
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
branch HEAD: 3f874c9b2aae8e30463efc1872bea4baa9ed25dc  x86/smp: Don't send INIT to non-present and non-booted CPUs

elapsed time: 725m

configs tested: 168
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230904   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20230904   gcc  
arm                  randconfig-r024-20230904   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230904   gcc  
arm64                randconfig-r003-20230904   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230904   clang
hexagon               randconfig-002-20230904   clang
hexagon              randconfig-r011-20230904   clang
hexagon              randconfig-r031-20230904   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230904   gcc  
i386         buildonly-randconfig-002-20230904   gcc  
i386         buildonly-randconfig-003-20230904   gcc  
i386         buildonly-randconfig-004-20230904   gcc  
i386         buildonly-randconfig-005-20230904   gcc  
i386         buildonly-randconfig-006-20230904   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230904   gcc  
i386                  randconfig-002-20230904   gcc  
i386                  randconfig-003-20230904   gcc  
i386                  randconfig-004-20230904   gcc  
i386                  randconfig-005-20230904   gcc  
i386                  randconfig-006-20230904   gcc  
i386                  randconfig-011-20230904   clang
i386                  randconfig-012-20230904   clang
i386                  randconfig-013-20230904   clang
i386                  randconfig-014-20230904   clang
i386                  randconfig-015-20230904   clang
i386                  randconfig-016-20230904   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230904   gcc  
loongarch            randconfig-r021-20230904   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230904   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r015-20230904   gcc  
microblaze           randconfig-r036-20230904   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   clang
mips                           ip32_defconfig   gcc  
mips                 randconfig-r013-20230904   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r022-20230904   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230904   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc              randconfig-r006-20230904   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64            randconfig-r012-20230904   clang
powerpc64            randconfig-r026-20230904   clang
powerpc64            randconfig-r034-20230904   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230904   gcc  
riscv                randconfig-r032-20230904   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230904   clang
s390                 randconfig-r002-20230904   gcc  
s390                 randconfig-r005-20230904   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r014-20230904   gcc  
sparc64              randconfig-r023-20230904   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230904   clang
um                   randconfig-r033-20230904   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230904   gcc  
x86_64       buildonly-randconfig-002-20230904   gcc  
x86_64       buildonly-randconfig-003-20230904   gcc  
x86_64       buildonly-randconfig-004-20230904   gcc  
x86_64       buildonly-randconfig-005-20230904   gcc  
x86_64       buildonly-randconfig-006-20230904   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230904   clang
x86_64                randconfig-002-20230904   clang
x86_64                randconfig-003-20230904   clang
x86_64                randconfig-004-20230904   clang
x86_64                randconfig-005-20230904   clang
x86_64                randconfig-006-20230904   clang
x86_64                randconfig-011-20230904   gcc  
x86_64                randconfig-012-20230904   gcc  
x86_64                randconfig-013-20230904   gcc  
x86_64                randconfig-014-20230904   gcc  
x86_64                randconfig-015-20230904   gcc  
x86_64                randconfig-016-20230904   gcc  
x86_64                randconfig-071-20230904   gcc  
x86_64                randconfig-072-20230904   gcc  
x86_64                randconfig-073-20230904   gcc  
x86_64                randconfig-074-20230904   gcc  
x86_64                randconfig-075-20230904   gcc  
x86_64                randconfig-076-20230904   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r025-20230904   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

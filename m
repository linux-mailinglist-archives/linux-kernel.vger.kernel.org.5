Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAB78EA49
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbjHaKhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbjHaKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:37:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D7CF4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693478266; x=1725014266;
  h=date:from:to:cc:subject:message-id;
  bh=n0x7Ty676YlAo8OWgSPbiP/3yn/9FyD22YjC1X1Xbq8=;
  b=JJ13vgrbA3JkKO+jlRmZTWF+gMomcGW2jx9mlInslOZQ3KDRr4gZYqQn
   5CcWEIFNkoE9MiPvx8DKHwdTlRyZiiUl3cA8ECspfAQAy0hK3cavHyhyG
   zwq6e/aTxql9oo3x73AvbUsQyC+xob9vqJoFhHEm6pRKhCpJ2RYkztss2
   jyM0IRFZnh38d/MpWUeTmPA880HMh90ViKtgZcdWwGdf3oHE9qsednBaf
   WedUjBqBGP8WrISv43Z+3ncIv3t9vJGJRoSpENWMAVK1LnC7moc6/uFYt
   wWYFN9A8xE0txDiwiHB/+p7EfLSqDL+D+f42ggDAoKeBguMqBw2YCeaZq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356209455"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="356209455"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="986185234"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="986185234"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2023 03:37:45 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbf3X-00002d-07;
        Thu, 31 Aug 2023 10:37:43 +0000
Date:   Thu, 31 Aug 2023 18:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 20f3360540dca2d18541e2a043e71e7ed735a22d
Message-ID: <202308311804.Rrivor7b-lkp@intel.com>
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
branch HEAD: 20f3360540dca2d18541e2a043e71e7ed735a22d  Merge branch into tip/master: 'x86/shstk'

elapsed time: 825m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230831   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230831   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230831   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230831   gcc  
hexagon               randconfig-001-20230831   clang
hexagon               randconfig-002-20230831   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230831   gcc  
i386         buildonly-randconfig-002-20230831   gcc  
i386         buildonly-randconfig-003-20230831   gcc  
i386         buildonly-randconfig-004-20230831   gcc  
i386         buildonly-randconfig-005-20230831   gcc  
i386         buildonly-randconfig-006-20230831   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230831   gcc  
i386                  randconfig-002-20230831   gcc  
i386                  randconfig-003-20230831   gcc  
i386                  randconfig-004-20230831   gcc  
i386                  randconfig-005-20230831   gcc  
i386                  randconfig-006-20230831   gcc  
i386                  randconfig-011-20230831   clang
i386                  randconfig-012-20230831   clang
i386                  randconfig-013-20230831   clang
i386                  randconfig-014-20230831   clang
i386                  randconfig-015-20230831   clang
i386                  randconfig-016-20230831   clang
i386                 randconfig-r024-20230831   clang
i386                 randconfig-r036-20230831   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230831   gcc  
loongarch            randconfig-r025-20230831   gcc  
loongarch            randconfig-r026-20230831   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230831   gcc  
m68k                 randconfig-r013-20230831   gcc  
m68k                 randconfig-r015-20230831   gcc  
m68k                 randconfig-r032-20230831   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230831   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r033-20230831   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r012-20230831   clang
powerpc64            randconfig-r006-20230831   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230831   gcc  
riscv                randconfig-r021-20230831   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230831   clang
s390                 randconfig-r011-20230831   clang
s390                 randconfig-r016-20230831   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r034-20230831   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r005-20230831   gcc  
sparc64              randconfig-r022-20230831   gcc  
sparc64              randconfig-r031-20230831   gcc  
sparc64              randconfig-r035-20230831   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230831   gcc  
x86_64       buildonly-randconfig-002-20230831   gcc  
x86_64       buildonly-randconfig-003-20230831   gcc  
x86_64       buildonly-randconfig-004-20230831   gcc  
x86_64       buildonly-randconfig-005-20230831   gcc  
x86_64       buildonly-randconfig-006-20230831   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230831   clang
x86_64                randconfig-002-20230831   clang
x86_64                randconfig-003-20230831   clang
x86_64                randconfig-004-20230831   clang
x86_64                randconfig-005-20230831   clang
x86_64                randconfig-006-20230831   clang
x86_64                randconfig-011-20230831   gcc  
x86_64                randconfig-012-20230831   gcc  
x86_64                randconfig-013-20230831   gcc  
x86_64                randconfig-014-20230831   gcc  
x86_64                randconfig-015-20230831   gcc  
x86_64                randconfig-016-20230831   gcc  
x86_64                randconfig-071-20230831   gcc  
x86_64                randconfig-072-20230831   gcc  
x86_64                randconfig-073-20230831   gcc  
x86_64                randconfig-074-20230831   gcc  
x86_64                randconfig-075-20230831   gcc  
x86_64                randconfig-076-20230831   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r001-20230831   gcc  
xtensa               randconfig-r002-20230831   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

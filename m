Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE10801B20
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjLBG4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 01:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 01:56:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00F10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701500201; x=1733036201;
  h=date:from:to:cc:subject:message-id;
  bh=ZEks449nlfsTk9VEuHG84oNyrPvRYPZWtk5Z1rPLPR4=;
  b=OY9WmzGWi156XxNxh/Nb/Qz0xcRf+b96/ei1DsUdQ5uaCHm0z5FZjhOI
   /8aovu5CF2k5JqbJxbMORrmT+DZ00ld0gLA762OucCSxUELoiW5/5HZEB
   Kl1ZzGK0EZeMyWL40BuDP52Va3NhCrcBrR+z9ebuWzGowrdS16qaq4Xjh
   rhDL4UqKsR8hfBN77e2VeXAjCEl6ScNjbdA9vF2eEpQejJwmyZroNjowW
   iMxwBEF669HbXQ6lF6Wmh552IELN5ewXBmulpzJJ+6+LiOBn64Iua7jpY
   OwdNRdfoPgDieT67zTA2JgibnUbAuk9BU7mT8rjvNGdUhN4WVPAVho1mI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="373765587"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="373765587"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 22:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1101505316"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="1101505316"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Dec 2023 22:56:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9JvZ-0004mH-2k;
        Sat, 02 Dec 2023 06:56:37 +0000
Date:   Sat, 02 Dec 2023 14:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 1f693ef550f051ef6a95dbfadfa4fbd600769a81
Message-ID: <202312021432.jo7Ecfdd-lkp@intel.com>
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
branch HEAD: 1f693ef550f051ef6a95dbfadfa4fbd600769a81  x86/microcode/intel: Remove redundant microcode late updated message

elapsed time: 734m

configs tested: 117
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231202   gcc  
arc                   randconfig-002-20231202   gcc  
arm                               allnoconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                        realview_defconfig   gcc  
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
i386                                defconfig   gcc  
i386                  randconfig-011-20231202   gcc  
i386                  randconfig-012-20231202   gcc  
i386                  randconfig-013-20231202   gcc  
i386                  randconfig-014-20231202   gcc  
i386                  randconfig-015-20231202   gcc  
i386                  randconfig-016-20231202   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231202   gcc  
loongarch             randconfig-002-20231202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231202   gcc  
nios2                 randconfig-002-20231202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231202   gcc  
parisc                randconfig-002-20231202   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231202   gcc  
s390                  randconfig-002-20231202   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231202   gcc  
sh                    randconfig-002-20231202   gcc  
sh                           se7206_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
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
x86_64       buildonly-randconfig-002-20231202   clang
x86_64       buildonly-randconfig-003-20231202   clang
x86_64       buildonly-randconfig-004-20231202   clang
x86_64       buildonly-randconfig-005-20231202   clang
x86_64       buildonly-randconfig-006-20231202   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231202   clang
x86_64                randconfig-012-20231202   clang
x86_64                randconfig-013-20231202   clang
x86_64                randconfig-014-20231202   clang
x86_64                randconfig-015-20231202   clang
x86_64                randconfig-016-20231202   clang
x86_64                randconfig-071-20231202   clang
x86_64                randconfig-072-20231202   clang
x86_64                randconfig-073-20231202   clang
x86_64                randconfig-074-20231202   clang
x86_64                randconfig-075-20231202   clang
x86_64                randconfig-076-20231202   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231202   gcc  
xtensa                randconfig-002-20231202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

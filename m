Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6148F7A8DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjITUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:31:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C21A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695241898; x=1726777898;
  h=date:from:to:cc:subject:message-id;
  bh=sc8mDMR9bRKv0PinESpT4HqpB0qWJni1P1kT7lNxRG4=;
  b=g7jcbHodDoLkR4xk5Zxcp2BQoPEuGyBbFcGFGYdDELvxYVajyWyjzKUd
   u2GzgGsR2TwHhpqOB9uz203WiwncciE1IiE0nkDOaURNTsAqh7WuLrb68
   ZzdQ0ktWTfjMldLcKUQwEwWkcGLnPz5UNJ21XoqIQz+mQRUQ4WzWu/0YZ
   Q5IP5v9ow2SjXFsSzl6ISqUxMXe8YeaRT3XKtc9wURnbqFajvOJOR5bTZ
   1bjrojEAM6YjXpb1aoNFKhH4zs0YAxbj/MjZeTVnQ1xL7w5q2MqBVFebR
   0b6pXflpuQ2KuECmNghmKvjvkrxFQOqQZnxTMM2r2yQrMOal6h5yUwJD8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359716180"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359716180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 13:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="746788040"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="746788040"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2023 13:31:11 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj3qn-00097u-1p;
        Wed, 20 Sep 2023 20:31:09 +0000
Date:   Thu, 21 Sep 2023 04:30:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 30fb23dc225718f3c1a192aa5f81ae446002bfa7
Message-ID: <202309210413.Y6Rg0F23-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 30fb23dc225718f3c1a192aa5f81ae446002bfa7  Merge branch into tip/master: 'x86/tdx'

elapsed time: 723m

configs tested: 136
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20230920   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230920   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230920   gcc  
i386         buildonly-randconfig-002-20230920   gcc  
i386         buildonly-randconfig-003-20230920   gcc  
i386         buildonly-randconfig-004-20230920   gcc  
i386         buildonly-randconfig-005-20230920   gcc  
i386         buildonly-randconfig-006-20230920   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230920   gcc  
i386                  randconfig-002-20230920   gcc  
i386                  randconfig-003-20230920   gcc  
i386                  randconfig-004-20230920   gcc  
i386                  randconfig-005-20230920   gcc  
i386                  randconfig-006-20230920   gcc  
i386                  randconfig-011-20230920   gcc  
i386                  randconfig-012-20230920   gcc  
i386                  randconfig-013-20230920   gcc  
i386                  randconfig-014-20230920   gcc  
i386                  randconfig-015-20230920   gcc  
i386                  randconfig-016-20230920   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230920   gcc  
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
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230920   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230920   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230920   gcc  
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
x86_64       buildonly-randconfig-001-20230920   gcc  
x86_64       buildonly-randconfig-002-20230920   gcc  
x86_64       buildonly-randconfig-003-20230920   gcc  
x86_64       buildonly-randconfig-004-20230920   gcc  
x86_64       buildonly-randconfig-005-20230920   gcc  
x86_64       buildonly-randconfig-006-20230920   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230920   gcc  
x86_64                randconfig-002-20230920   gcc  
x86_64                randconfig-003-20230920   gcc  
x86_64                randconfig-004-20230920   gcc  
x86_64                randconfig-005-20230920   gcc  
x86_64                randconfig-006-20230920   gcc  
x86_64                randconfig-011-20230920   gcc  
x86_64                randconfig-012-20230920   gcc  
x86_64                randconfig-013-20230920   gcc  
x86_64                randconfig-014-20230920   gcc  
x86_64                randconfig-015-20230920   gcc  
x86_64                randconfig-016-20230920   gcc  
x86_64                randconfig-071-20230920   gcc  
x86_64                randconfig-072-20230920   gcc  
x86_64                randconfig-073-20230920   gcc  
x86_64                randconfig-074-20230920   gcc  
x86_64                randconfig-075-20230920   gcc  
x86_64                randconfig-076-20230920   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BE79027F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350638AbjIATe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIATe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:34:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5645B10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693596893; x=1725132893;
  h=date:from:to:cc:subject:message-id;
  bh=CY4HllyCekYJ0oyibT00JTdhbDJ6dBlhsPWbZMT/Qy0=;
  b=QcinyvE8LxtydyUSKOefHoB1FDdWxOXikXizn2GfGdiHxHG5Yu5rUtm7
   p1dQ8XJ/5zUPwEMyHmJ0PA0sjtZVWhj/HavkXxCEyCrGxvurIZI5vQ1Dk
   NtGAWrbjujmO7Ew8ouxK7JoO8mVpiyfwKqIMhRArEy5WiEJDdqexZ0dOE
   ZS9fXLOhPEvAjhF5Uf7nfN611cLguwlUihza1E4Ecj5eXvN8Ht7vRedNh
   Hf9D3qmNVxHu7lKpVEa+WDRsa0VlKCS7OMVxMw5h3UA3Isisf+D4yJ0r6
   b7qas+1J10m0W3lpyE3AvPvDOC3xW+dDT2VyvvRJRXM/+KdpBDliFYX2g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361315315"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="361315315"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 12:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913805297"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="913805297"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2023 12:34:51 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qc9ur-0001aT-1b;
        Fri, 01 Sep 2023 19:34:49 +0000
Date:   Sat, 02 Sep 2023 03:33:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0560b156615d7187d03d3577da1f56e34b086673
Message-ID: <202309020353.wfeO7lG8-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0560b156615d7187d03d3577da1f56e34b086673  Merge branch into tip/master: 'x86/bugs'

elapsed time: 1298m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230901   gcc  
alpha                randconfig-r026-20230901   gcc  
alpha                randconfig-r032-20230901   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230901   gcc  
arc                  randconfig-r014-20230901   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230901   clang
arm                  randconfig-r012-20230901   clang
arm                  randconfig-r021-20230901   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230901   gcc  
csky                 randconfig-r025-20230901   gcc  
hexagon               randconfig-001-20230901   clang
hexagon               randconfig-002-20230901   clang
hexagon              randconfig-r036-20230901   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230901   clang
i386         buildonly-randconfig-002-20230901   clang
i386         buildonly-randconfig-003-20230901   clang
i386         buildonly-randconfig-004-20230901   clang
i386         buildonly-randconfig-005-20230901   clang
i386         buildonly-randconfig-006-20230901   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230901   clang
i386                  randconfig-002-20230901   clang
i386                  randconfig-003-20230901   clang
i386                  randconfig-004-20230901   clang
i386                  randconfig-005-20230901   clang
i386                  randconfig-006-20230901   clang
i386                  randconfig-011-20230901   gcc  
i386                  randconfig-012-20230901   gcc  
i386                  randconfig-013-20230901   gcc  
i386                  randconfig-014-20230901   gcc  
i386                  randconfig-015-20230901   gcc  
i386                  randconfig-016-20230901   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230901   gcc  
loongarch            randconfig-r035-20230901   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r024-20230901   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230901   gcc  
mips                 randconfig-r006-20230901   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230901   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r015-20230901   gcc  
openrisc             randconfig-r023-20230901   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r016-20230901   gcc  
powerpc64            randconfig-r022-20230901   gcc  
powerpc64            randconfig-r033-20230901   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230901   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230901   gcc  
s390                 randconfig-r031-20230901   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r005-20230901   gcc  
sparc64              randconfig-r013-20230901   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230901   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230901   clang
x86_64       buildonly-randconfig-002-20230901   clang
x86_64       buildonly-randconfig-003-20230901   clang
x86_64       buildonly-randconfig-004-20230901   clang
x86_64       buildonly-randconfig-005-20230901   clang
x86_64       buildonly-randconfig-006-20230901   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230901   gcc  
x86_64                randconfig-002-20230901   gcc  
x86_64                randconfig-003-20230901   gcc  
x86_64                randconfig-004-20230901   gcc  
x86_64                randconfig-005-20230901   gcc  
x86_64                randconfig-006-20230901   gcc  
x86_64                randconfig-011-20230901   clang
x86_64                randconfig-012-20230901   clang
x86_64                randconfig-013-20230901   clang
x86_64                randconfig-014-20230901   clang
x86_64                randconfig-015-20230901   clang
x86_64                randconfig-016-20230901   clang
x86_64                randconfig-071-20230901   clang
x86_64                randconfig-072-20230901   clang
x86_64                randconfig-073-20230901   clang
x86_64                randconfig-074-20230901   clang
x86_64                randconfig-075-20230901   clang
x86_64                randconfig-076-20230901   clang
x86_64               randconfig-r004-20230901   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

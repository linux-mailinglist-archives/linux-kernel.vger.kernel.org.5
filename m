Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFD78E60E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjHaF7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243550AbjHaF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:59:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19685E0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693461552; x=1724997552;
  h=date:from:to:cc:subject:message-id;
  bh=wbHmUpuOPb5H7uqBcIVI1o1L/uHpOvYPbf6gTohfLJM=;
  b=Ey1PgW56u8yj9f1tbPFvZ60Actf+3TzaaQMbPkNwDDFYTPBoKogMrEic
   dNP0MGw1WepMYCyrS0nPexfscHSn4ecbenBtS53d6KNOvPGBdlZsKqT8e
   2nQB1Ey6/PkP8MBP1BZ5nuRV7/joxeAAbJBKiXKQcKe2BS1ABlwQRIgVj
   vLbhBvYwI/8f47RRdfk6MQ44+vOYNQCWlWZZBV/FDYXJYg6MpUirxsY2e
   8FCavA9Elkgar8+9I091pi2cf+i4wP/QqgdwiO/jFac3m3UnO+V91E7t1
   FiZmBCyg08bnUuAgzlBrOyVpcziRLe+ib4QixCWo04aIRIliagolvTL/4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="406817894"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="406817894"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="862890826"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="862890826"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2023 22:59:10 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbahx-000AuM-1R;
        Thu, 31 Aug 2023 05:59:09 +0000
Date:   Thu, 31 Aug 2023 13:58:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 02362c9a99b69aa956f015fa93025221b887684b
Message-ID: <202308311334.6ikOli6r-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 02362c9a99b69aa956f015fa93025221b887684b  Merge tag 'irqchip-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 3970m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230828   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230828   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230828   gcc  
arm                  randconfig-r015-20230828   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230828   gcc  
arm64                randconfig-r036-20230828   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230828   gcc  
csky                 randconfig-r016-20230828   gcc  
csky                 randconfig-r032-20230828   gcc  
hexagon               randconfig-001-20230828   clang
hexagon               randconfig-002-20230828   clang
hexagon              randconfig-r022-20230828   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230828   gcc  
i386         buildonly-randconfig-002-20230828   gcc  
i386         buildonly-randconfig-003-20230828   gcc  
i386         buildonly-randconfig-004-20230828   gcc  
i386         buildonly-randconfig-005-20230828   gcc  
i386         buildonly-randconfig-006-20230828   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230828   gcc  
i386                  randconfig-002-20230828   gcc  
i386                  randconfig-003-20230828   gcc  
i386                  randconfig-004-20230828   gcc  
i386                  randconfig-005-20230828   gcc  
i386                  randconfig-006-20230828   gcc  
i386                  randconfig-011-20230828   clang
i386                  randconfig-012-20230828   clang
i386                  randconfig-013-20230828   clang
i386                  randconfig-014-20230828   clang
i386                  randconfig-015-20230828   clang
i386                  randconfig-016-20230828   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230828   gcc  
loongarch            randconfig-r011-20230828   gcc  
loongarch            randconfig-r033-20230828   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r005-20230828   gcc  
microblaze           randconfig-r014-20230828   gcc  
microblaze           randconfig-r023-20230828   gcc  
microblaze           randconfig-r031-20230828   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230828   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230828   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r024-20230828   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc64            randconfig-r012-20230828   clang
powerpc64            randconfig-r035-20230828   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230828   gcc  
riscv                randconfig-r013-20230828   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230828   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230828   gcc  
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
x86_64       buildonly-randconfig-003-20230829   clang
x86_64       buildonly-randconfig-006-20230829   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230828   clang
x86_64                randconfig-002-20230828   clang
x86_64                randconfig-003-20230828   clang
x86_64                randconfig-004-20230828   clang
x86_64                randconfig-005-20230828   clang
x86_64                randconfig-006-20230828   clang
x86_64                randconfig-011-20230828   gcc  
x86_64                randconfig-012-20230828   gcc  
x86_64                randconfig-013-20230828   gcc  
x86_64                randconfig-014-20230828   gcc  
x86_64                randconfig-015-20230828   gcc  
x86_64                randconfig-016-20230828   gcc  
x86_64                randconfig-071-20230828   gcc  
x86_64                randconfig-072-20230828   gcc  
x86_64                randconfig-073-20230828   gcc  
x86_64                randconfig-074-20230828   gcc  
x86_64                randconfig-075-20230828   gcc  
x86_64                randconfig-076-20230828   gcc  
x86_64               randconfig-r021-20230828   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r001-20230828   gcc  
xtensa               randconfig-r026-20230828   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

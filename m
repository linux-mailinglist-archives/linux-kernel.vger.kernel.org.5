Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10F37AA836
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjIVFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjIVFS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:18:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549D194
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 22:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695359899; x=1726895899;
  h=date:from:to:cc:subject:message-id;
  bh=z92iIMrkFswQ/pSOzt5SmjdTGOZ4XN8hQ8QJHe70vdk=;
  b=Dn7yENesSeW4c3shlBEk+qmU4EyzKD6pjj+olEZZiD20UAvJgzojdAKn
   GF4QIgsE+ZPyLVd1EibWNTwi57prllS1uU0kDoEdWKkmgRoe+gp2jTMs8
   zdRZiGbS57EqE+FXdnDhuRPq30ExWW0rg4fPg6BDOkswLmIkPnVr5ITl7
   EpNnU1huRBVIoVD80xLsmT2qwMbaaO9ouxhiAymo6N0r12BObqbCtal7g
   joc0d5Gau0mpMXtBeqUzMufNLejO6rLdcMQlYz6h+MyGYRpPj0LSqQFFM
   mDYrL1r90xo5nRisVmjkoRp29nf0S9gYKXAA3XJJheqKMPjTQ0/nfKf29
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378034221"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378034221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 22:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="817652891"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="817652891"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2023 22:18:18 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjYYS-00007t-07;
        Fri, 22 Sep 2023 05:18:16 +0000
Date:   Fri, 22 Sep 2023 13:17:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 1632d47fae2f2d229dd432854c4443ebb0bb27a4
Message-ID: <202309221350.3qrnQduY-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 1632d47fae2f2d229dd432854c4443ebb0bb27a4  sched/headers: Standardize the <linux/sched/smt.h> header guard #endif

elapsed time: 1183m

configs tested: 170
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
arc                   randconfig-001-20230921   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230921   gcc  
arm                   randconfig-001-20230922   gcc  
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
i386         buildonly-randconfig-001-20230921   gcc  
i386         buildonly-randconfig-001-20230922   gcc  
i386         buildonly-randconfig-002-20230921   gcc  
i386         buildonly-randconfig-002-20230922   gcc  
i386         buildonly-randconfig-003-20230921   gcc  
i386         buildonly-randconfig-003-20230922   gcc  
i386         buildonly-randconfig-004-20230921   gcc  
i386         buildonly-randconfig-004-20230922   gcc  
i386         buildonly-randconfig-005-20230921   gcc  
i386         buildonly-randconfig-005-20230922   gcc  
i386         buildonly-randconfig-006-20230921   gcc  
i386         buildonly-randconfig-006-20230922   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230921   gcc  
i386                  randconfig-001-20230922   gcc  
i386                  randconfig-002-20230921   gcc  
i386                  randconfig-002-20230922   gcc  
i386                  randconfig-003-20230921   gcc  
i386                  randconfig-003-20230922   gcc  
i386                  randconfig-004-20230921   gcc  
i386                  randconfig-004-20230922   gcc  
i386                  randconfig-005-20230921   gcc  
i386                  randconfig-005-20230922   gcc  
i386                  randconfig-006-20230921   gcc  
i386                  randconfig-006-20230922   gcc  
i386                  randconfig-011-20230921   gcc  
i386                  randconfig-011-20230922   gcc  
i386                  randconfig-012-20230921   gcc  
i386                  randconfig-012-20230922   gcc  
i386                  randconfig-013-20230921   gcc  
i386                  randconfig-013-20230922   gcc  
i386                  randconfig-014-20230921   gcc  
i386                  randconfig-014-20230922   gcc  
i386                  randconfig-015-20230921   gcc  
i386                  randconfig-015-20230922   gcc  
i386                  randconfig-016-20230921   gcc  
i386                  randconfig-016-20230922   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230921   gcc  
loongarch             randconfig-001-20230922   gcc  
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
riscv                 randconfig-001-20230921   gcc  
riscv                 randconfig-001-20230922   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230921   gcc  
s390                  randconfig-001-20230922   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230921   gcc  
sparc                 randconfig-001-20230922   gcc  
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
x86_64       buildonly-randconfig-001-20230921   gcc  
x86_64       buildonly-randconfig-001-20230922   gcc  
x86_64       buildonly-randconfig-002-20230921   gcc  
x86_64       buildonly-randconfig-002-20230922   gcc  
x86_64       buildonly-randconfig-003-20230921   gcc  
x86_64       buildonly-randconfig-003-20230922   gcc  
x86_64       buildonly-randconfig-004-20230921   gcc  
x86_64       buildonly-randconfig-004-20230922   gcc  
x86_64       buildonly-randconfig-005-20230921   gcc  
x86_64       buildonly-randconfig-005-20230922   gcc  
x86_64       buildonly-randconfig-006-20230921   gcc  
x86_64       buildonly-randconfig-006-20230922   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230921   gcc  
x86_64                randconfig-001-20230922   gcc  
x86_64                randconfig-002-20230921   gcc  
x86_64                randconfig-002-20230922   gcc  
x86_64                randconfig-003-20230921   gcc  
x86_64                randconfig-003-20230922   gcc  
x86_64                randconfig-004-20230921   gcc  
x86_64                randconfig-004-20230922   gcc  
x86_64                randconfig-005-20230921   gcc  
x86_64                randconfig-005-20230922   gcc  
x86_64                randconfig-006-20230921   gcc  
x86_64                randconfig-006-20230922   gcc  
x86_64                randconfig-011-20230921   gcc  
x86_64                randconfig-012-20230921   gcc  
x86_64                randconfig-013-20230921   gcc  
x86_64                randconfig-014-20230921   gcc  
x86_64                randconfig-015-20230921   gcc  
x86_64                randconfig-016-20230921   gcc  
x86_64                randconfig-071-20230921   gcc  
x86_64                randconfig-072-20230921   gcc  
x86_64                randconfig-073-20230921   gcc  
x86_64                randconfig-074-20230921   gcc  
x86_64                randconfig-075-20230921   gcc  
x86_64                randconfig-076-20230921   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D579141A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352585AbjIDI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbjIDI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:56:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C9133
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693817809; x=1725353809;
  h=date:from:to:cc:subject:message-id;
  bh=9A8/fXxFm9SgDKY6VMTa5HhO5DQiW/LmO+CU5/tuN+8=;
  b=nq0Hq9E01GCseA1/Qpp53YrbLOyVFEDl2KMRelO2STIwG+smct6HUAvj
   sGmQDyfdellTrNOEJOK/K1joRX2QDFpmUaB82SFMfv1QeJz3/CZFeqH+3
   NTm8qGA3zwWf0o/4wWrUYDPdvFtpv1kHkBgOn/zBzSWphJDBUZcQM1dYT
   KgEp9RaC2Fo15/GNR0nqnp+8wGdcJJ8MEp0VifgeD0Ldy7g/nOwmaZQc9
   5tT+p4vw5tdZxYrtK+Xrvbj3jr9dmUbEt+SwaQnfY+QaCfjYvL0dO4+z/
   Mc69AbI9+Iv7Ew9VJwc3ZyLo+9T1DNmUOMIgjonMLk8UDTo/5Ru67WIuu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462920774"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="462920774"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="855537952"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="855537952"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2023 01:56:48 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qd5O1-0000L1-1A;
        Mon, 04 Sep 2023 08:56:45 +0000
Date:   Mon, 04 Sep 2023 16:56:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cff7aef2e01922906dbdfb50fd5337788628be20
Message-ID: <202309041623.Ypjnu8EG-lkp@intel.com>
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
branch HEAD: cff7aef2e01922906dbdfb50fd5337788628be20  Merge branch into tip/master: 'x86/bugs'

elapsed time: 2422m

configs tested: 181
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230903   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230903   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230903   clang
arm                  randconfig-r015-20230903   clang
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230903   clang
arm64                randconfig-r016-20230903   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230903   gcc  
csky                 randconfig-r011-20230903   gcc  
csky                 randconfig-r023-20230903   gcc  
hexagon               randconfig-001-20230903   clang
hexagon               randconfig-002-20230903   clang
hexagon              randconfig-r021-20230903   clang
hexagon              randconfig-r022-20230903   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230903   clang
i386         buildonly-randconfig-002-20230903   clang
i386         buildonly-randconfig-003-20230903   clang
i386         buildonly-randconfig-004-20230903   clang
i386         buildonly-randconfig-005-20230903   clang
i386         buildonly-randconfig-006-20230903   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230903   clang
i386                  randconfig-002-20230903   clang
i386                  randconfig-003-20230903   clang
i386                  randconfig-004-20230903   clang
i386                  randconfig-005-20230903   clang
i386                  randconfig-006-20230903   clang
i386                  randconfig-011-20230903   gcc  
i386                  randconfig-012-20230903   gcc  
i386                  randconfig-013-20230903   gcc  
i386                  randconfig-014-20230903   gcc  
i386                  randconfig-015-20230903   gcc  
i386                  randconfig-016-20230903   gcc  
i386                 randconfig-r003-20230903   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230903   gcc  
loongarch            randconfig-r004-20230903   gcc  
loongarch            randconfig-r005-20230903   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r031-20230903   gcc  
microblaze           randconfig-r033-20230903   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           ip22_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                   sb1250_swarm_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230903   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r022-20230903   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc              randconfig-r026-20230903   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230903   clang
riscv                randconfig-r014-20230903   gcc  
riscv                randconfig-r026-20230903   gcc  
riscv                randconfig-r036-20230903   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230903   gcc  
s390                 randconfig-r032-20230903   clang
s390                 randconfig-r035-20230903   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r023-20230903   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230903   gcc  
sparc                randconfig-r025-20230903   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r025-20230903   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230903   clang
x86_64       buildonly-randconfig-002-20230903   clang
x86_64       buildonly-randconfig-003-20230903   clang
x86_64       buildonly-randconfig-004-20230903   clang
x86_64       buildonly-randconfig-005-20230903   clang
x86_64       buildonly-randconfig-006-20230903   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230903   gcc  
x86_64                randconfig-002-20230903   gcc  
x86_64                randconfig-003-20230903   gcc  
x86_64                randconfig-004-20230903   gcc  
x86_64                randconfig-005-20230903   gcc  
x86_64                randconfig-006-20230903   gcc  
x86_64                randconfig-011-20230903   clang
x86_64                randconfig-012-20230903   clang
x86_64                randconfig-013-20230903   clang
x86_64                randconfig-014-20230903   clang
x86_64                randconfig-015-20230903   clang
x86_64                randconfig-016-20230903   clang
x86_64                randconfig-071-20230903   clang
x86_64                randconfig-072-20230903   clang
x86_64                randconfig-073-20230903   clang
x86_64                randconfig-074-20230903   clang
x86_64                randconfig-075-20230903   clang
x86_64                randconfig-076-20230903   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r002-20230903   gcc  
xtensa               randconfig-r012-20230903   gcc  
xtensa               randconfig-r021-20230903   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

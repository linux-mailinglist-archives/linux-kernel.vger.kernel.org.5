Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF498789D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjH0LL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjH0LLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:11:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1F109
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134669; x=1724670669;
  h=date:from:to:cc:subject:message-id;
  bh=L5aYuTPQDF0PJtlAXxqF6R7LNTQUVncBbfqrFzQcJCQ=;
  b=JLucYlMJH1v5egjVAiFGUlXcO2ysCFeAAOvdyYcaOJ9jC7NSxP2blYQj
   7F7FyTEVhWtmoXVKz0ahRGZIHU+66jwrn9uBmOVv1tQCY4xWqTyQh1Caj
   BIRDS2VUZdzFKwuvX/ny74hcRRpgG1xXOwBtfbKiadE+kapN2gNHyiR8L
   Enwf2zIW1MXe6nyiX+dcxF4bNlS6csRbSoY+bW9N6SwGK+K88sjj6eVtl
   W/e4anzjyFLLrqhIsvi4DgYn+JSZox67U6NDG2velQWUnpXbepFlkZbrB
   XyyQc2VNGy5e4SQmWoADtMWkz7BSnCHo2Fsc5UETDQiQ0sjuyaK/3SMzO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="372337076"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="372337076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="852503053"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="852503053"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2023 04:11:08 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaDff-0005j4-1P;
        Sun, 27 Aug 2023 11:11:07 +0000
Date:   Sun, 27 Aug 2023 19:10:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 8e6dc5f993a23b40dac1f26abab6a980913c1d24
Message-ID: <202308271916.pAEKi6jP-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 8e6dc5f993a23b40dac1f26abab6a980913c1d24  x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

elapsed time: 2929m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230825   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230825   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230825   clang
arm                  randconfig-r001-20230825   gcc  
arm                  randconfig-r014-20230825   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230825   gcc  
csky                 randconfig-r024-20230826   gcc  
hexagon               randconfig-001-20230825   clang
hexagon               randconfig-002-20230825   clang
hexagon              randconfig-r021-20230826   clang
hexagon              randconfig-r026-20230826   clang
i386         buildonly-randconfig-001-20230825   clang
i386         buildonly-randconfig-002-20230825   clang
i386         buildonly-randconfig-003-20230825   clang
i386         buildonly-randconfig-004-20230825   clang
i386         buildonly-randconfig-005-20230825   clang
i386         buildonly-randconfig-006-20230825   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230825   clang
i386                  randconfig-002-20230825   clang
i386                  randconfig-003-20230825   clang
i386                  randconfig-004-20230825   clang
i386                  randconfig-005-20230825   clang
i386                  randconfig-006-20230825   clang
i386                  randconfig-011-20230825   gcc  
i386                  randconfig-012-20230825   gcc  
i386                  randconfig-013-20230825   gcc  
i386                  randconfig-014-20230825   gcc  
i386                  randconfig-015-20230825   gcc  
i386                  randconfig-016-20230825   gcc  
i386                 randconfig-r023-20230825   gcc  
i386                 randconfig-r034-20230825   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230825   gcc  
loongarch            randconfig-r003-20230825   gcc  
loongarch            randconfig-r035-20230825   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230826   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r016-20230825   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230825   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r031-20230825   gcc  
openrisc             randconfig-r032-20230825   gcc  
openrisc             randconfig-r033-20230825   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230825   gcc  
parisc               randconfig-r021-20230825   gcc  
parisc               randconfig-r025-20230825   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r013-20230825   gcc  
powerpc64            randconfig-r002-20230825   clang
powerpc64            randconfig-r023-20230826   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230825   clang
riscv                randconfig-r025-20230826   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230825   gcc  
s390                 randconfig-r005-20230825   clang
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
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230825   clang
um                   randconfig-r024-20230825   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230825   gcc  
x86_64                randconfig-002-20230825   gcc  
x86_64                randconfig-003-20230825   gcc  
x86_64                randconfig-004-20230825   gcc  
x86_64                randconfig-005-20230825   gcc  
x86_64                randconfig-006-20230825   gcc  
x86_64                randconfig-011-20230825   clang
x86_64                randconfig-012-20230825   clang
x86_64                randconfig-013-20230825   clang
x86_64                randconfig-014-20230825   clang
x86_64                randconfig-015-20230825   clang
x86_64                randconfig-016-20230825   clang
x86_64               randconfig-r036-20230825   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r012-20230825   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162047E727F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbjKITzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjKITzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:55:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5BAE8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699559741; x=1731095741;
  h=date:from:to:cc:subject:message-id;
  bh=hqksKcmTxCxkLhPczsCaPAU1S9XBRAv464ibfAbmvV4=;
  b=Yq4sYgd2Aes9CwtjsEMJU5EaS8XccefdluSZk6VQojCaLUabGM3hh/sm
   +gLyDcOXZV59jedOn8bicIW2P4EV393koq54BL2iJpEW+8xyHXh984UFa
   l34h5IhXxUSTZNFLSJ0wSY8bWSQJ4RwTLcx3jMzc4CqkJmq/rZpUVtCQi
   h64xvzzmssL6hVIrOIZ731ZhMuuRkjLCSQoAOWCiARPoxIHThEfYgjnWn
   uQzRSQ6qRBCWfdfXRYQtzMahE6/gyyMcFCzX8gRtLsUu4cScXRHP/adTN
   4HefY0Z0D1ipALNfw4GRt/GX59GLtAG149XQS5Ser4ju0uWz3jQ+jZZ9M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389869219"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="389869219"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 11:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="767115778"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="767115778"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2023 11:55:40 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1B7q-000962-19;
        Thu, 09 Nov 2023 19:55:38 +0000
Date:   Fri, 10 Nov 2023 03:54:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.11.03a] BUILD SUCCESS
 e8cc1332908682b309968c50157c6b272a0cafae
Message-ID: <202311100337.Rz4YNKz9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.11.03a
branch HEAD: e8cc1332908682b309968c50157c6b272a0cafae  rcu: Force quiescent states only for ongoing grace period

elapsed time: 1446m

configs tested: 220
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
arc                   randconfig-001-20231109   gcc  
arc                   randconfig-002-20231109   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231109   gcc  
arm                   randconfig-001-20231110   gcc  
arm                   randconfig-002-20231109   gcc  
arm                   randconfig-002-20231110   gcc  
arm                   randconfig-003-20231109   gcc  
arm                   randconfig-003-20231110   gcc  
arm                   randconfig-004-20231109   gcc  
arm                   randconfig-004-20231110   gcc  
arm                         socfpga_defconfig   clang
arm                       versatile_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231109   gcc  
arm64                 randconfig-001-20231110   gcc  
arm64                 randconfig-002-20231109   gcc  
arm64                 randconfig-002-20231110   gcc  
arm64                 randconfig-003-20231109   gcc  
arm64                 randconfig-003-20231110   gcc  
arm64                 randconfig-004-20231109   gcc  
arm64                 randconfig-004-20231110   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231109   gcc  
csky                  randconfig-002-20231109   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231109   gcc  
i386         buildonly-randconfig-001-20231110   gcc  
i386         buildonly-randconfig-002-20231109   gcc  
i386         buildonly-randconfig-002-20231110   gcc  
i386         buildonly-randconfig-003-20231109   gcc  
i386         buildonly-randconfig-003-20231110   gcc  
i386         buildonly-randconfig-004-20231109   gcc  
i386         buildonly-randconfig-004-20231110   gcc  
i386         buildonly-randconfig-005-20231109   gcc  
i386         buildonly-randconfig-005-20231110   gcc  
i386         buildonly-randconfig-006-20231109   gcc  
i386         buildonly-randconfig-006-20231110   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231109   gcc  
i386                  randconfig-002-20231109   gcc  
i386                  randconfig-003-20231109   gcc  
i386                  randconfig-004-20231109   gcc  
i386                  randconfig-005-20231109   gcc  
i386                  randconfig-006-20231109   gcc  
i386                  randconfig-011-20231109   gcc  
i386                  randconfig-011-20231110   gcc  
i386                  randconfig-012-20231109   gcc  
i386                  randconfig-012-20231110   gcc  
i386                  randconfig-013-20231109   gcc  
i386                  randconfig-013-20231110   gcc  
i386                  randconfig-014-20231109   gcc  
i386                  randconfig-014-20231110   gcc  
i386                  randconfig-015-20231109   gcc  
i386                  randconfig-015-20231110   gcc  
i386                  randconfig-016-20231109   gcc  
i386                  randconfig-016-20231110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231109   gcc  
loongarch             randconfig-002-20231109   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231109   gcc  
nios2                 randconfig-002-20231109   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231109   gcc  
parisc                randconfig-002-20231109   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231109   gcc  
powerpc               randconfig-001-20231110   gcc  
powerpc               randconfig-002-20231109   gcc  
powerpc               randconfig-002-20231110   gcc  
powerpc               randconfig-003-20231109   gcc  
powerpc               randconfig-003-20231110   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231109   gcc  
powerpc64             randconfig-001-20231110   gcc  
powerpc64             randconfig-002-20231109   gcc  
powerpc64             randconfig-002-20231110   gcc  
powerpc64             randconfig-003-20231109   gcc  
powerpc64             randconfig-003-20231110   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231109   gcc  
riscv                 randconfig-002-20231109   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231109   gcc  
s390                  randconfig-002-20231109   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231109   gcc  
sh                    randconfig-001-20231110   gcc  
sh                    randconfig-002-20231109   gcc  
sh                    randconfig-002-20231110   gcc  
sh                          sdk7786_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231109   gcc  
sparc                 randconfig-001-20231110   gcc  
sparc                 randconfig-002-20231109   gcc  
sparc                 randconfig-002-20231110   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231109   gcc  
sparc64               randconfig-001-20231110   gcc  
sparc64               randconfig-002-20231109   gcc  
sparc64               randconfig-002-20231110   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231109   gcc  
um                    randconfig-001-20231110   gcc  
um                    randconfig-002-20231109   gcc  
um                    randconfig-002-20231110   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231109   gcc  
x86_64       buildonly-randconfig-002-20231109   gcc  
x86_64       buildonly-randconfig-003-20231109   gcc  
x86_64       buildonly-randconfig-004-20231109   gcc  
x86_64       buildonly-randconfig-005-20231109   gcc  
x86_64       buildonly-randconfig-006-20231109   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231109   gcc  
x86_64                randconfig-001-20231110   gcc  
x86_64                randconfig-002-20231109   gcc  
x86_64                randconfig-002-20231110   gcc  
x86_64                randconfig-003-20231109   gcc  
x86_64                randconfig-003-20231110   gcc  
x86_64                randconfig-004-20231109   gcc  
x86_64                randconfig-004-20231110   gcc  
x86_64                randconfig-005-20231109   gcc  
x86_64                randconfig-005-20231110   gcc  
x86_64                randconfig-006-20231109   gcc  
x86_64                randconfig-006-20231110   gcc  
x86_64                randconfig-011-20231109   gcc  
x86_64                randconfig-012-20231109   gcc  
x86_64                randconfig-013-20231109   gcc  
x86_64                randconfig-014-20231109   gcc  
x86_64                randconfig-015-20231109   gcc  
x86_64                randconfig-016-20231109   gcc  
x86_64                randconfig-071-20231109   gcc  
x86_64                randconfig-072-20231109   gcc  
x86_64                randconfig-073-20231109   gcc  
x86_64                randconfig-074-20231109   gcc  
x86_64                randconfig-075-20231109   gcc  
x86_64                randconfig-076-20231109   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231109   gcc  
xtensa                randconfig-001-20231110   gcc  
xtensa                randconfig-002-20231109   gcc  
xtensa                randconfig-002-20231110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

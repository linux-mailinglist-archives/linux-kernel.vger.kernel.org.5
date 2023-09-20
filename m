Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514947A8DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjITUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjITUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:16:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C33CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695240973; x=1726776973;
  h=date:from:to:cc:subject:message-id;
  bh=4UsuexSQmTi3Ns2gUS/7AewEuth/6W/sRMYiwJvqb8I=;
  b=n2n0H/iZQQ/4lVqE6d0utCYidF7nrsrTUdWfboLveKmJiFkQqjudA74j
   o7VhuD9BkA9AluM7DNiA4O84c+sPi24jmljGE1gTabNAY2JBqUgz7OG4p
   rIJvLQjwrxJQWwC5qobLM2L/yRDRaML7/qBrvmuMp5ltMfsbcA2OuhgTy
   ZTJ/PbSsoh657mpKJmFzIJ9WYT61nT2Wvh6MsIQ1hJfwdrZFI3Bj28KOs
   GD9JDP4WY/q99ug7jXXUJnzcHNj7tHyvcn8x1b0WahfveNJBh/3uMrldQ
   waKEsFVur2+nJOC4PRpzGMw5Kdv2EIomBFBZyukpMvhx7Q85tProGiiOE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444426471"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="444426471"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 13:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="993764130"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="993764130"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2023 13:16:11 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj3cH-00097B-0K;
        Wed, 20 Sep 2023 20:16:09 +0000
Date:   Thu, 21 Sep 2023 04:15:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 6d2779ecaeb56f92d7105c56772346c71c88c278
Message-ID: <202309210418.mnYPchgc-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 6d2779ecaeb56f92d7105c56772346c71c88c278  locking/atomic: scripts: fix fallback ifdeffery

elapsed time: 725m

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

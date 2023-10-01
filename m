Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E47B49BF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjJAVa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjJAVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:30:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEA6CE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696195853; x=1727731853;
  h=date:from:to:cc:subject:message-id;
  bh=iws+wTnN/hRbz7mUn450Oss4xTeIHxB6CDe8nGHaU9g=;
  b=K4KW6T7kA22x6E5oxNQD69OiHRMmC0sdUpjMXQJiBeZJ3tct406kunsN
   mqqjUdiwV4H7ubRBM4mAGm+QH26F81pB/XDKjpREhqo9sCov0NiK0nOe8
   jcnvkXrUTaIoYtTGQ86YHyfwj6mIMBF3k+TKPIlu6NvqbQXq6uGoQhn9p
   cUOYt9nY/qFxUmf8ONdAxU21RUlp2DMYMLy0EPIskkfKBFapkUlSpQTb5
   rMFsBY+oQ2NBwuMlpH985WY7Vu7gexwcQOchpsrfhGkbUh8kHFfs53d6p
   KgYOeDUdHNV0ph1Idl67AkfTomQi5i+nL49PaUEz4IWJC5udcOiA5fWm0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372904422"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="372904422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 14:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="866311286"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="866311286"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2023 14:30:51 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qn41Z-0005RB-06;
        Sun, 01 Oct 2023 21:30:49 +0000
Date:   Mon, 02 Oct 2023 05:30:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 18a1f37f57ff28fa544124151ef0171ffdafd162
Message-ID: <202310020528.n6R6n9r4-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 18a1f37f57ff28fa544124151ef0171ffdafd162  Merge branch into tip/master: 'x86/tdx'

elapsed time: 2228m

configs tested: 118
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
arc                   randconfig-001-20230930   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230930   gcc  
arm                   randconfig-001-20231001   gcc  
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
i386         buildonly-randconfig-001-20230930   gcc  
i386         buildonly-randconfig-001-20231001   gcc  
i386         buildonly-randconfig-002-20230930   gcc  
i386         buildonly-randconfig-002-20231001   gcc  
i386         buildonly-randconfig-003-20230930   gcc  
i386         buildonly-randconfig-003-20231001   gcc  
i386         buildonly-randconfig-004-20230930   gcc  
i386         buildonly-randconfig-004-20231001   gcc  
i386         buildonly-randconfig-005-20230930   gcc  
i386         buildonly-randconfig-005-20231001   gcc  
i386         buildonly-randconfig-006-20230930   gcc  
i386         buildonly-randconfig-006-20231001   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230930   gcc  
i386                  randconfig-001-20231001   gcc  
i386                  randconfig-002-20230930   gcc  
i386                  randconfig-002-20231001   gcc  
i386                  randconfig-003-20230930   gcc  
i386                  randconfig-003-20231001   gcc  
i386                  randconfig-004-20230930   gcc  
i386                  randconfig-004-20231001   gcc  
i386                  randconfig-005-20230930   gcc  
i386                  randconfig-005-20231001   gcc  
i386                  randconfig-006-20230930   gcc  
i386                  randconfig-006-20231001   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230930   gcc  
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
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
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
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231001   gcc  
x86_64                randconfig-002-20231001   gcc  
x86_64                randconfig-003-20231001   gcc  
x86_64                randconfig-004-20231001   gcc  
x86_64                randconfig-005-20231001   gcc  
x86_64                randconfig-006-20231001   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

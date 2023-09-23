Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832AA7ABCE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjIWA4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjIWA4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:56:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F96B9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695430568; x=1726966568;
  h=date:from:to:cc:subject:message-id;
  bh=CQdolf7hggoxQ7hYq5HS/d/IsX6Kjmt2aopQco29Fyw=;
  b=K/+CDmd14xcw81kUBQD2x68f54sl19FmMcsfERPdB9XCeCwOqVIZPo/d
   yT7ah8NR2E4kkDtGTnNf4q6TZif41FlZ/P1H0uQc7p5JFbkPVM/gsxZJq
   cCJepwZ6U/BgiyqITmZ9mVMmLI/2C07hbd6qMA6s6ejTTM0DlSe4RIBK8
   hiyFuck4prJsydPqiqU9gmEQdpxYdUWbdVMBvTOeabLDPTv2hz/Qe1QtG
   YOuPpGTMO6RSGVNAc3jmf2Hv117QULH/lBiMVOlEqVUR9OSmsD8v7/CMe
   W3LZuJ2LjubQ+WY3UaVo6+ciBVHjvlukUMSP8YxhA29Etewu3XbfSC/VY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="361225231"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="361225231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 17:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="871442102"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="871442102"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Sep 2023 17:56:06 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjqw5-0001XF-36;
        Sat, 23 Sep 2023 00:56:03 +0000
Date:   Sat, 23 Sep 2023 08:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 7deda2ce5b33edc6d689e429e3fe75382468b030
Message-ID: <202309230810.1QoyoyJv-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 7deda2ce5b33edc6d689e429e3fe75382468b030  x86/cpu: Clear SVM feature if disabled by BIOS

elapsed time: 917m

configs tested: 182
configs skipped: 107

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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20230923   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230923   gcc  
arm                        shmobile_defconfig   gcc  
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
i386         buildonly-randconfig-001-20230922   gcc  
i386         buildonly-randconfig-001-20230923   gcc  
i386         buildonly-randconfig-002-20230922   gcc  
i386         buildonly-randconfig-002-20230923   gcc  
i386         buildonly-randconfig-003-20230922   gcc  
i386         buildonly-randconfig-003-20230923   gcc  
i386         buildonly-randconfig-004-20230922   gcc  
i386         buildonly-randconfig-004-20230923   gcc  
i386         buildonly-randconfig-005-20230922   gcc  
i386         buildonly-randconfig-005-20230923   gcc  
i386         buildonly-randconfig-006-20230922   gcc  
i386         buildonly-randconfig-006-20230923   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230922   gcc  
i386                  randconfig-001-20230923   gcc  
i386                  randconfig-002-20230922   gcc  
i386                  randconfig-002-20230923   gcc  
i386                  randconfig-003-20230922   gcc  
i386                  randconfig-003-20230923   gcc  
i386                  randconfig-004-20230922   gcc  
i386                  randconfig-004-20230923   gcc  
i386                  randconfig-005-20230922   gcc  
i386                  randconfig-005-20230923   gcc  
i386                  randconfig-006-20230922   gcc  
i386                  randconfig-006-20230923   gcc  
i386                  randconfig-011-20230922   gcc  
i386                  randconfig-011-20230923   gcc  
i386                  randconfig-012-20230922   gcc  
i386                  randconfig-012-20230923   gcc  
i386                  randconfig-013-20230922   gcc  
i386                  randconfig-013-20230923   gcc  
i386                  randconfig-014-20230922   gcc  
i386                  randconfig-014-20230923   gcc  
i386                  randconfig-015-20230922   gcc  
i386                  randconfig-015-20230923   gcc  
i386                  randconfig-016-20230922   gcc  
i386                  randconfig-016-20230923   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230923   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                     cu1000-neo_defconfig   clang
mips                           ip27_defconfig   clang
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
powerpc                     asp8347_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc64                           defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230923   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230923   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230923   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230922   gcc  
x86_64       buildonly-randconfig-001-20230923   gcc  
x86_64       buildonly-randconfig-002-20230922   gcc  
x86_64       buildonly-randconfig-002-20230923   gcc  
x86_64       buildonly-randconfig-003-20230922   gcc  
x86_64       buildonly-randconfig-003-20230923   gcc  
x86_64       buildonly-randconfig-004-20230922   gcc  
x86_64       buildonly-randconfig-004-20230923   gcc  
x86_64       buildonly-randconfig-005-20230922   gcc  
x86_64       buildonly-randconfig-005-20230923   gcc  
x86_64       buildonly-randconfig-006-20230922   gcc  
x86_64       buildonly-randconfig-006-20230923   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230922   gcc  
x86_64                randconfig-001-20230923   gcc  
x86_64                randconfig-002-20230922   gcc  
x86_64                randconfig-002-20230923   gcc  
x86_64                randconfig-003-20230922   gcc  
x86_64                randconfig-003-20230923   gcc  
x86_64                randconfig-004-20230922   gcc  
x86_64                randconfig-004-20230923   gcc  
x86_64                randconfig-005-20230922   gcc  
x86_64                randconfig-005-20230923   gcc  
x86_64                randconfig-006-20230922   gcc  
x86_64                randconfig-006-20230923   gcc  
x86_64                randconfig-011-20230923   gcc  
x86_64                randconfig-012-20230923   gcc  
x86_64                randconfig-013-20230923   gcc  
x86_64                randconfig-014-20230923   gcc  
x86_64                randconfig-015-20230923   gcc  
x86_64                randconfig-016-20230923   gcc  
x86_64                randconfig-071-20230922   gcc  
x86_64                randconfig-071-20230923   gcc  
x86_64                randconfig-072-20230922   gcc  
x86_64                randconfig-072-20230923   gcc  
x86_64                randconfig-073-20230922   gcc  
x86_64                randconfig-073-20230923   gcc  
x86_64                randconfig-074-20230922   gcc  
x86_64                randconfig-074-20230923   gcc  
x86_64                randconfig-075-20230922   gcc  
x86_64                randconfig-075-20230923   gcc  
x86_64                randconfig-076-20230922   gcc  
x86_64                randconfig-076-20230923   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

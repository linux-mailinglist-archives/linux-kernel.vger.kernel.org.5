Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E348D7D59AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjJXRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:25:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9712C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698168322; x=1729704322;
  h=date:from:to:cc:subject:message-id;
  bh=QYlfxnZSYTpsWBL5Z49ax7tFsR5gSsVgNL1jzOmMO9M=;
  b=fO/beSJUffeSsbwl/avcCFS1rEhSSFf6zD/eV4+/ZDtA3jSHUK7oLnq7
   9izHxge+C182AgCUyqsqEumd13NFuJ55bV55TyDvP5mep4RjKqiZWhgX0
   YXsVlOLuxhVuVLx8KeFou6DpKUANQiEIYjz2r1GwPyRWnl+MR/3VbT3t8
   osqeGyChU589DB5Ku/HFcT5tsqRG5cNiFvMgGxFYyEaR4Y3ALjoSlL9ro
   dh3DYrqdnIxGzqATZ2QSXxEtshRC3mFxOuTtgpO0B0mqYGuxHfaK7PpZ3
   3kFgCF5RICTr5BB8PNuYphbv8iGeCGW4RfHQqAAN3p/t/I8FZ+RucFWWd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="367340902"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="367340902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 10:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902264655"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902264655"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2023 10:22:53 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvL9U-00085K-05;
        Tue, 24 Oct 2023 17:25:12 +0000
Date:   Wed, 25 Oct 2023 01:24:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 9d9c22cc444af01ce254872b729af26864c43a3a
Message-ID: <202310250137.nAycGSX2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 9d9c22cc444af01ce254872b729af26864c43a3a  x86/retpoline: Document some thunk handling aspects

elapsed time: 6097m

configs tested: 193
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
arc                   randconfig-001-20231021   gcc  
arc                   randconfig-001-20231024   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231022   gcc  
arm                   randconfig-001-20231024   gcc  
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
i386         buildonly-randconfig-001-20231022   gcc  
i386         buildonly-randconfig-001-20231024   gcc  
i386         buildonly-randconfig-002-20231022   gcc  
i386         buildonly-randconfig-002-20231024   gcc  
i386         buildonly-randconfig-003-20231022   gcc  
i386         buildonly-randconfig-003-20231024   gcc  
i386         buildonly-randconfig-004-20231022   gcc  
i386         buildonly-randconfig-004-20231024   gcc  
i386         buildonly-randconfig-005-20231022   gcc  
i386         buildonly-randconfig-005-20231024   gcc  
i386         buildonly-randconfig-006-20231022   gcc  
i386         buildonly-randconfig-006-20231024   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231022   gcc  
i386                  randconfig-001-20231024   gcc  
i386                  randconfig-002-20231022   gcc  
i386                  randconfig-002-20231024   gcc  
i386                  randconfig-003-20231022   gcc  
i386                  randconfig-003-20231024   gcc  
i386                  randconfig-004-20231022   gcc  
i386                  randconfig-004-20231024   gcc  
i386                  randconfig-005-20231022   gcc  
i386                  randconfig-005-20231024   gcc  
i386                  randconfig-006-20231022   gcc  
i386                  randconfig-006-20231024   gcc  
i386                  randconfig-011-20231022   gcc  
i386                  randconfig-011-20231024   gcc  
i386                  randconfig-012-20231022   gcc  
i386                  randconfig-012-20231024   gcc  
i386                  randconfig-013-20231022   gcc  
i386                  randconfig-013-20231024   gcc  
i386                  randconfig-014-20231022   gcc  
i386                  randconfig-014-20231024   gcc  
i386                  randconfig-015-20231022   gcc  
i386                  randconfig-015-20231024   gcc  
i386                  randconfig-016-20231022   gcc  
i386                  randconfig-016-20231024   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231021   gcc  
loongarch             randconfig-001-20231024   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
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
powerpc                     rainier_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231021   gcc  
riscv                 randconfig-001-20231023   gcc  
riscv                 randconfig-001-20231024   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231021   gcc  
s390                  randconfig-001-20231023   gcc  
s390                  randconfig-001-20231024   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231022   gcc  
sparc                 randconfig-001-20231024   gcc  
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
x86_64       buildonly-randconfig-001-20231021   gcc  
x86_64       buildonly-randconfig-001-20231024   gcc  
x86_64       buildonly-randconfig-002-20231021   gcc  
x86_64       buildonly-randconfig-002-20231024   gcc  
x86_64       buildonly-randconfig-003-20231021   gcc  
x86_64       buildonly-randconfig-003-20231024   gcc  
x86_64       buildonly-randconfig-004-20231021   gcc  
x86_64       buildonly-randconfig-004-20231024   gcc  
x86_64       buildonly-randconfig-005-20231021   gcc  
x86_64       buildonly-randconfig-005-20231024   gcc  
x86_64       buildonly-randconfig-006-20231021   gcc  
x86_64       buildonly-randconfig-006-20231024   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231022   gcc  
x86_64                randconfig-001-20231024   gcc  
x86_64                randconfig-002-20231022   gcc  
x86_64                randconfig-002-20231024   gcc  
x86_64                randconfig-003-20231022   gcc  
x86_64                randconfig-003-20231024   gcc  
x86_64                randconfig-004-20231022   gcc  
x86_64                randconfig-004-20231024   gcc  
x86_64                randconfig-005-20231022   gcc  
x86_64                randconfig-005-20231024   gcc  
x86_64                randconfig-006-20231022   gcc  
x86_64                randconfig-006-20231024   gcc  
x86_64                randconfig-011-20231023   gcc  
x86_64                randconfig-011-20231024   gcc  
x86_64                randconfig-012-20231023   gcc  
x86_64                randconfig-012-20231024   gcc  
x86_64                randconfig-013-20231023   gcc  
x86_64                randconfig-013-20231024   gcc  
x86_64                randconfig-014-20231023   gcc  
x86_64                randconfig-014-20231024   gcc  
x86_64                randconfig-015-20231023   gcc  
x86_64                randconfig-015-20231024   gcc  
x86_64                randconfig-016-20231023   gcc  
x86_64                randconfig-016-20231024   gcc  
x86_64                randconfig-071-20231024   gcc  
x86_64                randconfig-072-20231024   gcc  
x86_64                randconfig-073-20231024   gcc  
x86_64                randconfig-074-20231024   gcc  
x86_64                randconfig-075-20231022   gcc  
x86_64                randconfig-075-20231024   gcc  
x86_64                randconfig-076-20231022   gcc  
x86_64                randconfig-076-20231024   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

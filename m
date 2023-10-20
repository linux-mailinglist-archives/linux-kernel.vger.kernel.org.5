Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18097D073A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbjJTDww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjJTDwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:52:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F8E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697773967; x=1729309967;
  h=date:from:to:cc:subject:message-id;
  bh=UlEJDhHazDDe+VMgQ9iipcWdmkC8BDCVW5/uMuqscPw=;
  b=I4RmydEDuhb+d9TivYL1/ZNZH+7FxgFfymbum5holT6urz9r3PkMbP9j
   sjF3xSPYpPw2uIUkKTegEjYoS9W3hXWkqXB5QZl2RRGZrCiGBRaKKK22z
   7VQwU8EZUqG2QUV/Aqn+1jRsVFm0qjshwKylW70+g4S+N9lNv1y8Sb4v2
   gnmAw+sATBSpQ49sH3oHPmYtsEe59eYJQISMGDa3SzcR4yCD97N6vi93/
   9ll8jyjwUJbgi7DGQoqqxmY8bzpOAMcuJdCBUzf/sE/fR+rWbB+gGhu97
   686oztzPJN3kmqVljhM2ix8bkKjFltfhKiXePmrTuCMACqpGYvd0aNnvF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383636797"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="383636797"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750776708"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750776708"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2023 20:52:46 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtgZ1-0002xe-2T;
        Fri, 20 Oct 2023 03:52:43 +0000
Date:   Fri, 20 Oct 2023 11:51:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52
Message-ID: <202310201145.mpkLAJwd-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52  x86/boot: efistub: Assign global boot_params variable

elapsed time: 2473m

configs tested: 132
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
arc                   randconfig-001-20231018   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231019   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231019   gcc  
i386         buildonly-randconfig-002-20231019   gcc  
i386         buildonly-randconfig-003-20231019   gcc  
i386         buildonly-randconfig-004-20231019   gcc  
i386         buildonly-randconfig-005-20231019   gcc  
i386         buildonly-randconfig-006-20231019   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231019   gcc  
i386                  randconfig-002-20231019   gcc  
i386                  randconfig-003-20231019   gcc  
i386                  randconfig-004-20231019   gcc  
i386                  randconfig-005-20231019   gcc  
i386                  randconfig-006-20231019   gcc  
i386                  randconfig-011-20231019   gcc  
i386                  randconfig-012-20231019   gcc  
i386                  randconfig-013-20231019   gcc  
i386                  randconfig-014-20231019   gcc  
i386                  randconfig-015-20231019   gcc  
i386                  randconfig-016-20231019   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231018   gcc  
loongarch             randconfig-001-20231019   gcc  
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
riscv                 randconfig-001-20231018   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231018   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231018   gcc  
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
x86_64       buildonly-randconfig-001-20231019   gcc  
x86_64       buildonly-randconfig-002-20231019   gcc  
x86_64       buildonly-randconfig-003-20231019   gcc  
x86_64       buildonly-randconfig-004-20231019   gcc  
x86_64       buildonly-randconfig-005-20231019   gcc  
x86_64       buildonly-randconfig-006-20231019   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231018   gcc  
x86_64                randconfig-002-20231018   gcc  
x86_64                randconfig-003-20231018   gcc  
x86_64                randconfig-004-20231018   gcc  
x86_64                randconfig-005-20231018   gcc  
x86_64                randconfig-006-20231018   gcc  
x86_64                randconfig-011-20231020   gcc  
x86_64                randconfig-012-20231020   gcc  
x86_64                randconfig-013-20231020   gcc  
x86_64                randconfig-014-20231020   gcc  
x86_64                randconfig-015-20231020   gcc  
x86_64                randconfig-016-20231020   gcc  
x86_64                randconfig-071-20231020   gcc  
x86_64                randconfig-072-20231020   gcc  
x86_64                randconfig-073-20231020   gcc  
x86_64                randconfig-074-20231020   gcc  
x86_64                randconfig-075-20231020   gcc  
x86_64                randconfig-076-20231020   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

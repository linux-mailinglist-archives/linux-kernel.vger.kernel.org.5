Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804B75E4BE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGWUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:08:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED2E67
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690142910; x=1721678910;
  h=date:from:to:cc:subject:message-id;
  bh=+rypUmJTRlfyugrEY3siD8oocVfTrsXLDlP6DYxRigo=;
  b=bcpMXd7rrtOTsa87s1o2Jat3TLgstdImCM1hez7AMi4PHokoH+aHG+YV
   MgCRVhY0wqLQ7n8F0dzcAtg7nf8Znx4gBEilN8RWIaAFBAOULunZ+nj5Z
   Nj/2xzkmQ12L1eEEXuOVevr2ySrG/jYPc38iYzyUeIvuzjeE/MqJj8j6p
   z4qrFP0laTA7/hSeXOZn2Hnk0XYI5Ph0BAO07Up4fWl7l5xM/tbobTWVe
   lBxMNvHCEHtZH3yIL3S2Wdx2x8Krj70X9IMsc0vFTuZpJ+5FwPl1wRtO0
   4/EDGK3lagJbC1EdkekBk201XPGdOTHHvOHNLxcSRIgeI7EgSTyNrP+2Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364764343"
X-IronPort-AV: E=Sophos;i="6.01,227,1684825200"; 
   d="scan'208";a="364764343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 13:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760562281"
X-IronPort-AV: E=Sophos;i="6.01,227,1684825200"; 
   d="scan'208";a="760562281"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2023 13:07:19 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNfM5-0009Dx-1E;
        Sun, 23 Jul 2023 20:07:02 +0000
Date:   Mon, 24 Jul 2023 04:06:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9ce35e0a53a1fdb84a2f6f053ea46f0d1d888fe6
Message-ID: <202307240437.4pvCUovh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9ce35e0a53a1fdb84a2f6f053ea46f0d1d888fe6  Merge branch into tip/master: 'x86/mm'

elapsed time: 724m

configs tested: 112
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230723   gcc  
alpha                randconfig-r015-20230723   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230723   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r046-20230723   clang
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230723   gcc  
hexagon              randconfig-r005-20230723   clang
hexagon              randconfig-r025-20230723   clang
hexagon              randconfig-r041-20230723   clang
hexagon              randconfig-r045-20230723   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230723   clang
i386         buildonly-randconfig-r005-20230723   clang
i386         buildonly-randconfig-r006-20230723   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230723   clang
i386                 randconfig-i002-20230723   clang
i386                 randconfig-i003-20230723   clang
i386                 randconfig-i004-20230723   clang
i386                 randconfig-i005-20230723   clang
i386                 randconfig-i006-20230723   clang
i386                 randconfig-i011-20230723   gcc  
i386                 randconfig-i012-20230723   gcc  
i386                 randconfig-i013-20230723   gcc  
i386                 randconfig-i014-20230723   gcc  
i386                 randconfig-i015-20230723   gcc  
i386                 randconfig-i016-20230723   gcc  
i386                 randconfig-r001-20230723   clang
i386                 randconfig-r023-20230723   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230723   gcc  
loongarch            randconfig-r013-20230723   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze           randconfig-r035-20230723   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230723   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230723   gcc  
parisc               randconfig-r016-20230723   gcc  
parisc               randconfig-r024-20230723   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230723   clang
riscv                randconfig-r042-20230723   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230723   clang
s390                 randconfig-r044-20230723   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230723   gcc  
sh                   randconfig-r031-20230723   gcc  
sh                   randconfig-r034-20230723   gcc  
sh                          rsk7264_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230723   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230723   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230723   clang
x86_64       buildonly-randconfig-r002-20230723   clang
x86_64       buildonly-randconfig-r003-20230723   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230723   clang
x86_64               randconfig-x001-20230723   gcc  
x86_64               randconfig-x002-20230723   gcc  
x86_64               randconfig-x003-20230723   gcc  
x86_64               randconfig-x004-20230723   gcc  
x86_64               randconfig-x005-20230723   gcc  
x86_64               randconfig-x006-20230723   gcc  
x86_64               randconfig-x011-20230723   clang
x86_64               randconfig-x012-20230723   clang
x86_64               randconfig-x013-20230723   clang
x86_64               randconfig-x014-20230723   clang
x86_64               randconfig-x015-20230723   clang
x86_64               randconfig-x016-20230723   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

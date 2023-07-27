Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B376450F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjG0Ety (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjG0Etv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:49:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C777E2116
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690433390; x=1721969390;
  h=date:from:to:cc:subject:message-id;
  bh=fuNS/SiM9mMJqkrS6jI9mXIPbinWE6OeUSKMomTQMgE=;
  b=ZGg7GAMEK3vUsKADok9M0l5ktZt65+U1MVA2Os+VV21dxF6TwlAT6P/Q
   lqP9nzeavtivnMt3GubFXunS29yHOImVEyQAWcZP6q3hfGRZswekM+FoA
   OzBRlJ5eQVAXqDa+wN4GLdICHs9e9loiuJUxbAqAAtSNH3SiNxRsqUwln
   moA/H7ltWAUT793pzFOLw/f2expwDTSc7tWYCsMCTMWMG3u31BuIH6FRg
   EK9S5xhkSEJbUsBxK4H9URMrZrUUojrHJko+BYzKB6kjhR80bQMfc2mDO
   GMqTzs5vsFmcdKjYTrlFheb/d21GV3FXY5iSUCjwuypGtxiYqS9kgfv3/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365664400"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="365664400"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 21:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726801434"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="726801434"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 21:49:48 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOswd-0001ux-2R;
        Thu, 27 Jul 2023 04:49:47 +0000
Date:   Thu, 27 Jul 2023 12:49:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3f3422d644e12169456bbf141d685a6ae4c12fa6
Message-ID: <202307271223.EqqggO3M-lkp@intel.com>
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
branch HEAD: 3f3422d644e12169456bbf141d685a6ae4c12fa6  Merge branch into tip/master: 'x86/mm'

elapsed time: 1271m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230726   gcc  
alpha                randconfig-r032-20230726   gcc  
alpha                randconfig-r034-20230726   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230726   gcc  
arc                  randconfig-r043-20230726   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230726   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230726   clang
csky                                defconfig   gcc  
csky                 randconfig-r016-20230726   gcc  
hexagon              randconfig-r024-20230726   clang
hexagon              randconfig-r033-20230726   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230726   gcc  
i386         buildonly-randconfig-r005-20230726   gcc  
i386         buildonly-randconfig-r006-20230726   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i011-20230726   clang
i386                 randconfig-i012-20230726   clang
i386                 randconfig-i013-20230726   clang
i386                 randconfig-i014-20230726   clang
i386                 randconfig-i015-20230726   clang
i386                 randconfig-i016-20230726   clang
i386                 randconfig-r006-20230726   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230726   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230726   clang
mips                 randconfig-r004-20230726   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230726   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r005-20230726   gcc  
powerpc              randconfig-r013-20230726   clang
powerpc              randconfig-r035-20230726   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230726   clang
riscv                randconfig-r021-20230726   clang
riscv                randconfig-r023-20230726   clang
riscv                randconfig-r031-20230726   gcc  
riscv                randconfig-r042-20230726   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230726   clang
s390                 randconfig-r044-20230726   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230726   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230726   gcc  
x86_64       buildonly-randconfig-r002-20230726   gcc  
x86_64       buildonly-randconfig-r003-20230726   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r036-20230726   gcc  
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x016-20230726   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

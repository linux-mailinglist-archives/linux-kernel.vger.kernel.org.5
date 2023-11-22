Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0E7F3CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjKVENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVENF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:13:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98376195
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700626382; x=1732162382;
  h=date:from:to:cc:subject:message-id;
  bh=ktj2hqXqsT1jGViVzItyIZ/uO2actmZtgPXegUrGt3A=;
  b=lybP2je96SXv7b2+9+H1qzB6quBt1MJQInRZ3mCCh/WjMyav7gryH6sa
   NHqkHD8RlC8By6kz5Bd6EyJrAkzSx7aGjC6829eUh4LN1XTM0zQ75IDyY
   VaW8r+aLE2NvUDiJaMPY8oLeosLzvmIn53unNHErNXTFa7ikvfNO4gxnx
   1kTGrN0SwF2/A4eMKoPK+91TLqfWjg9ram0tx4tilDoJXUeh0cLdKX5Wb
   A9vY8mqWhqra4FTfX2eoJ/t3cccdlOMAtpenZUghwtNQkgiiuzbj2/ua0
   i69qD6nVobhITJXoJAxm0F263GIlh3nr3EYgY1kZny6TVUKkQja660gf9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5174389"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5174389"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 20:13:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098265682"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="1098265682"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2023 20:12:59 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5ebh-0008d9-1U;
        Wed, 22 Nov 2023 04:12:57 +0000
Date:   Wed, 22 Nov 2023 12:06:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 080990aa3344123673f686cda2df0d1b0deee046
Message-ID: <202311221202.NMtgrljA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 080990aa3344123673f686cda2df0d1b0deee046  x86/microcode: Rework early revisions reporting

elapsed time: 738m

configs tested: 85
configs skipped: 139

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                            allyesconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-011-20231122   gcc  
i386                  randconfig-012-20231122   gcc  
i386                  randconfig-013-20231122   gcc  
i386                  randconfig-014-20231122   gcc  
i386                  randconfig-015-20231122   gcc  
i386                  randconfig-016-20231122   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
riscv                             allnoconfig   clang
riscv                          rv32_defconfig   clang
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
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-006-20231122   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231122   clang
x86_64                randconfig-012-20231122   clang
x86_64                randconfig-013-20231122   clang
x86_64                randconfig-014-20231122   clang
x86_64                randconfig-015-20231122   clang
x86_64                randconfig-016-20231122   clang
x86_64                randconfig-071-20231122   clang
x86_64                randconfig-072-20231122   clang
x86_64                randconfig-073-20231122   clang
x86_64                randconfig-074-20231122   clang
x86_64                randconfig-075-20231122   clang
x86_64                randconfig-076-20231122   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6277D4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbjHOU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbjHOU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:56:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E710109
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692132997; x=1723668997;
  h=date:from:to:cc:subject:message-id;
  bh=PAYJmWehecnDZCQ4NNLDGfToi0d1zwV+o78YkBQdcG0=;
  b=hzdm7Zb+Vt2PNAbiak+T1YaJAbPlhMeTyaNk0Uhm7ZFkP7epG6sCHjTR
   dLgf8A5CdFqZfw6cmNKYyRJtAM/imYtln0aO1XnnGkdZCECIacImYDUnV
   OEGHQULye2CwoeCBr/n9u2pzUjt2K/tXk38p3X1ce7OJCnYdMVQhHNzdT
   y8qBNnz/kIWxPXmPFqMfbPSylx3sz3fbq32ZMBHKrB3aPn5seOdTULXCn
   6bJOC+vEE9lRznc5m3TZVZV/2Zfb6H2OhWFMczWSFxTvmppKE5JijDYcw
   oopyOorIoTZlBRlW2vmtH5upchCssk3iQ3X2U73NgZ6kSbi7dGsbhjXWg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369847409"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="369847409"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 13:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="710871347"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="710871347"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2023 13:56:10 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW15F-0001Dt-1t;
        Tue, 15 Aug 2023 20:56:09 +0000
Date:   Wed, 16 Aug 2023 04:55:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 780714930057d26e1c3cdf2e056341a6bf321398
Message-ID: <202308160407.xVQxcZBV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: 780714930057d26e1c3cdf2e056341a6bf321398  Merge branch 'x86/microcode' into x86/merge, to ease integration testing

elapsed time: 721m

configs tested: 89
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230815   gcc  
arc                  randconfig-r043-20230815   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230815   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230815   gcc  
csky                 randconfig-r032-20230816   gcc  
hexagon              randconfig-r036-20230815   clang
hexagon              randconfig-r041-20230815   clang
hexagon              randconfig-r045-20230815   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230815   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230815   clang
i386                 randconfig-i002-20230815   clang
i386                 randconfig-i003-20230815   clang
i386                 randconfig-i004-20230815   clang
i386                 randconfig-i016-20230815   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230815   gcc  
m68k                 randconfig-r031-20230815   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230815   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r033-20230815   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230815   gcc  
powerpc              randconfig-r022-20230815   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230815   clang
riscv                randconfig-r042-20230815   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230815   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230815   gcc  
sparc64              randconfig-r012-20230815   gcc  
sparc64              randconfig-r032-20230815   gcc  
sparc64              randconfig-r035-20230815   gcc  
sparc64              randconfig-r035-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230815   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230815   gcc  
x86_64               randconfig-r023-20230815   gcc  
x86_64               randconfig-r026-20230815   gcc  
x86_64               randconfig-x006-20230815   gcc  
x86_64               randconfig-x011-20230815   clang
x86_64               randconfig-x012-20230815   clang
x86_64               randconfig-x013-20230815   clang
x86_64               randconfig-x014-20230815   clang
x86_64               randconfig-x015-20230815   clang
x86_64               randconfig-x016-20230815   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

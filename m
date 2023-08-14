Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB49477B102
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjHNF75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHNF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:59:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297E1736
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691992759; x=1723528759;
  h=date:from:to:cc:subject:message-id;
  bh=oUZeEQ7SJ7Uwt5EeMBzAqRTuzIaRzwOhcUIrzCIOwhg=;
  b=ZmOmSTiVkoceUPzd8iC5WJlIwuuMOpLKwBOkPpBMTFlZPerTIb0VApa3
   oc1ywsk31QvsF6DAurwp/hKaTrij9W8TpBUqzep2Dgs8AKBagFSrsoihh
   6WM5/IaVWaIqhW2JxD2SxTZtUXV2iD/HmnsANYS2vMspwVn4ChFPGpVpE
   2qQsHQz0v/4jyA43pCUniRIVQIEClDjxc5PKCeZVIvCevgq4g7/6AGQWP
   8lwbZAyQ8nCgHV7QeMnm0p2Eo4DdN4pg/aJTt6wb1xj13YNyoncW4F9gk
   kqCrt3L3GA3U79g6PU8IH5gOAcWpinLzTxLUn3BjRkn0nACr8r/WtI0i5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="370869198"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="370869198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 22:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="823325065"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="823325065"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2023 22:56:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVQZH-0009O0-0D;
        Mon, 14 Aug 2023 05:56:43 +0000
Date:   Mon, 14 Aug 2023 13:56:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 029ae99c8507db15adfae24a15dc44fd568b5f93
Message-ID: <202308141325.Aq1jCPH0-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 029ae99c8507db15adfae24a15dc44fd568b5f93  Merge x86/microcode into tip/master

elapsed time: 720m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230814   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230814   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230814   clang
arm                  randconfig-r023-20230814   gcc  
arm                  randconfig-r024-20230814   gcc  
arm                  randconfig-r046-20230814   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230814   gcc  
arm64                randconfig-r036-20230814   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r004-20230814   clang
hexagon              randconfig-r016-20230814   clang
hexagon              randconfig-r041-20230814   clang
hexagon              randconfig-r045-20230814   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230814   gcc  
i386         buildonly-randconfig-r005-20230814   gcc  
i386         buildonly-randconfig-r006-20230814   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230814   gcc  
i386                 randconfig-i002-20230814   gcc  
i386                 randconfig-i003-20230814   gcc  
i386                 randconfig-i004-20230814   gcc  
i386                 randconfig-i005-20230814   gcc  
i386                 randconfig-i006-20230814   gcc  
i386                 randconfig-i011-20230814   clang
i386                 randconfig-i012-20230814   clang
i386                 randconfig-i013-20230814   clang
i386                 randconfig-i014-20230814   clang
i386                 randconfig-i015-20230814   clang
i386                 randconfig-i016-20230814   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230814   gcc  
loongarch            randconfig-r012-20230814   gcc  
loongarch            randconfig-r014-20230814   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230814   gcc  
m68k                 randconfig-r035-20230814   gcc  
microblaze           randconfig-r011-20230814   gcc  
microblaze           randconfig-r026-20230814   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230814   gcc  
nios2                randconfig-r032-20230814   gcc  
openrisc             randconfig-r003-20230814   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230814   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r031-20230814   gcc  
powerpc              randconfig-r034-20230814   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230814   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230814   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r022-20230814   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230814   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230814   gcc  
x86_64       buildonly-randconfig-r002-20230814   gcc  
x86_64       buildonly-randconfig-r003-20230814   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230814   clang
x86_64               randconfig-x002-20230814   clang
x86_64               randconfig-x003-20230814   clang
x86_64               randconfig-x004-20230814   clang
x86_64               randconfig-x005-20230814   clang
x86_64               randconfig-x006-20230814   clang
x86_64               randconfig-x011-20230814   gcc  
x86_64               randconfig-x012-20230814   gcc  
x86_64               randconfig-x013-20230814   gcc  
x86_64               randconfig-x014-20230814   gcc  
x86_64               randconfig-x015-20230814   gcc  
x86_64               randconfig-x016-20230814   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

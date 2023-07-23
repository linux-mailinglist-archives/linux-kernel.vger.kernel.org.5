Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC075DFDF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 06:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGWEjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 00:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWEjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 00:39:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156FE53
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690087146; x=1721623146;
  h=date:from:to:cc:subject:message-id;
  bh=0jKFbwFqE2QYEwwJ0HNIJqg2yQCpFrfNxLbaLjsC4jI=;
  b=KfnTwlF36vhGJg3GZuHJxxdD0DDVQSKF6HbxGLLUb3niB31tmY6KaCYe
   wz/DoSG2XdBW5/bT3oMOjDSZkLBbS+VMhBWq4xsypjCblfMmiaQECkOEK
   X9MzQGV33F9nDhdUtJ9etuhgJ28M0lCTFfEOzEbKrq6bM1WitZETX3nv1
   4Fto5n4CeGGVzEWQjAHKcOnq1b4w4HlNTdauva6N/U9qm5rtBI5RujIIs
   jcdt+FAOV2dVFmyEfxSQdQ/F3ZtDA/ThOElzV7+aSVBTQ59dxQ+YSDtpR
   grPPmwWgjdI5nTkTxxu4isbfC/sfqnymKGhjOr/6vgN/mgCK9ZIGSHw7y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="398147044"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="398147044"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 21:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="675473595"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="675473595"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2023 21:39:04 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNQs3-0008pj-2R;
        Sun, 23 Jul 2023 04:39:03 +0000
Date:   Sun, 23 Jul 2023 12:38:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 fd470a8beed88440b160d690344fbae05a0b9b1b
Message-ID: <202307231222.O9KNJDOE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: fd470a8beed88440b160d690344fbae05a0b9b1b  x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

elapsed time: 723m

configs tested: 105
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230723   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230723   gcc  
arm                  randconfig-r046-20230723   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230723   clang
csky                                defconfig   gcc  
csky                 randconfig-r036-20230723   gcc  
hexagon              randconfig-r002-20230723   clang
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
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r022-20230723   gcc  
microblaze           randconfig-r033-20230723   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230723   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r016-20230723   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230723   gcc  
parisc               randconfig-r031-20230723   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230723   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230723   gcc  
riscv                randconfig-r021-20230723   gcc  
riscv                randconfig-r023-20230723   gcc  
riscv                randconfig-r042-20230723   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230723   clang
s390                 randconfig-r044-20230723   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230723   gcc  
sh                   randconfig-r034-20230723   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230723   gcc  
sparc                randconfig-r035-20230723   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230723   clang
x86_64       buildonly-randconfig-r002-20230723   clang
x86_64       buildonly-randconfig-r003-20230723   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
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
xtensa               randconfig-r013-20230723   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

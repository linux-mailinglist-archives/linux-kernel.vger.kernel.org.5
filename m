Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839727CB9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjJQEty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:49:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F98F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697518190; x=1729054190;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p9RC1dj6heaHdzZerSgbN+Kzt8JocZDMwbvD01LQEjY=;
  b=QuCTNIpDkVs9kDa9MQ3UmPGyIj5tY+a4lrlDX9XwCliRr3+SybDYUg0e
   xYpqPcQduwfXYe98EwSl5LS5d1QZS0oQQ8fGRFf0DR7lOJeoNj1FNIbuC
   GEkvOk7PVRP7DRjMrtKZDMDOaNxXpeTRSlSbJdCQhpk/xbcr1p3leFYNq
   L6GI0uI59+v05i+R8/+HBTy8At03JcTvqw6na4ykx9W8fA4mp5m8jQIod
   GG+2Ue53upRlvE6kH8fIMyMMw4tF/hQcZocnZKUqes/jGv05ABVYZh0+u
   eF7ZIE+bTHhd8AxuaBr0OPGRv81A8OJLk7t01jXvCp1o6Qj5J+tOmKBbi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365050980"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365050980"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 21:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="791085579"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="791085579"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Oct 2023 21:49:48 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsc1a-00091V-1c;
        Tue, 17 Oct 2023 04:49:46 +0000
Date:   Tue, 17 Oct 2023 12:48:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 7b3d8df549390e797f883efa16224fa0dfe35e55
Message-ID: <202310171202.eNw1pVWA-lkp@intel.com>
User-Agent: s-nail v14.9.24
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sc=
hed/core
branch HEAD: 7b3d8df549390e797f883efa16224fa0dfe35e55  sched/psi: Update po=
ll =3D> rtpoll in relevant=C2=A0comments

elapsed time: 951m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc =20
alpha                            allyesconfig   gcc =20
alpha                               defconfig   gcc =20
arc                              allmodconfig   gcc =20
arc                               allnoconfig   gcc =20
arc                              allyesconfig   gcc =20
arc                                 defconfig   gcc =20
arc                   randconfig-001-20231016   gcc =20
arm                              allmodconfig   gcc =20
arm                               allnoconfig   gcc =20
arm                              allyesconfig   gcc =20
arm                                 defconfig   gcc =20
arm                   randconfig-001-20231016   gcc =20
arm64                            allmodconfig   gcc =20
arm64                             allnoconfig   gcc =20
arm64                            allyesconfig   gcc =20
arm64                               defconfig   gcc =20
csky                             allmodconfig   gcc =20
csky                              allnoconfig   gcc =20
csky                             allyesconfig   gcc =20
csky                                defconfig   gcc =20
i386                             allmodconfig   gcc =20
i386                              allnoconfig   gcc =20
i386                             allyesconfig   gcc =20
i386                              debian-10.3   gcc =20
i386                                defconfig   gcc =20
i386                  randconfig-001-20231016   gcc =20
i386                  randconfig-002-20231016   gcc =20
i386                  randconfig-003-20231016   gcc =20
i386                  randconfig-004-20231016   gcc =20
i386                  randconfig-005-20231016   gcc =20
i386                  randconfig-006-20231016   gcc =20
loongarch                        allmodconfig   gcc =20
loongarch                         allnoconfig   gcc =20
loongarch                        allyesconfig   gcc =20
loongarch                           defconfig   gcc =20
loongarch             randconfig-001-20231016   gcc =20
m68k                             allmodconfig   gcc =20
m68k                              allnoconfig   gcc =20
m68k                             allyesconfig   gcc =20
m68k                                defconfig   gcc =20
microblaze                       allmodconfig   gcc =20
microblaze                        allnoconfig   gcc =20
microblaze                       allyesconfig   gcc =20
microblaze                          defconfig   gcc =20
mips                             allmodconfig   gcc =20
mips                              allnoconfig   gcc =20
mips                             allyesconfig   gcc =20
nios2                            allmodconfig   gcc =20
nios2                             allnoconfig   gcc =20
nios2                            allyesconfig   gcc =20
nios2                               defconfig   gcc =20
openrisc                         allmodconfig   gcc =20
openrisc                          allnoconfig   gcc =20
openrisc                         allyesconfig   gcc =20
openrisc                            defconfig   gcc =20
parisc                           allmodconfig   gcc =20
parisc                            allnoconfig   gcc =20
parisc                           allyesconfig   gcc =20
parisc                              defconfig   gcc =20
parisc64                            defconfig   gcc =20
powerpc                          allmodconfig   gcc =20
powerpc                           allnoconfig   gcc =20
powerpc                          allyesconfig   gcc =20
riscv                            allmodconfig   gcc =20
riscv                             allnoconfig   gcc =20
riscv                            allyesconfig   gcc =20
riscv                               defconfig   gcc =20
riscv                 randconfig-001-20231016   gcc =20
riscv                          rv32_defconfig   gcc =20
s390                             allmodconfig   gcc =20
s390                              allnoconfig   gcc =20
s390                             allyesconfig   gcc =20
s390                                defconfig   gcc =20
s390                  randconfig-001-20231016   gcc =20
sh                               allmodconfig   gcc =20
sh                                allnoconfig   gcc =20
sh                               allyesconfig   gcc =20
sh                                  defconfig   gcc =20
sparc                            allmodconfig   gcc =20
sparc                             allnoconfig   gcc =20
sparc                            allyesconfig   gcc =20
sparc                               defconfig   gcc =20
sparc                 randconfig-001-20231016   gcc =20
sparc64                          allmodconfig   gcc =20
sparc64                          allyesconfig   gcc =20
sparc64                             defconfig   gcc =20
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc =20
um                             i386_defconfig   gcc =20
um                           x86_64_defconfig   gcc =20
x86_64                            allnoconfig   gcc =20
x86_64                           allyesconfig   gcc =20
x86_64                              defconfig   gcc =20
x86_64                randconfig-001-20231016   gcc =20
x86_64                randconfig-002-20231016   gcc =20
x86_64                randconfig-003-20231016   gcc =20
x86_64                randconfig-004-20231016   gcc =20
x86_64                randconfig-005-20231016   gcc =20
x86_64                randconfig-006-20231016   gcc =20
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332AE7F3B49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjKVB1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKVB1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:27:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A1DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700616448; x=1732152448;
  h=date:from:to:cc:subject:message-id;
  bh=99OJhlvcRInDe6GmViQtJy1E2E1sMhvqmsrevrp8SPg=;
  b=Vu8A4r+5nYmvRMnX0m2JOLkjF6sMAk9UMhObfn1nOyHMu7qtNS5W8ecs
   nf5rSxp25JAqTTkBMLKo/0fPhSVOfaP2EAbdt0PbXgE0aekaE59L6/AkF
   6MWBoCqLA8vDGf33mlR1nc91fXR0TV0p1nDzDvZ9uItOY89g0B6HhmiMt
   hh1tZXEY2QFriSd5qlIuyWXYzlbh6imkyKDdoEzVPAqaDKjYZytL6RvPv
   VkJpNfFTTDoiLALBrOHqPA1clGcbcmh84XjBc1hqKe9dwlQyhFMQD6NJp
   BRL953oeTSjQ1QtqF/nkdJkQNiigbRb+GuWHy2ncpKhTeZgtPsgZ6p3qy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372131318"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="372131318"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 17:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857493018"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="857493018"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Nov 2023 17:27:27 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5c1U-0008UQ-2V;
        Wed, 22 Nov 2023 01:27:24 +0000
Date:   Wed, 22 Nov 2023 09:26:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 1e4d3001f59fb7a9917cb746544b65e616b5f809
Message-ID: <202311220944.a9VZ62j5-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: 1e4d3001f59fb7a9917cb746544b65e616b5f809  x86/entry: Harden return-to-user

elapsed time: 734m

configs tested: 42
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                          axs101_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                             rpc_defconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
openrisc                          allnoconfig   gcc  
parisc64                         alldefconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231122   clang
x86_64       buildonly-randconfig-002-20231122   clang
x86_64       buildonly-randconfig-003-20231122   clang
x86_64       buildonly-randconfig-004-20231122   clang
x86_64       buildonly-randconfig-005-20231122   clang
x86_64       buildonly-randconfig-006-20231122   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231122   gcc  
x86_64                randconfig-002-20231122   gcc  
x86_64                randconfig-003-20231122   gcc  
x86_64                randconfig-004-20231122   gcc  
x86_64                randconfig-005-20231122   gcc  
x86_64                randconfig-006-20231122   gcc  
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
x86_64                          rhel-8.3-rust   clang
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

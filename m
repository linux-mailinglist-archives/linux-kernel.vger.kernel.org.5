Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577517B7AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbjJDI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbjJDI6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:58:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB998
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696409924; x=1727945924;
  h=date:from:to:cc:subject:message-id;
  bh=m6USk5RyycUQ2Ah2IpBw6t4KNHnm0GfHzE2MIRH+dlY=;
  b=S9COToFT9Gvi35Q5L5pKhxrAv+hxhRJegPcWns1kpMVsxxzIAPhVpbLu
   KAqZ2RODjLQ5yVDZuQVi8i6OUp56gVxL86OVdfCMXEhz79Y6obGqKi1T+
   s+LjdPq4gEy04DfkBjHe2huZS5RL9Z0n7Qq5cH9Dtv+13gfq8uW0Oq9Yp
   2jBzCrx07UZol8yDOD2nnGeGfZSyY8uj9Oz+Wbftb5S1jFmNqGhVcFvUS
   oQBxJb6AFtBd+EVGjD+Yl0wy925gmpQy+KeoF4QPleTUhvojNLpd0XGqz
   9tUjOba5dvt0NsDm7LdMu3FMvyBtnwQ55LxA3v5Nz+eeLT+GFjOW2zNRO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="373446838"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="373446838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780666476"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="780666476"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2023 01:58:43 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnxiK-000FXK-31;
        Wed, 04 Oct 2023 08:58:40 +0000
Date:   Wed, 04 Oct 2023 16:58:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 90879f5dfcf6cf1d56f4d1b696a25c44e1f5ba14
Message-ID: <202310041628.Qet6Ld6E-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 90879f5dfcf6cf1d56f4d1b696a25c44e1f5ba14  x86/fpu/xstate: Address kernel-doc warning

elapsed time: 726m

configs tested: 28
configs skipped: 102

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231004   gcc  
i386         buildonly-randconfig-002-20231004   gcc  
i386         buildonly-randconfig-003-20231004   gcc  
i386         buildonly-randconfig-004-20231004   gcc  
i386         buildonly-randconfig-005-20231004   gcc  
i386         buildonly-randconfig-006-20231004   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231004   gcc  
i386                  randconfig-002-20231004   gcc  
i386                  randconfig-003-20231004   gcc  
i386                  randconfig-004-20231004   gcc  
i386                  randconfig-005-20231004   gcc  
i386                  randconfig-006-20231004   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231004   gcc  
x86_64                randconfig-002-20231004   gcc  
x86_64                randconfig-003-20231004   gcc  
x86_64                randconfig-004-20231004   gcc  
x86_64                randconfig-005-20231004   gcc  
x86_64                randconfig-006-20231004   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

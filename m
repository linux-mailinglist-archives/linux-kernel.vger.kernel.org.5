Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297FA78045B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357530AbjHRDXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357601AbjHRDWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:22:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46E3A8B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692328965; x=1723864965;
  h=date:from:to:cc:subject:message-id;
  bh=wXOGDjmr/Pf4yR9igCsihd8V2W7giETCEIDD77CEf7w=;
  b=UJoNmOX5r/jghRmYMJ+w9pc90Z1TglGP3gFbUSWR8X1O+h1oiohMRHGw
   fOJJm8eZj2A3fpR1n63fk0qjzvBRLAe92XOncXrc3HpDh/RhQbAccARPJ
   QujkQbtgBrmxpt3HF88N5uVzGq2RCzqP9t/Gfc0BkjtXMBNVkRpouBrCL
   lD6jwkywb26692nnM04q0QJR5hqiqBijfoiM5VTsomKmNXcjI2UtZmxIl
   7bsmW5YT69sWVVs7c5j+4H2nAbdDyIUk7Az8Kt3Ygx2RESWcA8IdA0ZFx
   wcSnlPX1K7JrM1tg9gB89wdd+u77NRe0lOD0MsGOuavNfACyjhm6sg7QT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376756311"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="376756311"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 20:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="734927279"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="734927279"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 20:22:44 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWq4R-00022z-1j;
        Fri, 18 Aug 2023 03:22:43 +0000
Date:   Fri, 18 Aug 2023 11:22:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/shstk] BUILD SUCCESS
 c6cfcbd8ca43766851a8c952e3b570727147020f
Message-ID: <202308181115.LCwGROyD-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/shstk
branch HEAD: c6cfcbd8ca43766851a8c952e3b570727147020f  x86/ibt: Convert IBT selftest to asm

elapsed time: 724m

configs tested: 38
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230818   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230818   gcc  
i386                 randconfig-i002-20230818   gcc  
i386                 randconfig-i003-20230818   gcc  
i386                 randconfig-i004-20230818   gcc  
i386                 randconfig-i005-20230818   gcc  
i386                 randconfig-i006-20230818   gcc  
i386                 randconfig-i011-20230818   clang
i386                 randconfig-i012-20230818   clang
i386                 randconfig-i013-20230818   clang
i386                 randconfig-i014-20230818   clang
i386                 randconfig-i015-20230818   clang
i386                 randconfig-i016-20230818   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230818   clang
x86_64               randconfig-x002-20230818   clang
x86_64               randconfig-x003-20230818   clang
x86_64               randconfig-x004-20230818   clang
x86_64               randconfig-x005-20230818   clang
x86_64               randconfig-x006-20230818   clang
x86_64               randconfig-x011-20230818   gcc  
x86_64               randconfig-x012-20230818   gcc  
x86_64               randconfig-x013-20230818   gcc  
x86_64               randconfig-x014-20230818   gcc  
x86_64               randconfig-x015-20230818   gcc  
x86_64               randconfig-x016-20230818   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

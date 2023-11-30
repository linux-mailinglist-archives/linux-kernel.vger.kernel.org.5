Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60067FE5EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjK3BRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjK3BRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:17:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77C10D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701307060; x=1732843060;
  h=date:from:to:cc:subject:message-id;
  bh=nFFvMLaIFLldpCV6GI8ACx0qw6+liQ4Nb4maVPbGbmk=;
  b=m0HhRSII2+x+CovAaDOabfTI4tQe59pAfnidK1V9IVcw6xWAwCqMseKj
   hcUX2g60fCdEZ6CY1BonsQqQX57r8Qzn1Zp5/ULLSVd9gjZ/0Da/MWSOD
   K/p9bf7NsOjmhBNFYj9xrEG128GTvAV69UIca6BLfttV8447CJ+jPlYfT
   /CCWf4ExblZ67rrIL6sCA1pmFK+D0aS3IH64KFZxSz9b0YTcAwkBKP2HC
   pHjoPBA3nOFgascMH9yOYnv5XY5U0thRfoRBh7e6NvtJLBU1+0MeCZmcZ
   +93ba1ERBGhaaINJsk3z14YBuPim71A43TTxW+YNWoD/P2dDJzGI6zkAX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="150970"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="150970"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:17:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887054403"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887054403"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2023 17:17:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8VgP-0001D3-08;
        Thu, 30 Nov 2023 01:17:37 +0000
Date:   Thu, 30 Nov 2023 09:16:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 346887b65d89ae987698bc1efd8e5536bd180b3f
Message-ID: <202311300952.gmXLdeaP-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 346887b65d89ae987698bc1efd8e5536bd180b3f  Merge x86/cpu into tip/master

elapsed time: 813m

configs tested: 43
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231129   gcc  
i386         buildonly-randconfig-002-20231129   gcc  
i386         buildonly-randconfig-003-20231129   gcc  
i386         buildonly-randconfig-004-20231129   gcc  
i386         buildonly-randconfig-005-20231129   gcc  
i386         buildonly-randconfig-006-20231129   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231129   gcc  
i386                  randconfig-002-20231129   gcc  
i386                  randconfig-003-20231129   gcc  
i386                  randconfig-004-20231129   gcc  
i386                  randconfig-005-20231129   gcc  
i386                  randconfig-006-20231129   gcc  
i386                  randconfig-011-20231129   clang
i386                  randconfig-012-20231129   clang
i386                  randconfig-013-20231129   clang
i386                  randconfig-014-20231129   clang
i386                  randconfig-015-20231129   clang
i386                  randconfig-016-20231129   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231130   gcc  
x86_64       buildonly-randconfig-002-20231130   gcc  
x86_64       buildonly-randconfig-003-20231130   gcc  
x86_64       buildonly-randconfig-004-20231130   gcc  
x86_64       buildonly-randconfig-005-20231130   gcc  
x86_64       buildonly-randconfig-006-20231130   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231130   clang
x86_64                randconfig-002-20231130   clang
x86_64                randconfig-003-20231130   clang
x86_64                randconfig-004-20231130   clang
x86_64                randconfig-005-20231130   clang
x86_64                randconfig-006-20231130   clang
x86_64                randconfig-011-20231130   gcc  
x86_64                randconfig-012-20231130   gcc  
x86_64                randconfig-013-20231130   gcc  
x86_64                randconfig-014-20231130   gcc  
x86_64                randconfig-015-20231130   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

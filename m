Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87278A14D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjH0Tyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjH0Tyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:54:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB701C2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693166084; x=1724702084;
  h=date:from:to:cc:subject:message-id;
  bh=Lvk8Kdp0acgE+o6pqH9dxvohql7K6oElZYa4cootuPM=;
  b=kB5RFOvZMtKHWAfn7v3TwBAuDY6CmfOYl81NfR/TtkNuWu7Xf3G1KwOg
   QkStV1SJTrkBRaL5nEnqDUS2to7PWq97tZJLLQvqxyWYbAqTaAoV2vjFj
   YjaF6KMx8ZpNJ2wFncYp3k9xGbyqgf+98/1SSq50GfjMvHLATCuV2FIVZ
   UJF6Zi/0GcNrs4BcSn8hwyIT/V5nNleA9FRZIuiCjdIFgYjf/QtAGcMx/
   WIWEmS5pLTqKCUm/7vz0HP0UACqeqRSEZXt/rW+UGuKeRJmWhCDELpC19
   YyA2uRAW2jHAMShauVyKtEH9Bk32KVy0v5p3URJD5KBlAhllvqRPCKKb+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="359962246"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="359962246"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 12:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="731608403"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="731608403"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2023 12:54:43 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaLqM-00068r-2d;
        Sun, 27 Aug 2023 19:54:42 +0000
Date:   Mon, 28 Aug 2023 03:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 4d2b748305e96fb76202a0d1072a285b1500bff3
Message-ID: <202308280329.99csCKNF-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 4d2b748305e96fb76202a0d1072a285b1500bff3  x86/microcode: Remove remaining references to CONFIG_MICROCODE_AMD

elapsed time: 1888m

configs tested: 28
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-002-20230826   gcc  
i386                  randconfig-004-20230826   gcc  
i386                  randconfig-015-20230826   clang
i386                  randconfig-016-20230826   clang
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-006-20230826   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230826   clang
x86_64                randconfig-002-20230826   clang
x86_64                randconfig-003-20230826   clang
x86_64                randconfig-004-20230826   clang
x86_64                randconfig-005-20230826   clang
x86_64                randconfig-006-20230826   clang
x86_64                randconfig-011-20230826   gcc  
x86_64                randconfig-012-20230826   gcc  
x86_64                randconfig-014-20230826   gcc  
x86_64                randconfig-071-20230826   gcc  
x86_64                randconfig-072-20230826   gcc  
x86_64                randconfig-073-20230826   gcc  
x86_64                randconfig-074-20230826   gcc  
x86_64                randconfig-075-20230826   gcc  
x86_64                randconfig-076-20230826   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

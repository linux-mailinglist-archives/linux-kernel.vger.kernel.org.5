Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5757CB7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjJQBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJQBEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:04:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38F92
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697504660; x=1729040660;
  h=date:from:to:cc:subject:message-id;
  bh=yL6hemxtXPUl2rp0hHHZU1ozD439PjVxWk9qfFjEJY0=;
  b=PpkbgBi7hc1gwPNym/AOHACxB6SF52XctGzfRoEAfNbtqavRum41fiSF
   3Sj8DcDfemwn0qMJOE/4EZAZTgKqwCcMBi2GNuv+ceHOnzCp2Ee37TrDP
   j38kLp3HAHF0+8enNxQ1exXkofNGe5XtL+0uI1d6RF498hbM6hWn3tWr8
   i7QihifEklMeXu+tCSv/FnDuioWQioVR9M/T8Q1e+3jlcJVO+98vDnIC1
   vy14dbN1udbpB0EdAAAO5tUy1hyldkwAaXBVV1NdvuSkFR3M7MihHOIWY
   F4iCfpPL+gF/mKGxgQb+BByGEgD7KHqN7maVxED7bNyqbLObkNVan0xTz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452151471"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="452151471"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821764936"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="821764936"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2023 18:04:19 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsYVN-0008nz-0o;
        Tue, 17 Oct 2023 01:04:17 +0000
Date:   Tue, 17 Oct 2023 09:04:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 1d10f3aec2bb734b4b594afe8c1bd0aa656a7e4d
Message-ID: <202310170902.KQk27IT3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: 1d10f3aec2bb734b4b594afe8c1bd0aa656a7e4d  x86/percpu: Use C for arch_raw_cpu_ptr(), to improve code generation

elapsed time: 727m

configs tested: 22
configs skipped: 112

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231016   gcc  
i386                  randconfig-002-20231016   gcc  
i386                  randconfig-003-20231016   gcc  
i386                  randconfig-004-20231016   gcc  
i386                  randconfig-005-20231016   gcc  
i386                  randconfig-006-20231016   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231016   gcc  
x86_64                randconfig-002-20231016   gcc  
x86_64                randconfig-003-20231016   gcc  
x86_64                randconfig-004-20231016   gcc  
x86_64                randconfig-005-20231016   gcc  
x86_64                randconfig-006-20231016   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

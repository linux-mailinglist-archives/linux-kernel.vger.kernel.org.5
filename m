Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66D7F6917
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjKWWqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWWqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:46:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2FD50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700779598; x=1732315598;
  h=date:from:to:cc:subject:message-id;
  bh=4E9KTouhRaSq4s9I7iJHbWYLPQHP2AjwbtB7ewWDh1c=;
  b=aa/4yosCpxjis3efdBJcIVjq516QZLZtkb39XR3PwN4tRV8WSbpOuXT4
   8s3iXyg9TknyPY2WUJpsO1YJBVtNbW8UHTTCL/8SB50D/0sgZryuWihj+
   zZ3AAeSvBiemPjAWNBvB3f7YTKRw0s+hraVwE2/H5FCz8mkzglD5e0OJ7
   pOGusiLOgT5VRfrumjOWdWl7Ah3QuoX7J408+Ft0vpfAoAWbLvDXJFIlq
   07i6iaJxNms5FY3RDmaaHjRs/9k6IXhXIQlPLK5PXagaXj7+wGKb4CX25
   eGtLKOJrUTX2OWHtY+gHtAThMh9qhwmxrHnH9SFkIoUL2lX45UnZcio5d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="11009443"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="11009443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 14:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767293025"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="767293025"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 14:46:26 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6ISm-0001qm-0w;
        Thu, 23 Nov 2023 22:46:24 +0000
Date:   Fri, 24 Nov 2023 06:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 5e1c8a47fc6ec6251ddd126f4245279fc072f1c0
Message-ID: <202311240619.Tz5ZaBFY-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 5e1c8a47fc6ec6251ddd126f4245279fc072f1c0  x86/ioapic: Remove unfinished sentence from comment

elapsed time: 738m

configs tested: 8
configs skipped: 154

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

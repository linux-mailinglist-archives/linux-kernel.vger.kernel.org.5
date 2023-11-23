Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDF7F691E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKWWr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjKWWrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:47:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D064CD64
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700779649; x=1732315649;
  h=date:from:to:cc:subject:message-id;
  bh=+iTAJmxQStKvUJMYMrQRVHr5hnunFhXQccU374Zudaw=;
  b=UjXX9FcIBFvW+N7HN3+Iuim0YswZpL/WZKFw9kjicpRdW0PjeWapqsYg
   zeF2Carr3+so0oXZq9NbgvpirpUEGuCE3gvN8lgOMfnBmA8uAdNuPrIPl
   gN+vcXBAXSCtKp/W5muYX3Mk6vFjNAaxtwdJWgxZ+UMAy82TJ3uLEVP8o
   WXSzyTinEwo3UtfvJtjTsIKDhOyzTDLkKZk1wCK2EBF3AAY4RtqEHcGKZ
   +m2czhzvqlFBwEPehinYKWzvnoOaQy6NPLbD5zr545pic+MoLxXpkrycu
   SKatPcez53XenXGiuXM9byfuNWjjW3Kfj0tlE8X5F/2HCbCUnveiKB1uO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5482321"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="5482321"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 14:47:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911270260"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="911270260"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2023 14:47:27 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6ITl-0001qx-0d;
        Thu, 23 Nov 2023 22:47:25 +0000
Date:   Fri, 24 Nov 2023 06:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 03f111710af9ea9cd5a08ecc98e456d1cc0c2284
Message-ID: <202311240649.6p8iloTh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 03f111710af9ea9cd5a08ecc98e456d1cc0c2284  x86/io: Remove the unused 'bw' parameter from the BUILDIO() macro

elapsed time: 739m

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

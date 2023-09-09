Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C387996C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbjIIHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIIHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:42:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DBF199F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694245374; x=1725781374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+hYr2VwfAaLnOctvPWIUIGEy8ustH3dkGynVzIWU0hc=;
  b=lPyjnWgptR0aI3vdckY73OMWJkjhbAgSFQzFrdgXXrXzqzF2ndEXVnRc
   +hdvY+F3xctVSHUs3blEliicx0NpBjkpYsky/eDGtpQdiHj+H3EXcrZzV
   9kH/eipCR9jUxJupqCm6GLl81DFxpcxMkhIN+cbYLsZe9mNGMQ3SusmwO
   B+Adok6ouSYaFbUzMnG6HNVZQdxwdUzxAVdMgPigA/2zfK/B9WX7i5gq+
   3Y2caGp7rKGityUjII9mcEGG1NSN14m2ObKhKMlB4nC/54uBGbIQESw2s
   OzPZ5hi//X9fIA8xc9yTUbtbhPPeqL4Wmkdaxw3OmfIKsfxDIpmeWnDkE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="375175456"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="375175456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 00:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808261401"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="808261401"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2023 00:42:52 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qescE-000363-2R;
        Sat, 09 Sep 2023 07:42:50 +0000
Date:   Sat, 9 Sep 2023 15:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: cc1: warning: arch/xtensa/boot/include: No such file or directory
Message-ID: <202309091516.igMNktIu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 8939c58d68f97ce530f02d46c9f2b56c3ec88399 xtensa: add __umulsidi3 helper
date:   9 months ago
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20230909/202309091516.igMNktIu-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091516.igMNktIu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091516.igMNktIu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> cc1: warning: arch/xtensa/boot/include: No such file or directory [-Wmissing-include-dirs]
--
>> cc1: warning: arch/xtensa/boot/include: No such file or directory [-Wmissing-include-dirs]
>> arch/xtensa/boot/lib/zmem.c:8:6: warning: no previous prototype for 'exit' [-Wmissing-prototypes]
       8 | void exit (void)
         |      ^~~~
>> arch/xtensa/boot/lib/zmem.c:13:7: warning: no previous prototype for 'zalloc' [-Wmissing-prototypes]
      13 | void *zalloc(unsigned size)
         |       ^~~~~~
>> arch/xtensa/boot/lib/zmem.c:35:6: warning: no previous prototype for 'gunzip' [-Wmissing-prototypes]
      35 | void gunzip (void *dst, int dstlen, unsigned char *src, int *lenp)
         |      ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

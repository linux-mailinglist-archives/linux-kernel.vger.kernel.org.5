Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8F7E34D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjKGFTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGFTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:19:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747810D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699334360; x=1730870360;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oADdWft+c+fJAacTcqaU/BhGI3DMHOCU/vGv3xW4hlQ=;
  b=eLaCMtYpCq+t0ZbWPh3PCwkQ1LgW/A9DqiVsV+c7pnRS1zoLu0E2RCVg
   oLRO5HabfJfeEDRHRQrnD8vcBcdF9BOKoe7gNXfm9feu7xrD38ZK6jOrU
   AefI3C7oqFYx/RUZK5a+x+mZuUw3RN4CCuiRY5p/lqXoPm8bBhhDHkT/Z
   bcfNVGLuNKVAm5iyegGV33alXgNdEK/WPyECp6ofHTHSy+rko8jzmcC/Q
   We+JcTGk1eXNpqkn3lQCMBta3x5Zlxk/eNGCH+WH9aulTTZK/HwRgampM
   uxTuxNirpcbvanfZTuBYzE7osvxmVM+VPZR4lyvNb9SaGF4K6cTqe0R6Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2356412"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2356412"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 21:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3691354"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2023 21:19:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0EUd-0006wW-1l;
        Tue, 07 Nov 2023 05:19:15 +0000
Date:   Tue, 7 Nov 2023 13:18:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting
 "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
Message-ID: <202311071303.JJMAOjy4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: 0548448b719ac78fa18fdbcd03856952ba6cc7dc pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar
date:   4 years, 7 months ago
config: mips-buildonly-randconfig-r006-20220821 (https://download.01.org/0day-ci/archive/20231107/202311071303.JJMAOjy4-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071303.JJMAOjy4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311071303.JJMAOjy4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: note: in expansion of macro 'LN1_PIN_GPIO'
     200 | LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
         | ^~~~~~~~~~~~
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: implicit declaration of function 'LOCHNAGAR1_'; did you mean 'LOCHNAGAR1_RST'? [-Werror=implicit-function-declaration]
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: note: in expansion of macro 'LN1_PIN_GPIO'
     200 | LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
         | ^~~~~~~~~~~~
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: initializer element is not constant
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: note: in expansion of macro 'LN1_PIN_GPIO'
     200 | LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
         | ^~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: note: (near initialization for 'lochnagar1_CDC_RESET_pin.reg')
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: note: in expansion of macro 'LN1_PIN_GPIO'
     200 | LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
         | ^~~~~~~~~~~~
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: note: in expansion of macro 'LN1_PIN_GPIO'
     201 | LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
         | ^~~~~~~~~~~~
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: initializer element is not constant
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: note: in expansion of macro 'LN1_PIN_GPIO'
     201 | LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
         | ^~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: note: (near initialization for 'lochnagar1_DSP_RESET_pin.reg')
      52 |         .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
         |                                                     ^~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of macro 'LN_PIN_GPIO'
      67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
         |         ^~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: note: in expansion of macro 'LN1_PIN_GPIO'
     201 | LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
         | ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +52 drivers/pinctrl/cirrus/pinctrl-lochnagar.c

    49	
    50	#define LN_PIN_GPIO(REV, ID, NAME, REG, SHIFT, INVERT) \
    51	static const struct lochnagar_pin lochnagar##REV##_##ID##_pin = { \
  > 52		.name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
    53		.shift = LOCHNAGAR##REV##_##SHIFT##_SHIFT, .invert = INVERT, \
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

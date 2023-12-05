Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44978056F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbjLEOP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbjLEOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:15:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC747A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701785730; x=1733321730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ptF6uPC3RXNrXfApt1E2BWI5duqusn2VDCReRCQ1Psw=;
  b=F4vnXt/aY4q1fy/v0pKhETx444OvchYqVddSxK0mUcF4Zd0CD5ZlU7Wa
   IUSax4bErSUb0NXTyE2w5hmGHZ0ZK/PXNIXzWCQy2NVVoC6QXav0epPuB
   dUXD2Rp+r2y0R0olTJ+E6rC+tNpXreztncOXsuyVx0Md0QvS4TXLnjvAH
   rBTXF9iY8rd+KVjI8F/Co9nz8il9G5InaRa0naMgN9j8k7/nUvZV4Uoz7
   9vLuufKoSV4sS+WOYTBZIQl0awyjXmp6p1rs10ZKYVZHGpjYNxnknfTWf
   /Y1a7z77pPPq1fHcR31ForjZQ1jinQlvGwG5zAXEO/bZe3ANLVD3Gi6+P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="982131"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="982131"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="18975338"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Dec 2023 06:15:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAWCi-00098y-2o;
        Tue, 05 Dec 2023 14:15:16 +0000
Date:   Tue, 5 Dec 2023 22:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/hid/hid-mcp2221.c:1019:3-4: Unneeded semicolon
Message-ID: <202312052224.8IO8gNm0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 960f9df7c620ecb6030aff1d9a6c3d67598b8290 HID: mcp2221: add ADC/DAC support via iio subsystem
date:   1 year, 2 months ago
config: i386-randconfig-053-20231204 (https://download.01.org/0day-ci/archive/20231205/202312052224.8IO8gNm0-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312052224.8IO8gNm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052224.8IO8gNm0-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/hid/hid-mcp2221.c:1019:3-4: Unneeded semicolon

vim +1019 drivers/hid/hid-mcp2221.c

   993	
   994	static int mcp_iio_channels(struct mcp2221 *mcp)
   995	{
   996		int idx, cnt = 0;
   997		bool dac_created = false;
   998	
   999		/* GP0 doesn't have ADC/DAC alternative function */
  1000		for (idx = 1; idx < MCP_NGPIO; idx++) {
  1001			struct iio_chan_spec *chan = &mcp->iio_channels[cnt];
  1002	
  1003			switch (mcp->mode[idx]) {
  1004			case 2:
  1005				chan->address = idx - 1;
  1006				chan->channel = cnt++;
  1007				break;
  1008			case 3:
  1009				/* GP1 doesn't have DAC alternative function */
  1010				if (idx == 1 || dac_created)
  1011					continue;
  1012				/* DAC1 and DAC2 outputs are connected to the same DAC */
  1013				dac_created = true;
  1014				chan->output = 1;
  1015				cnt++;
  1016				break;
  1017			default:
  1018				continue;
> 1019			};
  1020	
  1021			chan->type = IIO_VOLTAGE;
  1022			chan->indexed = 1;
  1023			chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
  1024			chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
  1025			chan->scan_index = -1;
  1026		}
  1027	
  1028		return cnt;
  1029	}
  1030	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

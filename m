Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793A1769FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjGaSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGaSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:00:52 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43F1718
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690826439; x=1722362439;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=QbkxgA/pf/PcX6vqJaarB8VSWiv9u71mrRQ721B6FLc=;
  b=A/KpDU5jnGS9BdVxIFsMIQuSq1U5Gkv1wikQNunAwAulX6wCx0qjE9VK
   rBHMMdJVuXPlmFi6iiB+TRZLutQUjhdD5lYMb04fpCOMMkI+ZEGMgRMTX
   b87vGXMB49H1AAxVOHeeLCZEEXpS2ZLd7otW/vwpMbhKRkGy/YYJjlirN
   e25j8AIYSbQ62Z5mjo4TAwzguVxxeWmIqbQfFnUHrk/TtFNkfLszkHihN
   GpV/zGpIYHGpy3ybKNniroT9sgGPGDo7Zc4FgG1E4b5uiOwkX6ih0BTyS
   oBTSwlD+v80kUA61ipjzohPj5mhN8HylX4VPglgwGJz4H3lKRMwtudOFk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367991676"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="367991676"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 11:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818456913"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="818456913"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2023 11:00:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 00/12] Enable Linear Address Space Separation support
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
Date:   Mon, 31 Jul 2023 21:00:35 +0300
Message-ID: <87wmygx8os.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Changes from v2[5]:
> - Added myself to the SoB chain

Gentle ping.

Regards,
--
Alex

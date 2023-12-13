Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E2811BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjLMR4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjLMR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:56:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D5109;
        Wed, 13 Dec 2023 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702490217; x=1734026217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wWBjSDS0hOcAuYO+J8WAU83sxVHuAQkD3ZNK981aPV0=;
  b=KfQFvesOC6ci3RTN1OT/mjAzkaXqlNCkoTXVirl0Tztko9MfdLdKNVzZ
   l763Hew9KDplP0sbKPpUDjl3dM7m/+rkPIKdgDtBHvvUo5YFE3pORx3eK
   hTynVDUwsoja8YsggwsDM5C35nUNAP5WvuBkwN2/xodcEOvhjX/y+8RCi
   VNBXS+rlT91jcaxLSl+gFo7E9geBqoGTNNVkgAHwc8iX5UrzsgPU3P4YM
   WzGpIp0lgxOQBzl+CEjlVeKfjIClt7KBTwV5J3Z8JVIhlWmZHeEbMkqQC
   QofnvfTqVwF+ahYRDLDKwScKtbB/pubMiKMAn+POzXNfEP3IoQQprCDR9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16552109"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="16552109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105389671"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1105389671"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:56:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDTTY-00000005bHs-2Pqn;
        Wed, 13 Dec 2023 19:56:52 +0200
Date:   Wed, 13 Dec 2023 19:56:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 12/40] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
Message-ID: <ZXnwZHSdxtIaGc3j@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-12-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-12-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:29AM +0300, Nikita Shubin wrote:
> Add OF ID match table.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



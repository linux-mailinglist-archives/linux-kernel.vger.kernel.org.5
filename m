Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5889784406
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjHVOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjHVOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:25:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D9D7;
        Tue, 22 Aug 2023 07:25:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353460779"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="353460779"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 07:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826347329"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="826347329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2023 07:25:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qYSK9-00E9SF-1U;
        Tue, 22 Aug 2023 17:25:37 +0300
Date:   Tue, 22 Aug 2023 17:25:37 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "xingtong.wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "xingtong.wu" <XingTong.Wu@siemens.com>
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Message-ID: <ZOTFYSJ7favaXTiu@smile.fi.intel.com>
References: <20230814073924.1066390-1-arnd@kernel.org>
 <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
 <1834eee9-3fbd-4bea-9e22-960ca993303c@app.fastmail.com>
 <672725bc-6ebf-0a35-96ab-8862be7de193@redhat.com>
 <CAHp75VcR2k=ko4esuO=KNeZRQxeGojTxKeozRGCB+EXrGXgoSQ@mail.gmail.com>
 <6a9b4199-cf2b-9653-5643-89a64a81916c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a9b4199-cf2b-9653-5643-89a64a81916c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 01:11:49PM +0200, Hans de Goede wrote:
> On 8/14/23 17:28, Andy Shevchenko wrote:
> > On Mon, Aug 14, 2023 at 11:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 8/14/23 10:48, Arnd Bergmann wrote:

...

> >> Right P2SB would benefit from being changed into a hidden
> >> symbol.
> > 
> > Yes, I dunno why it wasn't that way from day 1. Perhaps due to the
> > original contribution done by somebody else...
> > 
> >> Andy, any comments on making P2SB a hidden symbol ?
> > 
> > I'm fine with that.
> 
> Ok, can you submit a patch for this please ?

Just sent.

-- 
With Best Regards,
Andy Shevchenko



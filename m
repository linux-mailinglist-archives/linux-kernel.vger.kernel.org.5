Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B981320E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573110AbjLNNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjLNNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:47:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B297137;
        Thu, 14 Dec 2023 05:47:30 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426251469"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="426251469"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105719674"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1105719674"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:47:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1rDm3d-00000005r64-20mK;
        Thu, 14 Dec 2023 15:47:21 +0200
Date:   Thu, 14 Dec 2023 15:47:21 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     George Stark <gnstark@salutedevices.com>
Cc:     Nikita Travkin <nikita@trvn.ru>, pavel@ucw.cz, lee@kernel.org,
        vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hdegoede@redhat.com,
        mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        nikitos.tr@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel@salutedevices.com
Subject: Re: [PATCH v3 04/11] leds: aw2013: use devm API to cleanup module's
 resources
Message-ID: <ZXsHaXOHs5qlKt9g@smile.fi.intel.com>
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-5-gnstark@salutedevices.com>
 <c709e0f33da06db40127f3a0adcbebbd@trvn.ru>
 <fa048fec-86f2-42b5-ad36-7776c569a349@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa048fec-86f2-42b5-ad36-7776c569a349@salutedevices.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:58:56PM +0300, George Stark wrote:
> On 12/14/23 08:42, Nikita Travkin wrote:
> > George Stark писал(а) 14.12.2023 03:30:

...

> > Btw, seems like (5..11)/11 never arrived to the lists...
> 
> Yeah there was a delay, but now all patches from series #3 are online.

Nikita is right. This patch was the last in the mailing lists. Fix your mail
gateways, it quite likely the mail server in your organisation filters out
some mails as spam or so. I highly recommend to escalate this with your IT
department.

-- 
With Best Regards,
Andy Shevchenko



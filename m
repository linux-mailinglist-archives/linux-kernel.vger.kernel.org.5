Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC4A75EDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGXIcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjGXIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:32:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FBA133
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690187511; x=1721723511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M5Gcu/a7aoS622+pui9ZezyikbGDySg+qAew+JOPU94=;
  b=Lxr7143oKaOdWC0ACon5/KRZQJF1c4fqy5iL/+vtfC6FjRnn2VMBtG40
   GDNFXYNxtiesSHDH1S9vN1YSIf08n2TgwhcfehecVadlMNHul46kUs4pg
   at5/IGy5yfTzI8msngDyJVCoV/+PxF6qC9Pvn1YQ19bMjh6NJ8wfB49sd
   6G2d+MTsHv5PpJGh5KCkndRkVGKcRIA9qWLit3LMlQXpW+ZOtH0WHareU
   WDDhbUn+LD4/fKPm+fbZw3WZvjLAwzMMN3Vvv2CIps8WbTAr+3hM4nLf2
   zZH8HHwO1xQWKaXLRpNMNFOadrpIVqpXbgP1GQa3wPJXSi7DokPDhMeNP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366276189"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366276189"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815735938"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815735938"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 01:31:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNqyp-004XSJ-2x;
        Mon, 24 Jul 2023 11:31:47 +0300
Date:   Mon, 24 Jul 2023 11:31:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: kernel-doc additions in cpumask.c
Message-ID: <ZL428z19Fvx+WeRQ@smile.fi.intel.com>
References: <20230724023414.24882-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724023414.24882-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 07:34:14PM -0700, Randy Dunlap wrote:
> Add Return: value for 4 functions.
> Add kernel-doc for cpumask_any_distribute().


Fine, but shouldn't this be folded into the *.h patch?

Either way,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



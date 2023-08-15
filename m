Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847277D09A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjHORHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbjHORGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:06:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9B21737;
        Tue, 15 Aug 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692119210; x=1723655210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tyH/FWy72AFApPV4vzZzcaIgwH0owqHF2uXm6vPj/8A=;
  b=gwuP9pEHmxbXRlYCcR/ZoQqsgZX/rUfHeCrAFJrHXhDUotqGGwJJMW7V
   M+beYXICaHjP/aYj9HJG8r9MSHxKM0Wu+y2N977eiXqVHjGJt/v4eTFQ7
   Rqrs5Vrg2Kp5tv6bWcuKY9KMly+s4lh3Qdupf1P4vIYdb5449/YxhDpms
   xo4EqDXfHsTNpW+xbg48Xff6IcqS21YOVDAa4MrX+1f9HhRCkn9VYYnPA
   egkPrKKfem74n9+ZsraeleVOKngsyhbJCA1wLLC2Ait9GJstmeOiHOCFY
   /iTGS2LZHa+iNfNhL6N58hW6b20p3/OXWcaZbBrWFirIYdvsS2XorZvrQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438671711"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="438671711"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 10:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683728723"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="683728723"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2023 10:04:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVxTC-00AbW9-1E;
        Tue, 15 Aug 2023 20:04:38 +0300
Date:   Tue, 15 Aug 2023 20:04:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] iio: adc: mcp3911: fix indentation
Message-ID: <ZNuwJVSJy0Uy0zPN@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-4-marcus.folkesson@gmail.com>
 <ZNuShXfOoaLk8Ua1@smile.fi.intel.com>
 <ZNuuER3V8etxeu3o@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNuuER3V8etxeu3o@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:55:45PM +0200, Marcus Folkesson wrote:
> On Tue, Aug 15, 2023 at 05:58:13PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 14, 2023 at 02:10:08PM +0200, Marcus Folkesson wrote:
> > > The file does not make use of indentation properly.
> > 
> > > Fix that.
> > 
> > I'm not sure this is anyhow a fix. Yet you may refer to the checkpatch
> > if it complains.
> > 
> > ...
> > 
> > This kind of change is preferred to be the last in the series or closer
> > to the end where no more code changed.
> 
> Checkpatch did never complain about the formatting, but I got a few comments
> during the review process about the formatting, so I went
> through the whole file to fix it once for all.
> 
> I do not think that it has to be the last patch in the series.
> All following patches has proper indentation.
> Pretty much the same as the simplification of spi->dev I think.
> 
> If there is no strong opinions about it I think I will leave it as is.

I'm not a maintainer of IIO, so let them decide :-)

-- 
With Best Regards,
Andy Shevchenko



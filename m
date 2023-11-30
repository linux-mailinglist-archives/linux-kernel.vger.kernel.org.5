Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135B57FEDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjK3LVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjK3LV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:21:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCED1D54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:21:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F20EC433C7;
        Thu, 30 Nov 2023 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701343295;
        bh=NAX56mGLpXw5uJMlSh9lqnmNXCJ2hfJhtUZAindNF3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0yL/cRSIVQpcl6fVvr8mxdMcZW+E5Dg42fs2g3tr5ZHCOCAtKiZpDjEtAg9oHw5L
         f8Viz58ff9taLyf8Rv0ZYqCv3mESK/dKzlp9mfD0xy9dG7P4TEf/q4usMU8oTYXYhf
         Ta0yKvmySjPyZfhHRbRGm2PQpklbO+AJ26Q36vmeqhYBPhct8+iBd+Qw3Sis6bhaGS
         eEsiiVSce8IY1DjQHft76URmCCw49tPdAMzr0BTweoaaKAcKvgrqSiNqQJTYsxs7Ko
         jC7nS8GxJRV3jRb1n1eF4lND8W5cNzDH/4510btFuu7w5KRxiSvXbn3dpoe4pgukwG
         SY3BvtCjonAyg==
Date:   Thu, 30 Nov 2023 11:21:30 +0000
From:   Lee Jones <lee@kernel.org>
To:     GaryWang =?utf-8?B?5rGq5LmL6YC4?= <GaryWang@aaeon.com.tw>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "larry.lai" <larry.lai@yunjingtech.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "musa.lin@yunjingtech.com" <musa.lin@yunjingtech.com>,
        "jack.chang@yunjingtech.com" <jack.chang@yunjingtech.com>,
        "noah.hung@yunjingtech.com" <noah.hung@yunjingtech.com>
Subject: Re: [PATCH V7 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <20231130112130.GH1470173@google.com>
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
 <20231031015119.29756-3-larry.lai@yunjingtech.com>
 <ZVOBz8-tahhrVmO-@smile.fi.intel.com>
 <SI2PR02MB568243153C4D4D7B636D2754EE82A@SI2PR02MB5682.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR02MB568243153C4D4D7B636D2754EE82A@SI2PR02MB5682.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023, GaryWang 汪之逸 wrote:

> All,
>         Reply again to plain text format & line-warp and trim agree part as Jones's suggestion,
>         please let me know if there are still having format issue.
>         please kindly to check our comments with ">>" beginning.

This is still incorrect.

Please fix your mail client, or use a different one.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, November 14, 2023 10:19 PM
> To: larry.lai <larry.lai@yunjingtech.com>
> Cc: lee@kernel.org; linus.walleij@linaro.org; pavel@ucw.cz; linux-kernel@vger.kernel.org; linux-gpio@vger.kernel.org; linux-leds@vger.kernel.org; GaryWang 汪之逸 <GaryWang@aaeon.com.tw>; musa.lin@yunjingtech.com; jack.chang@yunjingtech.com; noah.hung@yunjingtech.com
> Subject: Re: [PATCH V7 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA

Why is your client putting headers in the body?

> On Tue, Oct 31, 2023 at 09:51:18AM +0800, larry.lai wrote:
> > The UP Squared board
> > <http://www.upboard.com/> implements certain features (pin control) through an on-board FPGA.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
> > Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> 
> 
> 
> > +#include "intel/pinctrl-intel.h"
> 
> I do not think it's correct use of the header.
> >> see below

No, this should look like this:

>  <Thing you're replying to here>

[Your response here]

Please fix the client to quote properly and drop the confusing ">>" stuff.

> ...

Make snips clearer please, either:

  [...]

Or:

  [SNIP]

[...]

-- 
Lee Jones [李琼斯]

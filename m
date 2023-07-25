Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77081760B03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjGYG4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGYG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:56:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FC1FBD;
        Mon, 24 Jul 2023 23:56:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7649E80A9;
        Tue, 25 Jul 2023 06:56:14 +0000 (UTC)
Date:   Tue, 25 Jul 2023 09:56:13 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <20230725065613.GY5194@atomide.com>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
 <2023072144-splurge-debate-e681@gregkh>
 <20230721061523.GP5194@atomide.com>
 <20230721065701.GQ5194@atomide.com>
 <2023072109-fidelity-modular-4074@gregkh>
 <20230721071753.GR5194@atomide.com>
 <ZLpZabV4FRgtXGL8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpZabV4FRgtXGL8@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230721 10:10]:
> On Fri, Jul 21, 2023 at 10:17:53AM +0300, Tony Lindgren wrote:
> > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230721 07:07]:
> 
> ...
> 
> > Also I noticed that using git send-email --cc-cover does
> > not work for the cover letter.. It tries to use the first patch that
> > is the cover letter or something like that. I'm going back to my custom
> > email scripts for now rather than try to have git handle things
> > automagically.
> 
> I have my script [1] that shows good enough results to send patches.
> I suggest give it a try :-)

Thanks I'll check if your get_maintainer.pl options help. I was trying
to use .gitconfig [sendemail.linux] style options with git send-email
--identity=linux based on an example Krzysztof posted somewhere a
while back. Sorry could not find it though, maybe Krzysztof has a
link for it.

Regards,

Tony


> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
